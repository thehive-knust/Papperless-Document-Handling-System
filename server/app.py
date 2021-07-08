__author__ = "Koffi-Cobbin"
from flask import render_template, request
from common.database import Database #src.
from config import app

@app.route('/', methods=['POST', 'GET'])
def home():
    if request.method =='GET':
        return render_template('home.html')
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        result = Database.insert("users", [username, password])
        return result

# from models.users.views import user_blueprint #src.
# from models.messages.views import message_blueprint #src.
# from models.documents.views import document_blueprint #src.
# app.register_blueprint(user_blueprint, url_prefix="/users")
# app.register_blueprint(message_blueprint, url_prefix="/messages")
# app.register_blueprint(document_blueprin, url_prefix="/documents")
