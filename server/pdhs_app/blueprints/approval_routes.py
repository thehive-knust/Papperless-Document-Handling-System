from flask import Blueprint, request, jsonify
from pdhs_app.models.users.user import User  # src.
from pdhs_app.models.approvals.approval import Approval
from pdhs_app.models.approvals import errors as ApprovalErrors

bp = Blueprint('approvals', __name__, url_prefix='/approval')


@bp.route('/hello', methods=['GET'])
def hello():
    if request.method == 'GET':
        return "Hello from /approval"


@bp.route('/', methods=['GET'])
def get_all_approvals():
    """
    Get all the approvals in the approval
    table.
    """
    if request.method == 'GET':
        approvals = []
        result = []
        error_msg = None
        try:
            result = Approval.query.all()
        except:
            error_msg = 'Error occured retrieving approvals'
        if len(result) == 0:
            error_msg = 'No approvals available'
        if error_msg is not None:
            return jsonify(msg=error_msg)
        else:
            for approval in result:
                approvals.append(approval.to_json())
            return jsonify(approvals=approvals)


@bp.route('/<int:approval_id>', methods=['GET'])
def get_approval_by_id(approval_id):
    """
    Get a particular approval by id
    """
    if request.method == 'GET':
        error_msg = None
        try:
            approval = Approval.find_by_id(approval_id)
            if approval is None:
                error_msg = f'No approval with ID {approval_id} found'
        except:
            error_msg = 'Error occured finding approval'
        if error_msg is not None:
            return jsonify(msg=error_msg), 404
        elif approval is not None:
            return jsonify(approval.to_json())


@bp.route('/create', methods=['POST'])
def create_approval():
    """
    Create a approval
    """
    if request.method == 'POST':
        name = request.json.get('name', None)
        recipient_id = request.json.get('recipient_id', None)
        document_id = request.json.get('document_id', None)
        error_msg = None
        if not name:
            error_msg = 'Name is required.'
        elif not recipient_id:
            error_msg = 'Recipient ID is required.'
        elif not document_id:
            error_msg = 'Document ID is required.'
        if error_msg is not None:
            return jsonify(msg=error_msg), 500
        else:
            new_approval = Approval(
                id=id,
                name=name,
                document_id=document_id,
                recipient_id=recipient_id
            )
            try:
                new_approval.save_to_db()
            except:
                return jsonify(msg='Error saving Approval to database'), 500
            return jsonify(new_approval.to_json()), 201


@bp.route('/delete/<int:approval_id>', methods=['DELETE'])
def delete_approval(approval_id):
    if request.method == 'DELETE':
        error_msg = None
        try:
            approval = Approval.find_by_id(approval_id)
        except:
            error_msg = 'Error occured finding approval'
        if approval is not None:
            try:
                approval.delete_from_db()
            except:
                error_msg = 'Error occured deleting Approval'
        if error_msg is not None:
            return jsonify(msg=error_msg), 404
        else:
            return jsonify(msg='Approval deleted successfully')


@bp.route('/update/<int:approval_id>', methods=['PUT'])
def update_approval():
    """
    Update an Approval
    """
    if request.method == 'PUT':
        result = request.get_json()
        approval_id = result.get('approval_id', None)
        status = result.get('status', None)

        if not approval_id:
            return jsonify(msg='Id is required.'), 500
        else:
            approval = Approval.find_by_id(approval_id)
            if approval is not None:
                try:
                    approval.status = status
                    approval.save_to_db()
                    return jsonify(msg='Done'), 200
                except:
                    return jsonify(msg='Error updating Approval'), 500
            else:
                return jsonify(msg=f"Approval with {approval_id} does not exist"), 404


@bp.route('/received/<int:user_id>', methods=['GET'])
def get_approvals_received_by_user(user_id):
    error_msg = None
    # results = None
    approvals = []
    try:
        results = Approval.query.filter_by(recipient_id=user_id)
    except:
        error_msg = 'Error occured finding approval'
    if len(results) == 0:
        error_msg = f'No new approvals have requested from you.'
    else:
        for approval in results:
            approvals.append(approval.to_json())
    if error_msg is not None:
        return jsonify(msg=error_msg), 404
    return jsonify(approvals=approvals)
