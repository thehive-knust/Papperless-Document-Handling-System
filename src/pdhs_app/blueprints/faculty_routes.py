from flask import Blueprint, request, jsonify, render_template
from src.pdhs_app.models.users.user import User  # src.
from src.pdhs_app.models.faculties.faculty import Faculty

bp = Blueprint('faculties', __name__, url_prefix='/faculty')


@bp.route('/', methods=['GET'])
def all():
    faculties = Faculty.query.all()
    result = [faculty.to_json() for faculty in faculties]
    return jsonify(result)


@bp.route('/new', methods=['GET', 'POST'])
def create_new_faculty():
    """
    Create a faculty
    """
    if request.method == 'POST':
        _id = request.form['id'] if request.form['id'] else request.json.get('id', None) 
        name = request.form['name'] if request.form['name'] else request.json.get('name', None)
        college_id = request.form['college_id'] if request.form['college_id'] else request.json.get('college_id', None)
        dean_id = None 
        
        error_msg = None
        if not _id:
            error_msg = 'Id is required.'
        elif not name:
            error_msg = 'Name is required.'
        elif not dean_id:
            dean_id = None
        if error_msg is not None:
            return jsonify(msg=error_msg), 500
        else:
            new_faculty = Faculty(id=int(_id), name=name, college_id=college_id, dean_id=dean_id)
            try:
                new_faculty.save_to_db() 
            except:
                return jsonify(msg='Error saving Faculty to database'), 500
            return jsonify(new_faculty.to_json()), 201 
    return render_template("faculties/add_faculty.html")
