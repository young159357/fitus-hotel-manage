import sqlite3
import json
import os

conection = sqlite3.connect('data.db')
cursor = conection.cursor()

#delete all data in all table
cursor.execute("DELETE FROM HOTEL")
cursor.execute("DELETE FROM USER")
cursor.execute("DELETE FROM PERMISSION")
cursor.execute("DELETE FROM ROOM")
cursor.execute("DELETE FROM ROOM_LOG")
cursor.execute("DELETE FROM ROOM_PERMISSION")
cursor.execute("DELETE FROM USER_PERMISSION")
cursor.execute("DELETE FROM LOGIN_INFO")
cursor.execute("DELETE FROM FURNITURE")

#open TestData.json from .github folder
with open(os.path.join(os.path.dirname(__file__), '..', '..', '.github', 'testcases', 'UsersList.json'), encoding="utf8") as f:
    traffic = json.load(f)

id = 0

for row in traffic:
    cursor.execute("INSERT INTO USER VALUES (?,?,?,?,?,?,?)", (id, row['Name'], row['Phone'], row['Email'], row['Gender'], row['Birthday'], row['Address']))
    cursor.execute("INSERT INTO LOGIN_INFO VALUES (?,?,?)", (id, row['Username'], row['Password']))
    id += 1

with open(os.path.join(os.path.dirname(__file__), '..', '..', '.github', 'testcases', 'RoomsList.json'), encoding="utf8") as f:
    traffic = json.load(f)

for row in traffic:
    cursor.execute("INSERT INTO ROOM VALUES (?,?,?,?)", (row['Room'], row['Room'][0], row['Price'], row['BedNum']))
    Fur = 4*[None]
    for i in range(len(row['InRoom'])):
        Fur[i] = row['InRoom'][i]
    cursor.execute("INSERT INTO FURNITURE VALUES (?,?,?,?,?)", (row['Room'], Fur[0], Fur[1], Fur[2], Fur[3]))


conection.commit()
conection.close()

