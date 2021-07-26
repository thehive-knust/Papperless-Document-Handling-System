from datetime import datetime, timezone
from flask import (
    Blueprint, request, jsonify
)

from flask_jwt_extended import (
    create_access_token, create_refresh_token, get_jwt_identity, get_jwt, jwt_required, current_user)
from middleware.security import jwt
from werkzeug.security import check_password_hash, generate_password_hash

from pdhs_app import db
from pdhs_app.models.users.user import User
from .tokens import TokenBlocklist

bp = Blueprint('auth', __name__, url_prefix='/auth')


@bp.route('/hello', methods=['GET'])
def hello():
    if request.method == 'GET':
        return 'Hello from /auth'


@jwt.user_identity_loader
def user_identity_lookup(user):
    return user.id


@jwt.user_lookup_loader
def user_lookup_callback(_jwt_header, jwt_data):
    identity = jwt_data["sub"]
    user = User.find_by_id(identity)
    return user if user else None


@bp.route("/refresh", methods=["POST"])
@jwt_required(refresh=True)
def refresh():
    identity = current_user
    access_token = create_access_token(identity=identity, fresh=False)
    return jsonify(access_token=access_token)


@jwt.token_in_blocklist_loader
def check_if_token_revoked(jwt_header, jwt_payload):
    jti = jwt_payload["jti"]
    token = db.session.query(TokenBlocklist.id).filter_by(jti=jti).scalar()
    return token is not None


@bp.route('/register', methods=['POST'])
def register():
    if request.method == 'POST':
        id = request.json.get('id', None)
        first_name = request.json.get('first_name', None)
        last_name = request.json.get('last_name', None)
        email = request.json.get('email', None)
        password = request.json.get('password', None)
        portfolio_id = request.json.get('portfolio_id', None)
        department_id = request.json.get('department_id', None)

        error = None

        if not email:
            error = 'Email is required.'
        elif not first_name:
            error = 'First name is required.'
        elif not last_name:
            error = 'Last name is required.'
        elif not portfolio_id:
            error = 'Portfolio is required.'
        elif not department_id:
            error = 'Department is required.'
        elif not password:
            error = 'Password is required.'

        elif User.query.filter_by(email=email).first() is not None:
            error = f"The email {email} is already registered."

        if error is None:
            password = generate_password_hash(password)
            new_user = User(
                id=id,
                first_name=first_name,
                last_name=last_name,
                email=email,
                password=password,
                portfolio_id=portfolio_id,
                department_id=department_id
            )
            try:
                new_user.save_to_db()
            except:
                return jsonify(msg="Could not save new user to database"), 500

            return jsonify({'msg': 'User created successfully'}), 201

        return jsonify({"msg": error}), 500


@bp.route('/login', methods=['POST'])
def login():
    if request.method == 'POST':
        id = request.json.get('id', None)
        password = request.json.get('password', None)

        user = User.find_by_id(id)
        correct_password = check_password_hash(user.password, password)
        if id is not None and correct_password:
            access_token = create_access_token(identity=user)
            refresh_token = create_refresh_token(identity=user)
            return jsonify(access_token=access_token, refresh_token=refresh_token), 200
        else:
            return jsonify(msg='Invalid ID or password'), 401
    else:
        return 404


@bp.route('/logout', methods=["DELETE"])
@jwt_required()
def modify_token():
    jti = get_jwt()["jti"]
    now = datetime.now(timezone.utc)
    token_block = TokenBlocklist(
        jti=jti, created_at=now, created_by=current_user.id)
    db.session.add(token_block)
    db.session.commit()
    return jsonify(msg="JWT revoked")


@bp.route('/test_login', methods=["GET"])
@jwt_required()
def protected():
    # Access the identity of the current user with get_jwt_identity
    current_user = get_jwt_identity()
    return jsonify(logged_in_as=current_user), 200


@bp.route("/who_am_i", methods=["GET"])
@jwt_required()
def who_am_i():
    # We can now access our sqlalchemy User object via `current_user`.
    return jsonify(
        id=current_user.id,
        first_name=current_user.first_name.title(),
        last_name=current_user.last_name.title()
    )


# @bp.before_app_request
# def load_logged_in_user():
#     user_id = session.get('user_id')

#     if user_id is None:
#         g.user = None
#     else:
#         g.user = User.query.filter_by(id=user_id).first()


# @bp.route('/logout')
# def logout():
#     session.clear()
#     return redirect(url_for('index'))


# def login_required(view):
#     @functools.wraps(view)
#     def wrapped_view(**kwargs):
#         if g.user is None:
#             return redirect(url_for('auth.login'))

#         return view(**kwargs)

#     return wrapped_view
