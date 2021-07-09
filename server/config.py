__author__ = "Koffi-Cobbin"
from flask import Flask
from flask_mysqldb import MySQL 

app = Flask(__name__)
app.secret_key = app.secret_key = "1234" #os.environ.get("SECRETE_KEY")
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'root'
app.config['MYSQL_DB'] = 'testdb'
mysql = MySQL(app)


# ------------------------------------
users = [
    {"user_id":"20612265", "password:":"eocupualor"}, 
    {"user_id":"12345678", "password:":"12345678"},
    {"user_id":"20624322", "password:":"hive2021"}
    ]