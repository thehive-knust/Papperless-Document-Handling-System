import os
from dotenv import load_dotenv
from shutil import copyfileobj
load_dotenv()

UPLOAD_PATH = os.environ.get('UPLOAD_PATH')


def upload_blob(file_bytes, filename):
    file_path = os.path.join(UPLOAD_PATH, filename)
    with open(file_path, 'wb') as file:
        copyfileobj(file_bytes, file)
    if os.path.isfile(file_path):
        return file_path


def delete_blob(filename):
    file_path = os.path.join(UPLOAD_PATH, filename)
    if os.path.exists(file_path) and os.path.isfile(file_path):
        os.remove(file_path)
        return True
    return False
