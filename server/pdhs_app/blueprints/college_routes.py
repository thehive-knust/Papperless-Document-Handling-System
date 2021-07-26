from flask import Blueprint, request, jsonify
from pdhs_app.models.users.user import User  # src.
from pdhs_app.models.colleges.college import College

bp = Blueprint('colleges', __name__, url_prefix='/colleges')


@bp.route('/hello', methods=['GET'])
def hello():
    if request.method == 'GET':
        return "Hello from /college"


@bp.route('/', methods=['GET'])
def get_all_colleges():
    """
    Get all the colleges in the college
    table.
    """
    if request.method == 'GET':
        colleges = []
        result = []
        error_msg = None
        try:
            result = College.query.all()
        except:
            error_msg = 'Error occured retrieving colleges'
        if len(result) == 0:
            error_msg = 'No colleges available'
        if error_msg is not None:
            return jsonify(msg=error_msg)
        else:
            for college in result:
                colleges.append(college.to_json())
            return jsonify(colleges=colleges)


@bp.route('/<int:college_id>', methods=['GET'])
def get_college_by_id(college_id):
    """
    Get a particular college by id
    """
    if request.method == 'GET':
        college = None
        error_msg = None
        try:
            college = College.find_by_id(college_id)
            print(college)
        except:
            error_msg = 'Error occured finding college'
        if error_msg is not None:
            return jsonify(msg=error_msg), 404
        elif college is not None:
            return jsonify(college.to_json())


@bp.route('/create', methods=['POST'])
def create_college():
    """
    Create a college
    """
    if request.method == 'POST':
        id = request.json.get('id', None)
        name = request.json.get('name', None)
        provost_id = request.json.get('provost_id', None)

        error_msg = None
        if not id:
            error_msg = 'Id is required.'
        elif not name:
            error_msg = 'Name is required.'
        elif not provost_id:
            provost_id = 0
        if error_msg is not None:
            return jsonify(msg=error_msg)
        else:
            new_collge = College(
                id=id,
                name=name,
                provost_id=provost_id
            )
            try:
                new_collge.save_to_db()
            except:
                return jsonify(msg='Error saving College to database')
            return jsonify(new_collge.to_json())
