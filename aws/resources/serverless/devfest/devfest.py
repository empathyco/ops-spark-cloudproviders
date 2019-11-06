import json
from botocore.vendored import requests
import os

def lambda_handler(event, context):
   

    if os.environ['args2'] == "":
        data = {
            'queue':          os.environ['queue'],
            'numExecutors':   int(os.environ['numExecutors']),
            'executorCores':  int(os.environ['executorCores']),
            'executorMemory': os.environ['executorMemory'],
            'driverMemory':   os.environ['driverMemory'],
            'driverCores':    int(os.environ['driverCores']),
            'className':      os.environ['className'], 
            'file':           '{emrLibsPath}/{jarPath}'.format(emrLibsPath = os.environ['emrLibsPath'],jarPath = os.environ['jarPath']),
            'args':           [ os.environ['args0'], os.environ['args1'] ]
        }
    
    else:
        data = {
            'queue':          os.environ['queue'],
            'numExecutors':   int(os.environ['numExecutors']),
            'executorCores':  int(os.environ['executorCores']),
            'executorMemory': os.environ['executorMemory'],
            'driverMemory':   os.environ['driverMemory'],
            'driverCores':    int(os.environ['driverCores']),
            'className':      os.environ['className'], 
            'file':           '{emrLibsPath}/{jarPath}'.format(emrLibsPath = os.environ['emrLibsPath'],jarPath = os.environ['jarPath']),
            'args':           [ os.environ['args0'], os.environ['args1'], os.environ['args2'] ]
        }
   
    

    headers = {
        'Content-Type': 'application/json'
    }

    print('Submit Query Signal:'  + str(data))

    result = requests.post(os.environ['endpoint'], json = data, headers = headers, verify = False)
    json_data = json.loads(result.text)

    return json_data.get('id')