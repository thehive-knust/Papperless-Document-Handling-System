from flask import Blueprint, request, jsonify
from pdhs_app.models.users.user import User  # src.
from pdhs_app.models.departments.department import Department
from pdhs_app.models.portfolios.portfolio import Portfolio


bp = Blueprint('department', __name__, url_prefix='/department')

@bp.route('/get/<int:college_id>', methods=['GET'])
def get_departments(college_id):
    if request.method == 'GET':
        departments = Department.query.filter_by(college_id=college_id)
        return jsonify(departments)

@bp.route('get_portfolio/<int:department_id>', methods=['DELETE'])
def get_department_portfolios(department_id):
    users = User.query.filter_by(department_id=department_id)
    portfolio_ids = list(set([ user.portfolio_id for user in users ].sort()))
    portfolios = []
    for id in portfolio_ids:
        portfolios.append(Portfolio.find_by_id(id).to_json())
    return jsonify(portfolios)