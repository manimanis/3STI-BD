import pandas as pd
import sqlite3
import os



dbfile = 'location.db'
excelFile = 'locations.xlsx'

cur_dir = os.path.dirname(__file__)
dbFilePath = os.path.join(cur_dir, dbfile)
excelFilePath = os.path.join(cur_dir, excelFile)

df = pd.read_excel(excelFilePath, sheet_name='Locations')
conn = sqlite3.connect(dbFilePath)

conn.execute("""CREATE TABLE IF NOT EXISTS Locations (
    matricule VARCHAR(9),
    vehicule VARCHAR(32),
    prix_unit REAL DEFAULT 0.0,
    cin VARCHAR(10),
    client VARCHAR(32),
    tel VARCHAR(16),
    date_location DATE,
    date_retour DATE,
    jours INTEGER DEFAULT 0,
    prix_a_payer REAL DEFAULT 0.0
)""")

conn.execute("DELETE FROM Locations;")

for i in range(df.matricule.count()):
    row = df.iloc[i]
    cols = ['matricule', 'vehicule', 'prix_unit', 'CIN', 'client', 'tel', 'date_location', 'date_retour', 'jours', 'prix_a_payer']
    types = [str, str, float, str, str, str, str, str, int, float]
    sql = """INSERT INTO Locations (matricule, vehicule, prix_unit, cin, client, tel, date_location, date_retour, jours, prix_a_payer)
VALUES (:matricule, :vehicule, :prix_unit, :CIN, :client, :tel, :date_location, :date_retour, :jours, :prix_a_payer)"""
    data = dict(row)
    data = {col: tp(row[col]) for col, tp in zip(cols, types)}
    print(data)
    conn.execute(sql, data)

conn.commit()