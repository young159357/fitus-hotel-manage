import os
import sqlite3


class Database():
    QUERY_PASSWORD = "SELECT PASSWORD\
        FROM LOGIN_INFO\
        WHERE USERNAME = ?"

    QUERY_USER_INFO = "SELECT * FROM USER \
        WHERE USER_ID = \
        (SELECT USER_ID \
        FROM LOGIN_INFO \
        WHERE USERNAME = ?)"

    QUERY_PERMISSIONS = "SELECT PERMISSION_NAME \
        FROM USER \
        JOIN USER_PERMISSION \
        JOIN PERMISSION \
        WHERE USER.USER_ID = \
        (SELECT USER_ID \
        FROM LOGIN_INFO \
        WHERE USERNAME = ?)"

    def __init__(self, dbname: str):
        # A database should be there, we don't want it to be implicitly created
        if os.path.exists(dbname):
            # This is assuming only the server access the database, don't call it from multiple threads
            self.con = sqlite3.connect(dbname, check_same_thread=False)
            self.cur = self.con.cursor()
        else:
            raise Exception("Database doesn't exist")

    def check_credentials(self, username: str, password: str) -> bool:
        self.cur.execute(self.QUERY_PASSWORD, (username, ))
        result = self.cur.fetchone()
        if result is not None:
            return result[0] == password
        else:
            return False

    def get_user_info(self, username: str) -> tuple:
        self.cur.execute(self.QUERY_USER_INFO, (username, ))
        result = self.cur.fetchone()
        return result[1:]  # Exclude user id

    def get_user_permissions(self, username: str) -> tuple:
        self.cur.execute(self.QUERY_PERMISSIONS, (username, ))
        result = self.cur.fetchall()
        if result is not None:
            return (permission[0] for permission in result)
        else:
            return ()

    def close(self):
        self.con.close()