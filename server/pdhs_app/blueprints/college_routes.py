from flask import Blueprint, request, jsonify
from pdhs_app.models.users.user import User  # src.
from pdhs_app.models.colleges.college import College

bp = Blueprint('colleges', __name__, url_prefix='/college')


@bp.route('/add_college', methods=['POST'])
def add_college():
    if request.method == 'POST':
        result = request.get_json()
        college_id = result['college_id']
        name = result['name']
        provost = result['provost']
        
        new_college = College(college_id, name, provost).save_to_db()
        return {"message": "Done!"}
