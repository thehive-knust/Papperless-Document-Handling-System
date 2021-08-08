from flask import Blueprint, request, jsonify, current_app, render_template
from src.pdhs_app.models.users.user import User  # src.
from src.pdhs_app.models.documents.document import Document
from src.pdhs_app.models.approvals.approval import Approval
from werkzeug.utils import secure_filename
from src.storage.cloud_storage import delete_blob, upload_blob
import os

bp = Blueprint('documents', __name__, url_prefix='/documents')


ALLOWED_EXTENSIONS = {'txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'}

def _allowed_file(filename):
    return '.' in filename and \
        filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


@bp.route('/', methods=['GET'])
def get_all_docs():
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
            return jsonify({'msg': 'There are no uploaded documents'}), 404
        return jsonify({'documents': documents})


@bp.route('/upload', methods=['POST', 'GET'])
def upload():
    if request.method == 'POST':
        request_data = request.form.to_dict()
        _id = request_data.get('id', None)
        doc_subject = request_data.get('subject', None)
        doc_description = request_data.get('description', None)
        user_id = request_data.get('user_id', None) 
        doc_file = request.files.get('file', None)
        print("==========================================PRINTING DATA======================================")
        print("======================DOC FILE====================", doc_file)
        print("========================DATES==================", request.files.get('createdAt', None), request.files.get('updatedAt', None))
        
        # Handling the creation of a new document object
        error_msg = None
        if _id is None:
            error_msg = 'Document ID is required'
            
        elif doc_subject is None:
            error_msg = 'Document subject is required'
            
        elif doc_description is None:
            error_msg = 'Document description is required'
            
        elif user_id is None:
            error_msg = 'User ID is required'
            
        if doc_file is None:
            error_msg = 'No selected file'
            
        if error_msg is not None:
            return jsonify(msg=error_msg), 500
        else:
            new_document = Document(
                subject=doc_subject,
                user_id=user_id,
                description=doc_description #name , file
            )   

        if _allowed_file(doc_file.filename):
                filename = secure_filename(doc_file.filename)
                new_document.name = filename
                try:
                    document_url = upload_blob(doc_file.stream, filename)
                    if document_url is not None:
                        new_document.file = document_url
                except Exception as e:
                    print('Error uploading file: %s' % e)
                try:
#                     new_document.save_to_db()
                    return jsonify(document=new_document.id), 201
                except:
                    return jsonify(msg='Error saving document', doc=new_document), 500
        else:
            return jsonify(msg="File type not supported"), 201

        # Handling the associated people to approve the document
        recepients = request_data['recepients']
        for recepient in recepients:
            new_approval = Approval(id=id, document_id=doc_id, recipient_id=id, status=doc_status).save_to_db()
        return jsonify(message="Done!")
    return render_template("documents/upload_document.html")


@bp.route('/new/<int:user_id>', methods=['GET'])
def inbox(user_id):
    if request.method == 'GET':
#         result = Approval.query.filter_by(recipient_id=user_id, status="Pending")
        result = Document.query.filter_by(user_id=user_id, progress="Pending")
        inbox_documents = [document.to_json() for document in result]
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
            result = Document.query.filter_by(user_id=user_id)
        except:
            error_msg = 'Error occured retrieving documents'
        if error_msg is not None:
            return jsonify(msg=error_msg)
        elif len(result) > 0:
            for doc in result:
                documents.append(doc.to_json())
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

@bp.route('/delete/<int:document_id>', methods=['DELETE'])
def delete_document(document_id):
    if request.method == 'DELETE':
        error_msg = None
        try:
            document = Document.find_by_id(document_id)
        except:
            error_msg = 'Error occured finding document'
        if document is not None:
            try:
                delete_blob(document.name)
            except:
                error_msg = 'Error occured deleting Document from cloud.'
                return jsonify(msg=error_msg), 404
            try:
                document.delete_from_db()
            except:
                error_msg = 'Error occured deleting Document from database.'
                return jsonify(msg=error_msg), 404
#         if error_msg is not None:
#             return jsonify(msg=error_msg), 404
#         else:
            return jsonify(msg='Document deleted successfully')
