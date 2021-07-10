from flask import Flask
from flask_mysqldb import MySQL 
from flask_cors import CORS

app = Flask(__name__)
CORS(app)
app.secret_key = app.secret_key = "1234" #os.environ.get("SECRET_KEY")
app.config['MYSQL_HOST'] = 'db4free.net'
app.config['MYSQL_USER'] = 'the_hive'
app.config['MYSQL_PASSWORD'] = 'thehive2021'
app.config['MYSQL_DB'] = 'pdhs_db'
mysql = MySQL(app)


# ------------------------------------
users = [
    {"user_id":"20612265", "password:":"eocupualor"}, 
    {"user_id":"12345678", "password:":"12345678"},
    {"user_id":"20624322", "password:":"hive2021"}
    ]