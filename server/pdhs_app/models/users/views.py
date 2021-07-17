from pdhs_app import db
from flask import Blueprint, request, session, url_for, flash, render_template, jsonify
from werkzeug.utils import redirect
from pdhs_app.models.users.user import User  # src.
import pdhs_app.models.users.errors as UserErrors  # src.
import pdhs_app.models.users.decorators as user_decorators  # src.
import pdhs_app.models.users.constants as UserConstants
import json

user_blueprint = Blueprint('users', __name__)

@user_blueprint.route('/login', methods=['POST'])
def login():
    if request.method == 'POST':
        request_data = request.get_json()
        user_id = request_data['user_id']
        password = request_data['password']
        try:
            user = User.is_login_valid(user_id, password)
            if user:
                return jsonify(user)
        except UserErrors.UserError as e:
            return jsonify({"message": f"{e.message}"})


@user_blueprint.route('/register', methods=['GET', 'POST'])
def register_user():
    if request.method == 'POST':
        request_data = request.get_json()
        user_id = request_data['user_id']
        first_name = request_data['first_name']
        last_name = request_data['last_name']
        email = request_data['email']
        password = request_data['password']
        portfolio = request_data['portfolio_id']
        department_name = request_data['department_id']
        try:
            if User.is_login_valid(user_id, password):
                return jsonify({"message": "User already exists"})
        except UserErrors.UserError as e:
            return jsonify({"message": f"{e.message}"})

        if User.register_user(user_id, first_name, last_name, email, password, portfolio):
            return jsonify({"message":f"Sucessfully registered {user_id}"})
        

# The profile page section
@user_blueprint.route('/profile')
@user_decorators.requires_login
def profile():
    # checking if user actually exists
    user = User.query.filter_by(user_id=user_id).first()
    return jsonify(user)

@user_blueprint.route('/edit_profile/<int: user_id>', methods=['POST'])
@user_decorators.requires_login
def edit_profile(user_id):
    if request.method == 'POST':
        user = User.query.filter_by(user_id=user_id).first()   
        return jsonify({"message":"Done"})


# The Delete User section
@user_blueprint.route('/delete_user/<int: user_id>')
@user_decorators.requires_login
def delete_user(user_id):
    User.query.filter(User.user_id == user_id).delete()
    return jsonify({"message":"User Deleted"})

