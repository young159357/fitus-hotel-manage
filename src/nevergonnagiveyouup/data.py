import sqlite3
import json
import os

con = sqlite3.connect("data.db")
cur = con.cursor()

# drop everything
cur.execute("DROP TABLE IF EXISTS HOTEL")
cur.execute("DROP TABLE IF EXISTS USER")
cur.execute("DROP TABLE IF EXISTS PERMISSION")
cur.execute("DROP TABLE IF EXISTS ROOM")
cur.execute("DROP TABLE IF EXISTS ROOM_LOG")
cur.execute("DROP TABLE IF EXISTS ROOM_PERMISSION")
cur.execute("DROP TABLE IF EXISTS USER_PERMISSION")
cur.execute("DROP TABLE IF EXISTS LOGIN_INFO")
cur.execute("DROP TABLE IF EXISTS FURNITURE")

# Enable foreign keys
cur.execute("PRAGMA foreign_keys = ON")

#create HOTEL table with Hotel ID as KEY, Services, Location
cur.execute("CREATE TABLE IF NOT EXISTS HOTEL (HOTEL_ID TEXT PRIMARY KEY, SERVICES TEXT, LOCATION TEXT)")

#create USER table with User ID as KEY, Name, Phone, Email, GENDER, DOB, ADDRESS
cur.execute("CREATE TABLE IF NOT EXISTS USER (USER_ID TEXT PRIMARY KEY, NAME TEXT, PHONE TEXT, EMAIL TEXT, GENDER TEXT, DOB TEXT,  ADDRESS TEXT)")

#create PERMISSION table with PermissionID as KEY, PermissionName
cur.execute("CREATE TABLE IF NOT EXISTS PERMISSION (PERMISSION_ID TEXT PRIMARY KEY, PERMISSION_NAME TEXT)")

#create ROOM table with RoomID as KEY, HotelID referencing HotelID in HOTEL table, RoomType, RoomPrice, NumOfBeds
cur.execute("CREATE TABLE IF NOT EXISTS ROOM (ROOM_ID TEXT PRIMARY KEY, HOTEL_ID TEXT, ROOM_PRICE TEXT, NUM_OF_BEDS TEXT, FOREIGN KEY(HOTEL_ID) REFERENCES HOTEL(HOTEL_ID))")

#create Furniture table with RoomID referencing RoomID in ROOM table, Furniture_1, Furniture_2, Furniture_3, Furniture_4
cur.execute("CREATE TABLE IF NOT EXISTS FURNITURE (ROOM_ID TEXT, FURNITURE_1 TEXT, FURNITURE_2 TEXT, FURNITURE_3 TEXT, FURNITURE_4 TEXT, FOREIGN KEY(ROOM_ID) REFERENCES ROOM(ROOM_ID))")

#create RoomLog table with LogID as KEY, RoomID referencing RoomID in ROOM table, UserID referencing UserID in USER table, DateFrom, DateTo
cur.execute("CREATE TABLE IF NOT EXISTS ROOM_LOG (LOG_ID TEXT PRIMARY KEY, ROOM_ID TEXT, USER_ID TEXT, DATE_FROM TEXT, DATE_TO TEXT, FOREIGN KEY(ROOM_ID) REFERENCES ROOM(ROOM_ID), FOREIGN KEY(USER_ID) REFERENCES USER(USER_ID))")

#create Room_Permission table with RoomID referencing ROOM table, PermissionID referencing PERMISSION table
cur.execute("CREATE TABLE IF NOT EXISTS ROOM_PERMISSION (ROOM_ID TEXT, PERMISSION_ID TEXT, FOREIGN KEY(ROOM_ID) REFERENCES ROOM(ROOM_ID), FOREIGN KEY(PERMISSION_ID) REFERENCES PERMISSION(PERMISSION_ID))")

#create User_Permission table with UserID referencing UserID in USER table, PermissionID referencing PermissionID in PERMISSION table
cur.execute("CREATE TABLE IF NOT EXISTS USER_PERMISSION (USER_ID TEXT, PERMISSION_ID TEXT, FOREIGN KEY(USER_ID) REFERENCES USER(USER_ID), FOREIGN KEY(PERMISSION_ID) REFERENCES PERMISSION(PERMISSION_ID))")

#create Login_Info table with UserID referencing UserID in USER table, Username, Password
cur.execute("CREATE TABLE IF NOT EXISTS LOGIN_INFO (USER_ID TEXT, USERNAME TEXT, PASSWORD TEXT, FOREIGN KEY(USER_ID) REFERENCES USER(USER_ID))")



#add data
with open(os.path.join(os.path.dirname(__file__), '..', '..', '.github', 'testcases', 'UsersList.json'), encoding="utf8") as f:
    traffic = json.load(f)

id = 0

for row in traffic:
    cur.execute("INSERT INTO USER VALUES (?,?,?,?,?,?,?)", (id, row['Name'], row['Phone'], row['Email'], row['Gender'], row['Birthday'], row['Address']))
    cur.execute("INSERT INTO LOGIN_INFO VALUES (?,?,?)", (id, row['Username'], row['Password']))
    id += 1

with open(os.path.join(os.path.dirname(__file__), '..', '..', '.github', 'testcases', 'RoomsList.json'), encoding="utf8") as f:
    traffic = json.load(f)

HotelList = []

for row in traffic:
    HotelID = row['Room'][0]
    if HotelID not in HotelList:
        HotelList.append(HotelID)
        cur.execute("INSERT INTO HOTEL VALUES (?,?,?)", (HotelID, "None", "None"))
    cur.execute("INSERT INTO ROOM VALUES (?,?,?,?)", (row['Room'], row['Room'][0], row['Price'], row['BedNum']))
    Fur = 4*[None]
    for i in range(len(row['InRoom'])):
        Fur[i] = row['InRoom'][i]
    cur.execute("INSERT INTO FURNITURE VALUES (?,?,?,?,?)", (row['Room'], Fur[0], Fur[1], Fur[2], Fur[3]))


con.commit()
con.close()