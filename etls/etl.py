import click
import json
from infra import aws, local


@click.command()
def start():
    df = local._read_data("./starlink_historical_data.json")
    df_sorted = df.iloc[df['spaceTrack'].str.get('CREATION_DATE').astype(str).argsort()]
    data = df_sorted.to_dict('records')
    string_json = ""
    for item in data:
        string_json = string_json + str(json.dumps(item))+"\n"
    name_file = "historical.json"
    path = "./output/" + name_file 
    local._save_local(path, string_json)
    aws._save_to_bucket(path, name_file)

start()