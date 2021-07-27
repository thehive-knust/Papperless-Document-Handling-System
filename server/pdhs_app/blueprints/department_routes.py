from flask import Blueprint, request, jsonify
from pdhs_app.models.users.user import User  # src.
from pdhs_app.models.departments.department import Department

bp = Blueprint('department', __name__, url_prefix='/department')


@bp.route('/hello', methods=['GET'])
def hello():
    if request.method == 'GET':
        return "Hello from /department"


@bp.route('/', methods=['GET'])
def get_all_departments():
    """
    Get all the departments in the department
    table.
    """
    if request.method == 'GET':
        departments = []
        result = []
        error_msg = None
        try:
            result = Department.query.all()
        except:
            error_msg = 'Error occured retrieving departments'
        if len(result) == 0:
            error_msg = 'No departments available'
        if error_msg is not None:
            return jsonify(msg=error_msg)
        else:
            for department in result:
                departments.append(department.to_json())
            return jsonify(departments=departments)


@bp.route('/<int:department_id>', methods=['GET'])
def get_department_by_id(department_id):
    """
    Get a particular department by id
    """
    if request.method == 'GET':
        error_msg = None
        try:
            department = Department.find_by_id(department_id)
        except:
            error_msg = 'Error occured finding department'
        if error_msg is not None:
            return jsonify(msg=error_msg), 404
        elif department is not None:
            return jsonify(department.to_json())


@bp.route('/create', methods=['POST'])
def create_department():
    """
    Create a department
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
            return jsonify(msg=error_msg), 500
        else:
            new_dept = Department(
                id=id,
                name=name,
                provost_id=provost_id
            )
            try:
                new_dept.save_to_db()
            except:
                return jsonify(msg='Error saving Department to database'), 500
            return jsonify(new_dept.to_json()), 201


@bp.route('/update/<int:department_id>', methods=['PUT'])
def update_department(department_id):
    """
    Update a Department
    """
    if request.method == 'PUT':
        department_id = request.json.get('id', None)
        name = request.json.get('name', None)
        faculty_id = request.json.get('faculty_id', None)

        if not department_id:
            return jsonify(msg='Id is required.'), 500
        else:
            try:
                new_dept = Department.find_by_id(department_id)
                if new_dept is not None:
                    if name is not None:
                        new_dept.name = name
                    if faculty_id is not None:
                        new_dept.faculty_id = faculty_id
                    new_dept.save_to_db()
            except:
                return jsonify(msg='Error updating Department'), 500
            return jsonify(new_dept.to_json()), 201


@bp.route('/delete/<int:department_id>', methods=['DELETE'])
def delete_department(department_id):
    if request.method == 'DELETE':
        error_msg = None
        try:
            department = Department.find_by_id(department_id)
        except:
            error_msg = 'Error occured finding department'
        if department is not None:
            try:
                department.delete_from_db()
            except:
                error_msg = 'Error occured deleting Department'
        if error_msg is not None:
            return jsonify(msg=error_msg), 404
        else:
            return jsonify(msg='Department deleted successfully')
