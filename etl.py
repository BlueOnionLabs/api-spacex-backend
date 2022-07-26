from datetime import datetime
import json
from MySQLdb import DATETIME, Timestamp
from numpy import float64
import pandas as pd
from sqlalchemy import DateTime, create_engine

file_name = 'starlink_historical_data.json'
mysql_conn = create_engine("mysql+mysqldb://jersson:123@localhost/db_test")

##Load JSON file using pandas
starlink_df = pd.read_json(file_name)
row_count = starlink_df.shape[0]
print(file_name + " loaded successfully")
##Read inner attribute and assign it to a new datetime column 
starlink_df['creation_date'] = pd.to_datetime(pd.DataFrame(starlink_df.spaceTrack.values.tolist())["CREATION_DATE"])
##Select columns to save into database
starlink_df = starlink_df[['id','longitude','latitude','creation_date']]
##Unifying datatypes
starlink_df = starlink_df.astype({"longitude": float64, "latitude": float64})
print(str(row_count) + " rows parsed")

#Begin transaction allowing context manager to handle commit/rollback in case of an exception
with mysql_conn.begin() as conn:
    #Append data into fact table
    starlink_df.to_sql(con=conn,name='starlink_fact', if_exists='replace',index=False)
    print(str(row_count)  + " rows inserted into the starlink_fact table")