from crypt import methods
import sys
import os
import awswrangler as wr
path = os.getcwd()+'/src'

for file in os.listdir(path):
    path_file = path+"/"+file
    sys.path.append(path_file)

from src import utils

from flask import Flask, json, request

api = Flask(__name__)
    
@api.route('/athena_api', methods=['GET'])
def athena_api():
    query = request.args.get('query')
    try:
        df = wr.athena.read_sql_query(query, database='starlinkdb')
    except Exception as error:
        utils.logging("ERROR",("Error to select athena - {0}").format(error))
        return json.dumps(utils.get_response("FAIL", "ERROR: Not possible to execute athena"))
    result_dicts = df.to_dict('records')
    return utils.get_response("OK", str(result_dicts))


if __name__ == '__main__':

    api.run(host="0.0.0.0", port=5000, debug=False)
    
    
    #from waitress import serve
    #serve(api, host="0.0.0.0", port=5000)
    

     