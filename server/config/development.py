"""Development configuration."""

from os import environ, path
from dotenv import load_dotenv


load_dotenv()


SECRET_KEY = environ.get('SECRET_KEY')

FLASK_ENV = 'development'
DEBUG = True
SESSION_COOKIE_SECURE = False
DATABASE_URI = "sqlite:///{instance_path}/{path}".format(
    instance_path=environ.get('INSTANCE_PATH'),
    path=environ.get('SQL_LITE_PATH')
)
