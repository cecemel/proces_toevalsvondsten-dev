"""
Helpscript to verify if storage provider is ready
"""
import requests
import time


def _is_elastic_ready():
    try:
        response = requests.get('http://elastic:9200/_cluster/health?pretty=true').json()
        if response['status'] == 'green' or response['status'] == 'yellow':
            return True
    except:
        print("Unable to connect to elastic")
    return False


if __name__ == '__main__':
    max_attempts = 20
    attempts = 0
    while not _is_elastic_ready() or attempts > max_attempts:
        print("elastic not ready, waiting..")
        attempts += 1
        time.sleep(10)

    if attempts > max_attempts:
        print("elastic not ready giving up")
        exit(1)

    if attempts > max_attempts:
        print("storage provider not ready giving up")
        exit(1)
