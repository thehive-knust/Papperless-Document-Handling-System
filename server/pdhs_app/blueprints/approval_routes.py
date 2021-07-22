from flask import Blueprint, request, jsonify
from pdhs_app.models.users.user import User  # src.
from pdhs_app.models.approvals.approval import Approval

bp = Blueprint('approvals', __name__, url_prefix='/approval')


@bp.route('/hello', methods=['GET'])
def hello():
    if request.method == 'GET':
        return "Hello from /approval"
