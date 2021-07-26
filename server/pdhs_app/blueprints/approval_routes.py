from flask import Blueprint, request, jsonify
from pdhs_app.models.users.user import User  # src.
from pdhs_app.models.approvals.approval import Approval

bp = Blueprint('approvals', __name__, url_prefix='/approval')


@bp.route('/new', methods=['POST'])
def new():
    if request.method == 'POST':
        result = request.get_json()
        approval_id = request['approval_id']
        document_id = result['document_id']
        return "Hello from /approval"
