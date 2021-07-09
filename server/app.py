from flask import render_template, request, jsonify
from common.database import Database #src.
from config import app

@app.route('/', methods=['POST', 'GET'])
def home():
    if request.method =='GET':
        users = Database.select_from_where("*", "users")
        test_user, *_ = users
        return render_template("home.html", user=test_user)
        
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        result = Database.insert("users", [username, password])
        print(result)
        return result

from models.users.views import user_blueprint #src.
# from models.messages.views import message_blueprint #src.
# from models.documents.views import document_blueprint #src.
app.register_blueprint(user_blueprint, url_prefix="/users")
# app.register_blueprint(message_blueprint, url_prefix="/messages")
# app.register_blueprint(document_blueprin, url_prefix="/documents")
