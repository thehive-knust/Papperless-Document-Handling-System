from flask import Blueprint, request, jsonify
from pdhs_app.models.users.user import User  # src.
from pdhs_app.models.documents.document import Document
from pdhs_app.models.approvals.approval import Approval

bp = Blueprint('documents', __name__, url_prefix='/document')


@bp.route('/upload', methods=['POST'])
def upload():
    if request.method == 'POST':
        # Handling the creation of a new document object
        request_data = request.get_json()
        doc_id = request_data['id']
        doc_status = request_data['status']
        doc_subject = request_data['subject']
        doc_description = request_data['description']
        doc_sender = request_data['sender_id']
        created_at = request_data['createdAt']
        updated_at = request_data['updatedAt']
        doc_file = request_data['file']

        # Handling the associated people to approve the document
        recepients = request_data['recepients']
        for recepient in recepients:
            new_approval = Approval(id=id, document_id=doc_id, recipient_id=id, status=doc_status).save_to_db()
        return jsonify(message="Done!")


@bp.route('/new/<int:user_id>', methods=['GET'])
def new(user_id):
    if request.method == 'GET':
        inbox_documents = Approval.query.filter_by(recipient_id=user_id, status="Pending")
        return jsonify(inbox_documents)    

@bp.route('/approved/<int:user_id>', methods=['GET'])
def approved(user_id):
    if request.method == 'GET':
        approved_documents = Approval.query.filter_by(recipient_id=user_id, status="Approved")
        return jsonify(approved_documents)  

@bp.route('/rejected/<int:user_id>', methods=['GET'])
def rejected(user_id):
    if request.method == 'GET':
        rejected_documents = Approval.query.filter_by(recipient_id=user_id, status="Rejected")
        return jsonify(rejected_documents)        
        
@bp.route('/cancel', methods=['GET'])
def cancel():
    if request.method == 'GET':
        result = request.get_json()
        document_id = result['document_id']
        all_approvals = Approval.query.filter_by(document_id=document_id)
        for approval in all_approvals:
            approval.delete_from_db()
        Document.query.filter_by(id=document_id).delete_from_db()
        return {"message": "Done"}   
        