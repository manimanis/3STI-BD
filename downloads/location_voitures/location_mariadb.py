import os
import mariadb
import pandas as pd

# connection parameters
conn_params = {
    "user": "root",
    "password": "mysqlroot",
    "host": "127.0.0.1",
    "database": "location_vehicules"
}

# Establish a connection
connection = mariadb.connect(**conn_params)

cursor = connection.cursor()

# # Populate countries table  with some data
# cursor.execute("INSERT INTO countries(name, country_code, capital) VALUES (?,?,?)",
#                ("Germany", "GER", "Berlin"))

# # retrieve data
# cursor.execute("SELECT name, country_code, capital FROM countries")

# # print content
# row = cursor.fetchone()
# print(*row, sep=' ')

excelFile = 'locations.xlsx'

cur_dir = os.path.dirname(__file__)
excelFilePath = os.path.join(cur_dir, excelFile)

df = pd.read_excel(excelFilePath, sheet_name='Locations')
cursor.execute("""""")

# free resources
cursor.close()
connection.close()
