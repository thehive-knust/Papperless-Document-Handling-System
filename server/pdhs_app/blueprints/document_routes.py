from flask import Blueprint, request, jsonify, current_app
from werkzeug.utils import secure_filename
from pdhs_app.models.users.user import User  # src.
from pdhs_app.models.documents.document import Document
from pdhs_app.models.approvals.approval import Approval
from storage.cloud_storage import delete_blob, upload_blob

bp = Blueprint('documents', __name__, url_prefix='/documents')

ALLOWED_EXTENSIONS = {'txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'}


def _allowed_file(filename):
    return '.' in filename and \
        filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


@bp.route('/hello')
def index():
    # return jsonify({"message": None})
    return "Hello from /document"


@bp.route('/', methods=['GET'])
def get_all_users():
    """
    Return all the documents in the document table
    """
    if request.method == 'GET':
        result = []
        documents = []
        try:
            result = Document.query.all()
        except:
            return jsonify({'msg': 'There was an error retrieving the items requested'}), 500
        for doc in result:
            documents.append(doc.to_json())
        if len(documents) == 0 or len(result) == 0:
            return jsonify({'msg': 'Ther are no uploaded documents'}), 404
        return jsonify({'documents': documents})


@bp.route('/upload', methods=['POST'])
def upload():
    if request.method == 'POST':
        # Handling the creation of a new document object
        request_data = request.form.to_dict()
        doc_subject = request_data.get('subject', None)
        doc_description = request_data.get('description', None)
        user_id = request_data.get('user_id', None)
        # recepients = request_data['recepients']
        # created_at = request_data['created_at']
        # updated_at = request_data['updated_at']
        doc_file = request.files.get('file', None)

        error_msg = None
        if doc_subject is None:
            error_msg = 'Document subject is required'
        elif doc_description is None:
            error_msg = 'Document description is required'
        elif user_id is None:
            error_msg = 'User ID is required'
        if doc_file is None:
            error_msg = 'No selected file'
        # if doc_file.filename == '':
        #         error_msg = 'No selected file'
        if error_msg is not None:
            return jsonify(msg=error_msg), 500
        else:
            new_document = Document(
                subject=doc_subject,
                user_id=user_id,
                description=doc_description
            )

        if _allowed_file(doc_file.filename):
            filename = secure_filename(doc_file.filename)
            new_document.name = f"{user_id}_{filename}"
            try:
                document_url = upload_blob(
                    doc_file.stream, new_document.name)
                if document_url is not None:
                    new_document.file = document_url
            except:
                return jsonify(msg="Error uploading document")
            try:
                new_document.save_to_db()
                return jsonify(document=new_document.to_json()), 201
            except:
                return jsonify(msg='Error saving document to database'), 500
        else:
            return jsonify(msg="File type not supported"), 201

        # Handling the associated people to approve the document
        # for recepient in recepients:
        #     new_approval = Approval(document_id=doc_id, recipient_id=recepient).save_to_db()
        # return jsonify(message="Done!")


@bp.route('/new/<int:user_id>', methods=['GET'])
def new(user_id):
    if request.method == 'GET':
        inbox_documents = Approval.query.filter_by(
            recipient_id=user_id, status="Pending")
        return jsonify(inbox_documents)


@bp.route('/approved/<int:user_id>', methods=['GET'])
def approved(user_id):
    if request.method == 'GET':
        approved_documents = Approval.query.filter_by(
            recipient_id=user_id, status="Approved")
        return jsonify(approved_documents)


@bp.route('/rejected/<int:user_id>', methods=['GET'])
def rejected(user_id):
    if request.method == 'GET':
        rejected_documents = Approval.query.filter_by(
            recipient_id=user_id, status="Rejected")
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
        return {"msg": "Done"}


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
            return jsonify(msg=error_msg), 500
        if len(documents) == 0:
            return jsonify(msg='No documents were found for user'), 404
        for doc in result:
            documents.append(doc)
        return jsonify(documents=documents), 200


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
            if document is None:
                error_msg = f'No document with ID {document_id} found'
        except:
            error_msg = 'Error occured finding document'
        if error_msg is not None:
            return jsonify(msg=error_msg)
        elif document is not None:
            return jsonify(document.to_json())


@bp.route('/<int:document_id>/progress', methods=['GET'])
def get_document_progress(document_id):
    approvals = None
    try:
        approvals = Approval.query.filter(document_id=document_id).all()
    except:
        return jsonify(msg='Error retrieving approvals'), 404
    if not approvals:
        return jsonify(msg='There are no approvals for this document'), 404
    else:
        statuses_count = sum([a.status for a in approvals])
        if statuses_count == 0:
            return jsonify(progress='Rejected'), 200
        elif statuses_count == len(approvals):
            return jsonify(progress='Accepted'), 200
        elif statuses_count > 0 and statuses_count < len(approvals):
            return jsonify(progress='Pending'), 200


@bp.route('/delete/<int:document_id>', methods=['DELETE'])
def delete_document(document_id):
    if request.method == 'DELETE':
        error_msg = None
        try:
            document = Document.find_by_id(document_id)
        except:
            error_msg = 'Error occured finding document'
            error_code = 404
        if document is not None:
            if not delete_blob(document.name):
                error_msg = 'Error occured deleting document from cloud storage'
                error_code = 500
            try:
                document.delete_from_db()
            except:
                error_msg = 'Error occured deleting Document from database'
                error_code = 500
        if error_msg is not None:
            return jsonify(msg=error_msg), error_code
        else:
            return jsonify(msg='Document deleted successfully'), 200
