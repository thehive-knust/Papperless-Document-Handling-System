"""Production configuration."""
from os import environ, path
from dotenv import load_dotenv

basedir = path.abspath(path.dirname(__file__))
load_dotenv(path.join(basedir, '.env'))

SECRET_KEY = environ.get('SECRET_KEY')

FLASK_ENV = 'production'
DEBUG = False
TESTING = False
SESSION_COOKIE_SECURE = True

SQL_HOST = environ.get('SQL_HOST')
SQL_USERNAME = environ.get('SQL_USERNAME')
SQL_PASSWORD = environ.get('SQL_PASSWORD')
SQL_DATABASE = environ.get('SQL_DATABASE')
DATABASE_URI = '{dialect}+{driver}://{username}:{password}@{host}:{port}/{database}'.format(
    dialect=environ.get('SQL_DIALECT'),
    driver=environ.get('SQL_DRIVER'),
    username=environ.get('SQL_USER'),
    password=environ.get('SQL_PASSWORD'),
    host=environ.get('HOST'),
    port=environ.get('PORT'),
    database=environ.get('DATABASE')
)
