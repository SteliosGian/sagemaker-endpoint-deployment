import os
import boto3
import json
import signal

# grab environment variables
ENDPOINT_NAME = os.environ['ENDPOINT_NAME']
runtime = boto3.client('runtime.sagemaker')


def timeout_handler(_signal, _frame):
    raise Exception('Timeout')


signal.signal(signal.SIGALRM, timeout_handler)


def lambda_handler(event, context):

    signal.alarm(int(context.get_remaining_time_in_millis() / 1000) - 1)
    response = runtime.invoke_endpoint(EndpointName=ENDPOINT_NAME,
                                       ContentType='application/json',
                                       Body=json.dumps(event))

    signal.alarm(0)
    result = json.loads(response["Body"].read())
    return result
