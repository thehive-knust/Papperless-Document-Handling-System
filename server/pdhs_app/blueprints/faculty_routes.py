from flask import Blueprint, request, jsonify
from pdhs_app.models.users.user import User  # src.
from pdhs_app.models.faculties.faculty import Faculty

bp = Blueprint('faculties', __name__, url_prefix='/faculties')


@bp.route('/hello', methods=['GET'])
def hello():
    if request.method == 'GET':
        return "Hello from /faculty"


@bp.route('/', methods=['GET'])
def get_all_facultys():
    """
    Get all the faculties in the faculty
    table.
    """
    if request.method == 'GET':
        faculties = []
        result = []
        error_msg = None
        try:
            result = Faculty.query.all()
        except:
            error_msg = 'Error occured retrieving faculties'
        if len(result) == 0:
            error_msg = 'No faculties available'
        if error_msg is not None:
            return jsonify(msg=error_msg)
        else:
            for faculty in result:
                faculties.append(faculty.to_json())
            return jsonify(faculties=faculties)


@bp.route('/<int:faculty_id>', methods=['GET'])
def get_faculty_by_id(faculty_id):
    """
    Get a particular faculty by id
    """
    if request.method == 'GET':
        error_msg = None
        try:
            faculty = Faculty.find_by_id(faculty_id)
        except:
            error_msg = 'Error occured finding faculty'
        if error_msg is not None:
            return jsonify(msg=error_msg), 404
        elif faculty is not None:
            return jsonify(faculty.to_json())


@bp.route('/create', methods=['POST'])
def create_faculty():
    """
    Create a faculty
    """
    if request.method == 'POST':
        id = request.json.get('id', None)
        name = request.json.get('name', None)
        college_id = request.json.get('college_id', None)
        error_msg = None
        if not id:
            error_msg = 'Id is required.'
        elif not name:
            error_msg = 'Name is required.'
        elif not college_id:
            error_msg = 'Faculty ID is required.'
        if error_msg is not None:
            return jsonify(msg=error_msg), 500
        else:
            new_faculty = Faculty(
                id=id,
                name=name,
                college_id=college_id
            )
            try:
                new_faculty.save_to_db()
            except:
                return jsonify(msg='Error saving Faculty to database'), 500
            return jsonify(new_faculty.to_json()), 201


@bp.route('/update/<int:faculty_id>', methods=['PUT'])
def update_faculty(faculty_id):
    """
    Update a Faculty
    """
    if request.method == 'PUT':
        faculty_id = request.json.get('id', None)
        name = request.json.get('name', None)
        faculty_id = request.json.get('name', None)

        if not faculty_id:
            return jsonify(msg='Id is required.'), 500
        else:
            try:
                new_faculty = Faculty.find_by_id(faculty_id)
                if new_faculty is not None:
                    if name is not None:
                        new_faculty.name = name
                    if faculty_id is not None:
                        new_faculty.faculty_id = faculty_id
                    new_faculty.save_to_db()
            except:
                return jsonify(msg='Error updating Faculty'), 500
            return jsonify(new_faculty.to_json()), 201


@bp.route('/delete/<int:faculty_id>', methods=['DELETE'])
def delete_faculty(faculty_id):
    if request.method == 'DELETE':
        error_msg = None
        try:
            faculty = Faculty.find_by_id(faculty_id)
        except:
            error_msg = 'Error occured finding faculty'
        if faculty is not None:
            try:
                faculty.delete_from_db()
            except:
                error_msg = 'Error occured deleting Faculty'
        if error_msg is not None:
            return jsonify(msg=error_msg), 404
        else:
            return jsonify(msg='Faculty deleted successfully')
