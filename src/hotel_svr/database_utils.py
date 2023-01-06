import os
import sqlite3

from pydantic import BaseModel


class UserInfo(BaseModel):
    Name: str
    Phone: str
    Email: str
    Gender: str
    DOB: str
    Address: str


class RoomInfo(BaseModel):
    RoomID: str
    Price: str
    BedNums: str
    Furnitures: list[str]


class HotelInfo(BaseModel):
    HotelName: str
    HotelAddress: str
    Rooms: list[RoomInfo]


class Database():
    QUERY_PASSWORD = "SELECT PASSWORD\
        FROM LOGIN_INFO\
        WHERE USERNAME = ?"

    QUERY_USER_INFO = "SELECT * FROM USER \
        WHERE USER_ID = \
        (SELECT USER_ID \
        FROM LOGIN_INFO \
        WHERE USERNAME = ?)"

    QUERY_USERS = "SELECT USERNAME FROM LOGIN_INFO"

    QUERY_PERMISSIONS = "SELECT PERMISSION_NAME \
        FROM USER_PERMISSION \
        JOIN PERMISSION \
        ON USER_PERMISSION.PERMISSION_ID = PERMISSION.PERMISSION_ID \
        WHERE USER_ID = \
        (SELECT USER_ID \
        FROM LOGIN_INFO \
        WHERE USERNAME = ?)"

    QUERY_HOTELS = "SELECT * \
        FROM HOTEL \
    "

    QUERY_ROOMS = "SELECT * \
        FROM ROOM \
        WHERE HOTEL_ID = ? \
    "

    QUERY_FURNITURES = "SELECT * \
        FROM FURNITURE \
        WHERE ROOM_ID = ? \
    "

    QUERY_LOG = "SELECT* \
        FROM TRANSACTION_LOG \
        WHERE USER_ID = ? \
    "

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

    def get_users(self) -> list:
        self.cur.execute(self.QUERY_USERS)
        query = self.cur.fetchall()
        return [user[0] for user in query]

    def get_user_info(self, username: str) -> tuple:
        self.cur.execute(self.QUERY_USER_INFO, (username, ))
        info = self.cur.fetchone()
        return UserInfo(**{
            key: info[i + 1]
            for i, key in enumerate(UserInfo.__fields__.keys())
        }),

    def get_user_permissions(self, username: str) -> tuple:
        self.cur.execute(self.QUERY_PERMISSIONS, (username, ))
        result = self.cur.fetchall()
        if result is not None:
            return (permission[0] for permission in result)
        else:
            return ()

    def get_hotels_info(self) -> dict:
        result = []

        self.cur.execute(self.QUERY_HOTELS)
        hotels = self.cur.fetchall()
        for hotel in hotels:
            self.cur.execute(self.QUERY_ROOMS, (hotel[0], ))
            rooms = self.cur.fetchall()
            rooms_list = []
            for room in rooms:
                furnitures_list = []
                self.cur.execute(self.QUERY_FURNITURES, (room[0], ))
                furnitures = list(self.cur.fetchone())
                if furnitures is not None:
                    for furniture in furnitures[1:]:
                        if furniture is not None:
                            furnitures_list.append(furniture)
                rooms_list.append(
                    RoomInfo(RoomID=room[0],
                             Price=room[2],
                             BedNums=room[3],
                             Furnitures=furnitures_list))
            result.append(
                HotelInfo(HotelName=hotel[1],
                          HotelAddress=hotel[2],
                          Rooms=rooms_list))

        return result

    def get_log(self, username: str) -> tuple:
        self.cur.execute(self.QUERY_USER_INFO, (username, ))
        user_id = self.cur.fetchone()[0]
        self.cur.execute(self.QUERY_LOG, (user_id, ))
        result = self.cur.fetchall()
        return result

    def close(self):
        self.con.close()