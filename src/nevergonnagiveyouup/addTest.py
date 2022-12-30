import sqlite3
import json
import os

conection = sqlite3.connect('data.db')
cursor = conection.cursor()

#open TestData.json from .github folder
with open(os.path.join(os.path.dirname(__file__), '..', '..', '.github', 'TestData.json'), encoding="utf8") as f:
    traffic = json.load(f)


#add Name, Phone, Email, Gender, Birthday to USER table in data.db
#add Username, Password to LOGIN_INFO table in data.db

id = 0

for row in traffic:
    cursor.execute("INSERT INTO USER VALUES (?,?,?,?,?,?,?)", (id, row['Name'], row['Phone'], row['Email'], row['Gender'], row['Birthday'], row['Address']))
    cursor.execute("INSERT INTO LOGIN_INFO VALUES (?,?,?)", (id, row['Username'], row['Password']))
    id += 1

conection.commit()
conection.close()

