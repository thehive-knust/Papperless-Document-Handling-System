from pdhs_app import db
from common.utils import Utils
import users.errors as UserErrors
class User(db.Model):
    user_id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(50), nullable=False)
    last_name = db.Column(db.String(50), nullable=False)
    email = db.Column(db.String(50), nullable=False)
    password = db.Column(db.String(255), nullable=False)
    portfolio_id = db.Column(db.Integer, db.ForeignKey('portfolio._id'), nullable=False)
    department_id = db.Column(db.String(100), db.ForeignKey('department._id'), nullable=False)
    faculty_id = db.Column(db.String(50),db.ForeignKey('faculty._id'), nullable=False)
    college_id = db.Column(db.String(50),db.ForeignKey('college._id'), nullable=False)
    documents = db.relationship("Document", lazy='select', backref = db.backref('user', lazy='joined'))
    portfolios = db.relationship("Comment", lazy='select', backref = db.backref('user', lazy='joined'))
    
    def __repr__(self):
        return '<User %r>' % self.user_id

    @staticmethod
    def is_login_valid(user_id, password):
        """
        This method verifies that an user_id/password combo (As sent by the site forms) is valid or not.
        Checks that the user exists and that the password associated to the user is correct.
        :param user_id: The user's ID (ie. student ID or staff ID)
        :param password: A sha512 hashed password
        :return: True if valid, False if otherwise.
        """
        # checking if user actually exists
        try:
            user = User.query.filter_by(user_id=user_id).first()
        except:
            user = None
        if user:
            if not Utils.check_hashed_password(password, user.password):
                # Tell the user that their password is wrong
                raise UserErrors.IncorrectPasswordError("Invalid Password")
        else:
            # Tell the user their user_id does'nt exist
            raise UserErrors.UserDontExistError("User does'nt exist")
        return user

    @staticmethod
    def register_user(user_id, first_name, last_name, email, password, portfolio):
        """
        This registers a user using user_id, first_name, last_name, e-mail and password.
        :param user_id: The user's ID (ie. student ID or staff ID)
        :param email:   user's e-mail (might be invalid)
        :param password:    sha256-hashed password  
        :param portfolio:    the user's position (eg. HOD, Secretary, President etc.) as an int
        :return: True if registered successfully, or False otherwise (exceptions can also be raised)
        """
        # checking if user actually exists
        try:
            user = User.query.filter_by(user_id=user_id).first()
        except:
            user = None
        if user:
            # Tell user they already exist
            raise UserErrors.UserAlreadyRegisteredError("User already exists.")
        
        # add the new user to the database
        new_user = User(user_id, first_name, last_name, email, password, portfolio)
        db.session.add(new_user)
        db.session.commit()
        return True
