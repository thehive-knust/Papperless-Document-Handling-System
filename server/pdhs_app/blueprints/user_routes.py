from flask import Blueprint, request, jsonify
from pdhs_app.models.users.user import User  # src.
import pdhs_app.models.users.errors as UserErrors  # src.
import pdhs_app.models.users.decorators as user_decorators  # src.
import pdhs_app.models.users.constants as UserConstants
from pdhs_app.models.documents.document import Document
from pdhs_app.models.departments.department import Department

bp = Blueprint('users', __name__, url_prefix='/user')


@bp.route('/hello', methods=['GET'])
def hello():
    if request.method == 'GET':
        return "Hello from /user"


@bp.route('/', methods=['GET'])
def get_all_users():
    if request.method == 'GET':
        result = User.query.all()
        users = [user.to_json() for user in result]
        return {'users': users}


@bp.route('/<int:user_id>', methods=['GET'])
def get_user_by_id(user_id):
    if request.method == 'GET':
        user = User.find_by_id(user_id)
    if user is not None:
        return jsonify(user.to_json())
    return jsonify(msg="User not found"), 404


@bp.route('/<int:email>', methods=['GET'])
def get_user_by_email(email):
    if request.method == 'GET':
        user = User.find_by_email(email)
    if user is not None:
        return jsonify(user.to_json())
    return jsonify(msg="User not found"), 404


@bp.route('/<int:user_id>', methods=['DELETE'])
def delete_user(user_id):
    if request.method == 'DELETE':
        user = User.find_by_id(user_id)
    if user is not None:
        try:
            user.delete_from_db()
        except:
            return jsonify(msg="Error deleting user."), 500

    return jsonify(msg="User not found"), 404


# @bp.route('/login', methods=['POST'])
# def login():
#     if request.method == 'POST':
#         request_data = request.get_json()
#         user_id = request_data['user_id']
#         password = request_data['password']
#         try:
#             user = User.is_login_valid(user_id, password)
#             if user:
#                 departments = Department.query.filter_by(college_id=user.colleg_id)
#                 user_department_members = User.query.filter_by(department_id=user.department_id)
#                 recieved_documents = Document.query.filter_by()
#                 uploaded_documents = Document.query.filter_by(user_id=user.user_id)
#                 return jsonify()
#         except UserErrors.UserError as e:
#             return jsonify({"message": f"{e.message}"})


# @bp.route('/register', methods=['GET', 'POST'])
# def register_user():
#     if request.method == 'POST':
#         request_data = request.get_json()
#         user_id = request_data['user_id']
#         first_name = request_data['first_name']
#         last_name = request_data['last_name']
#         email = request_data['email']
#         password = request_data['password']
#         portfolio = request_data['portfolio_id']
#         department_name = request_data['department_id']
#         try:
#             if User.is_login_valid(user_id, password):
#                 return jsonify({"message": "User already exists"})
#         except UserErrors.UserError as e:
#             return jsonify({"message": f"{e.message}"})

#         if User.register_user(user_id, first_name, last_name, email, password, portfolio):
#             return jsonify({"message":f"Sucessfully registered {user_id}"})


# # The profile page section
# @bp.route('/profile')
# @user_decorators.requires_login
# def profile():
#     # checking if user actually exists
#     user = User.query.filter_by(user_id=user_id).first()
#     return jsonify(user)

# @bp.route('/edit_profile/<int: user_id>', methods=['POST'])
# @user_decorators.requires_login
# def edit_profile(user_id):
#     if request.method == 'POST':
#         user = User.query.filter_by(user_id=user_id).first()
#         return jsonify({"message":"Done"})


# # The Delete User section
# @bp.route('/delete_user/<int: user_id>')
# @user_decorators.requires_login
# def delete_user(user_id):
#     User.query.filter(User.user_id == user_id).delete()
#     return jsonify({"message":"User Deleted"})