from flask import Blueprint, request, jsonify
from pdhs_app.models.users.user import User  # src.
import pdhs_app.models.users.errors as UserErrors  # src.
import pdhs_app.models.users.decorators as user_decorators  # src.
import pdhs_app.models.users.constants as UserConstants
from pdhs_app.models.documents.document import Document
from pdhs_app.models.departments.department import Department
from pdhs_app.blueprints.document_routes import new as get_new_docs

bp = Blueprint('users', __name__, url_prefix='/users')


@bp.route('/<int:user_id>', methods=['GET'])
def get_user_by_id(user_id):
    """
    Query the database and return a single user that matches the specified id
    """
    if request.method == 'GET':
        error_msg = None
        try:
            user = User.find_by_id(user_id)
            if user is None:
                error_msg = f'No user with ID {user_id} found'
        except:
            error_msg = 'Error occured finding user'
        if error_msg is not None:
            return jsonify(msg=error_msg), 404
        elif user is not None:
            return jsonify(user.to_json()), 200



@bp.route('/<string:email>', methods=['GET'])
def get_user_by_email(email):
    if request.method == 'GET':
        user = User.find_by_email(email)
    if user is not None:
        return jsonify(user.to_json())
    return jsonify(msg="User not found"), 404


@bp.route('delete/<int:user_id>', methods=['DELETE'])
def delete_user(user_id):
    if request.method == 'DELETE':
        user = User.find_by_id(user_id)
    if user is not None:
        try:
            user.delete_from_db()
        except:
            return jsonify(msg="Error deleting user."), 500

    return jsonify(msg="User not found"), 404


@bp.route('/update/<int:user_id>', methods=['POST'])
def update_user(user_id):
    pass


@bp.route('/register/<int:user_id>', methods=['POST'])
def register_user(user_id):
    if request.method == 'POST':
        # Find out if the user is uthorized to add a user
        # user = User.query.filter_by(user_id=user_id)
        request_data = request.get_json()
        user_id = request_data['user_id']
        first_name = request_data['first_name']
        last_name = request_data['last_name']
        email = request_data['email']
        password = request_data['password']
        portfolio_id = request_data['portfolio_id']
        department_id = request_data['department_id']
        try:
            if User.query.filter_by(user_id=user_id).first():
                return jsonify({"message": "User already exists"})
        except UserErrors.UserError as e:
            return jsonify({"message": f"{e.message}"})

        if User.register_user(user_id, first_name, last_name, email, password, portfolio_id, department_id):
            return jsonify({"message": f"Sucessfully registered {user_id}"})


@bp.route('/', methods=['GET'])
def get_all_users():
    """
    Return all the users in the user table
    """
    if request.method == 'GET':
        result = []
        users = []
        try:
            result = User.query.all()
        except:
            return jsonify({'msg': 'There was an error retrieving the items requested'}), 500
        for user in result:
            users.append(user.to_json())
        if len(users) == 0 or len(result) == 0:
            return jsonify({'msg': 'Ther are no registered users'}), 404
        return jsonify({'users': users})
