import json
import pandas as pd
import awswrangler as wr

def save_local(path, str_to_save):
    file_object = open(path, 'w')
    file_object.write(str_to_save)
    file_object.close()

def read_data(path):
    data = ""
    f = open(path, "r")
    data = f.read()
    data = data.replace("\n","")
    data = data.replace(" ","")
    data = json.loads(data)
    df = pd.DataFrame(data)
    return df