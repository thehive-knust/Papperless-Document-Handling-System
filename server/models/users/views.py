__author__ = "Koffi Cobbin"

from flask import Blueprint, request, session, url_for, flash, render_template
from werkzeug.utils import redirect
from models.users.user import User #src.
import models.users.errors as UserErrors #src.
import models.users.decorators as user_decorators #src.
import models.users.constants as UserConstants

user_blueprint = Blueprint('users', __name__)


@user_blueprint.route('/login', methods=['GET', 'POST'])
def login_user():
    if request.method == 'POST':
        user_id = request.form['user_id']
        password = request.form['password']
        try:
            if User.is_login_valid(user_id, password):
                session['user_id'] = user_id
                if user_id == UserConstants.ADMINS_EMAIL:
                    return redirect(url_for('.admins_page'))
                return redirect(url_for('.user_profile'))
        except UserErrors.UserError as e:
            flash('{}'.format(e.message))
            return render_template("users/login.html")
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
    user = Database.select_from_where("*", "user", f"user_id='{session['user_id']}'")
    return None

@user_blueprint.route('/edit_profile', methods=['POST', 'GET'])
@user_decorators.requires_login
def edit_profile():
    user = Database.select_from_where("*", "user", f"user_id='{session['user_id']}'")
    if request.method == 'POST':
        image = request.files['image_file'] 
        if image and allowed_file(image.filename):
            image_filename = secure_filename(image.filename)
            
            with tempfile.TemporaryDirectory() as tmpdirname:
                path = os.path.join(tmpdirname, image_filename)
                image.save(path)
        if path:
            Database.update("user",f"profile_image_link='{path}'", f"user_id='{user.id}'")
        return redirect(url_for('.profile'))
    return render_template('users/edit_profile.html', user=user)                                          
            
@user_blueprint.route('/logout')
def logout_user():
    session['user_id'] = None
    return redirect(url_for('home'))                 