from pdhs_app import db
__author__ = "Koffi Cobbin"

from flask import Blueprint, request, session, url_for, flash, render_template, jsonify
from werkzeug.utils import redirect
from pdhs_app.models.users.user import User  # src.
import pdhs_app.models.users.errors as UserErrors  # src.
import pdhs_app.models.users.decorators as user_decorators  # src.
import pdhs_app.models.users.constants as UserConstants
import json

user_blueprint = Blueprint('users', __name__)


@user_blueprint.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        # content = request.get_json()
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        print(request_data)
        user_id = request_data['user_id']
        password = request_data['password']
        print(user_id)
        print(password)
        try:
            if User.is_login_valid(user_id, password):
                # session['user_id'] = user_id
                # if user_id == UserConstants.ADMINS_EMAIL:
                #     return jsonify({""})
                return jsonify({"user_name": "Koffi Cobbin", "position": "General Secretary"})
        except UserErrors.UserError as e:
            return jsonify({"error_message": f"{e.message}"})
    return render_template("users/login.html")


@user_blueprint.route('/register', methods=['GET', 'POST'])
def register_user():
    if request.method == 'POST':
        user_id = request.form['user_id']
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        email = request.form['email']
        password = request.form['password']
        portfolio = request.form['portfolio']
        department_name = request.form['department_name']

        # this try part catches errors and displays them in a user
        # friendly way.
        try:
            if User.register_user(user_id, first_name, last_name, email, password, portfolio, department_name):
                session['user_id'] = user_id
                return redirect(url_for('.profile'))
        except UserErrors.UserError as e:
            flash('{}'.format(e.message))
            return render_template("users/signup.html")

    return render_template("users/signup.html")


@user_blueprint.route('/alerts')
@user_decorators.requires_login
def user_alerts():
    return None


@user_blueprint.route('/admin')
@user_decorators.requires_login
def admins_page():
    return None

# The profile page section


@user_blueprint.route('/profile')
@user_decorators.requires_login
def profile():
    user = Database.select_from_where(
        "*", "user", f"user_id='{session['user_id']}'")
    return None


@user_blueprint.route('/edit_profile', methods=['POST', 'GET'])
@user_decorators.requires_login
def edit_profile():
    user = Database.select_from_where(
        "*", "user", f"user_id='{session['user_id']}'")
    if request.method == 'POST':
        image = request.files['image_file']
        if image and allowed_file(image.filename):
            image_filename = secure_filename(image.filename)

            with tempfile.TemporaryDirectory() as tmpdirname:
                path = os.path.join(tmpdirname, image_filename)
                image.save(path)
        if path:
            Database.update(
                "user", f"profile_image_link='{path}'", f"user_id='{user.id}'")
        return redirect(url_for('.profile'))
    return render_template('users/edit_profile.html', user=user)


@user_blueprint.route('/try')
def try_():
    admin = User(username='adasdfmin', email='admin@example.com')
    guest = User(username='gueasdfst', email='guesthj@example.com')
    db.session.add(admin)
    db.session.add(guest)
    db.session.commit()
    users = User.query.all()
    return render_template("test.html", users=users)


@user_blueprint.route('/logout')
def logout_user():
    session['user_id'] = None
    return redirect(url_for('home'))