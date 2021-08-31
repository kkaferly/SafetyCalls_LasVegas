# Import libraries
import pandas as pd
import sqlite3 as lite
from sqlite3 import Error as E

# Create database from CSV
conn = sqlite3.connect(r"/Users/dataanalysis/Documents/Portfolio Projects/Las Vegas - Public Safety Calls/Manipulate Database in SQLite/safetycalls.db")

# Convert CSV to SQLite db using pandas - Load then Write
call_data = pd.read_csv("/Users/dataanalysis/Documents/Portfolio Projects/Las Vegas - Public Safety Calls/Data Files/City_of_Las_Vegas_Department_of_Public_Safety_Calls_For_Service_Open_Data.csv")

call_data.to_sql('calls', conn, if_exists='replace', index=False)

# Verify database was created
cur = conn.cursor()

for row in cur.execute('Select * from calls limit 10'):
    print(row)

conn.close()