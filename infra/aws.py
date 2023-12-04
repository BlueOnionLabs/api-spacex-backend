import logging
import boto3
from botocore.exceptions import ClientError
import os


def get_bucket_connection():
    s3_client = boto3.client('s3',aws_access_key_id=os.environ["AWS_ACCESS_KEY_ID"], aws_secret_access_key=os.environ["AWS_SECRET_ACCESS_KEY"])
    return s3_client

def save_to_bucket(path, file_name):
    
    s3_client = get_bucket_connection()
    bucket = "starlink-test"
    try:
        s3_client.upload_file(path, bucket, "raw/"+file_name)
    except ClientError as e:
        logging.error(e)
        return False
