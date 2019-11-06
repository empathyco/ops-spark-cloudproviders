from botocore.vendored import requests
import json
import os

def lambda_handler(jobId, context):

    url = os.environ['endpoint'] + "/" + str(jobId)
    res = requests.get(url)

    json_data = json.loads(res.text)
    

    return json_data.get('state')    
    
    