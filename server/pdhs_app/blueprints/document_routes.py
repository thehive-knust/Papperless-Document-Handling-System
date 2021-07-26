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
            new_approval = Approval(
                id=id, document_id=doc_id, recipient_id=id, status=None).save_to_db()
        return jsonify(message="Done!")


@bp.route('/get_new_docs/<int:user_id>', methods=['GET'])
def get_new_docs(user_id):
    if request.method == 'GET':
        return "Hello from /document"


@bp.route('/user/<int:user_id>', methods=['GET'])
def get_user_documents(user_id):
    """
    Get all the documents created or 
    uploaded by a particular user.
    """
    if request.method == 'GET':
        documents = []
        error_msg = None
        try:
            result = Document.query.filter_by(user_id=user_id).all()
        except:
            error_msg = 'Error occured retrieving documents'
        if error_msg is not None:
            return jsonify(msg=error_msg)
        elif len(documents) > 0:
            for doc in result:
                documents.append(doc)
            return jsonify(documents=documents)


@bp.route('/<int:document_id>', methods=['GET'])
def get_document_by_id(document_id):
    """
    Get a particular document by id
    """
    if request.method == 'GET':
        document = None
        error_msg = None
        try:
            document = Document.find_by_id(document_id)
        except:
            error_msg = 'Error occured finding document'
        if error_msg is not None:
            return jsonify(msg=error_msg)
        elif document is not None:
            return jsonify(document.to_json())


@bp.route('/upload', methods=['POST'])
def upload_document():
    pass
