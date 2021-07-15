"""Testing configuration."""

from os import environ, path
from dotenv import load_dotenv


basedir = path.abspath(path.dirname(__file__))
load_dotenv(path.join(basedir, '.env'))

SECRET_KEY = environ.get('SECRET_KEY')

FLASK_ENV = 'testing'
TESTING = True
TESTING = True
SESSION_COOKIE_SECURE = False
DATABASE_URI = f"sqlite:///{environ.get('SQL_LITE_PATH')}"
