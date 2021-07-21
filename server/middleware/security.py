from werkzeug.security import safe_str_cmp
from pdhs_app.models.users.user import User


def authenticate(email, password):
    user = User.find_by_email(email)
    if user is not None and safe_str_cmp(user.password, password):
        return user


def identity(payload):
    user_id = payload['identity']
    return User.find_by_id(user_id)
