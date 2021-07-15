"""Flask configuration."""
from os import environ, path
from dotenv import load_dotenv


basedir = path.abspath(path.dirname(__file__))
load_dotenv(path.join(basedir, '.env'))

print(path.join(basedir, '.env'))


class Config(object):
    DEBUG = False
    TESTING = False
    SECRET_KEY = environ.get('SECRET_KEY')
    SESSION_COOKIE_SECURE = True

    # SQL Database
    SQL_HOST = environ.get('SQL_HOST')
    SQL_USERNAME = environ.get('SQL_USERNAME')
    SQL_PASSWORD = environ.get('SQL_PASSWORD')
    SQL_DATABASE = environ.get('SQL_DATABASE')


class ProductionConfig(Config):
    pass


class DevelopmentConfig(Config):
    DEBUG = True
    SESSION_COOKIE_SECURE = False


class TestingConfig(Config):
    TESTING = True
    SESSION_COOKIE_SECURE = False


# ------------------------------------
# users = [
#     {"user_id":"20612265", "password:":"eocupualor"},
#     {"user_id":"12345678", "password:":"12345678"},
#     {"user_id":"20624322", "password:":"hive2021"}
#     ]
