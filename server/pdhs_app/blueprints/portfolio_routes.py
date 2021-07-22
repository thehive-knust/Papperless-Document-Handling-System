from flask import Blueprint, request, jsonify
from pdhs_app.models.users.user import User  # src.
from pdhs_app.models.portfolios.portfolio import Portfolio

bp = Blueprint('portfolios', __name__, url_prefix='/portfolio')


@bp.route('/hello', methods=['GET'])
def hello():
    if request.method == 'GET':
        return "Hello from /portfolio"
