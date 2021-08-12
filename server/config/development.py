"""Development configuration."""

from os import environ, path
from dotenv import load_dotenv
from datetime import timedelta

# basedir = path.abspath(path.dirname(__file__))
# load_dotenv(path.join(basedir, '.env'))
load_dotenv()

# defaults
SECRET_KEY = environ.get('SECRET_KEY')
JWT_SECRET_KEY = environ.get('JWT_SECRET_KEY')
JWT_ACCESS_TOKEN_EXPIRES = timedelta(
    hours=int(environ.get('JWT_ACCESS_TOKEN_EXPIRES')))
JWT_REFRESH_TOKEN_EXPIRES = timedelta(
    days=int(environ.get('JWT_REFRESH_TOKEN_EXPIRES')))
SQLALCHEMY_TRACK_MODIFICATIONS = False

# Others
FLASK_ENV = 'development'
DEBUG = True
JWT_COOKIE_SECURE = False
SESSION_COOKIE_SECURE = False

# Database
SQLALCHEMY_DATABASE_URI = "sqlite:///{instance_path}/{path}".format(
    instance_path=environ.get('INSTANCE_PATH'),
    path=environ.get('SQL_LITE_PATH')
)
