import os
from pdhs_app.resources.document import DocumentResource
from flask import Flask
from database.db import db, migrate
from flask_restful import Api
from flask_jwt import JWT

from middleware.security import authenticate, identity

# import resources
from pdhs_app.resources.portfolio import PortfolioResource
from pdhs_app.resources.approval import ApprovalResource
from pdhs_app.resources.comment import CommentResource
from pdhs_app.resources.user import UserResource
from pdhs_app.resources.department import DepartmentResource
from pdhs_app.resources.faculty import FacultyResource
from pdhs_app.resources.college import CollegeResource
from pdhs_app.resources.document import DocumentResource

# import Blue prints
from pdhs_app.blueprints.user_routes import user_blueprint  # src.
from middleware.auth import bp as auth_bp


def create_app(*args, **kwargs):
    """
    Initialize core application using app factory.
    """
    try:
        env = kwargs['env']
    except KeyError as e:
        env = 'development'
        print('Error:', e, 'Environment was not specified, defaulting to development')

    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)

    app.config['ENV'] = env
    app.config.from_object('config.%s' % env)
    app.config['JWT_AUTH_USERNAME_KEY'] = 'email'
    app.config['SQLALCHEMY_DATABASE_URI'] = app.config['DATABASE_URI']
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    # print(app.config)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    from flask_cors import CORS

    CORS(app)

    # Initialize api
    api = Api(app)

    # Initialize JWT
    jwt = JWT(app, authenticate, identity)  # /auth

    # Add resources

    api.add_resource(UserResource, '/user')
    api.add_resource(PortfolioResource, '/portfolio')
    api.add_resource(DocumentResource, '/document')
    api.add_resource(ApprovalResource, '/approval')
    api.add_resource(CollegeResource, '/college')
    api.add_resource(DepartmentResource, '/department')
    api.add_resource(FacultyResource, '/faculty')
    api.add_resource(CommentResource, '/comment')

    # Initialize database
    db.init_app(app)
    migrate.init_app(app, db, render_as_batch=True)

    @app.route('/')
    def hello():
        return "Hello world"

    with app.app_context():

        # Register Blueprints
        # app.register_blueprint(user_blueprint, url_prefix="/users")
        # app.register_blueprint(auth_bp)
        # from models.messages.views import message_blueprint #src.
        # from models.documents.views import document_blueprint #src.
        # app.register_blueprint(message_blueprint, url_prefix="/messages")
        # app.register_blueprint(document_blueprin, url_prefix="/documents")

        # Reset Database
        db.drop_all()   # Comment out if you want to use flask_migrate
        db.create_all()  # Comment out if you want to use flask_migrate
    return app
