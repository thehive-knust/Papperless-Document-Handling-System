import os
from flask_sqlalchemy import SQLAlchemy
from flask import Flask, render_template, request


def create_app(*args, **kwargs):
    env = kwargs['env']
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)
    # app.config.from_mapping(
    #     DATABASE=os.path.join(
    #         app.instance_path, os.environ.get('DEV_DATABASE')),
    # )
    app.config['ENV'] = env
    app.config.from_object('config.%s' % env)
    app.config['SQLALCHEMY_DATABASE_URI'] = app.config['DATABASE_URI']
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    print(app.config)

    # Alternative configuration
    # if app.config['ENV'] == 'production':
    #     app.config.from_object('config.ProductionConfig')
    # elif app.config['ENV'] == 'testing':
    #     app.config.from_object('config.TestingConfig')
    # else:
    #     app.config.from_object('config.DevelopmentConfig')

    # if test_config is None:
    #     # load the instance config, if it exists, when not testing
    #     app.config.from_pyfile('./config.py', silent=True)
    # else:
    #     # load the test config if passed in
    #     app.config.from_mapping(test_config)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    from flask_cors import CORS

    CORS(app)

    from database import db
    db.init_app(app)
    from pdhs_app.models.users.views import user_blueprint  # src.
    app.register_blueprint(user_blueprint, url_prefix="/users")

    # a simple page that says hello
    @app.route('/hello')
    def hello():
        return "Hello world"

    # from models.messages.views import message_blueprint #src.
    # from models.documents.views import document_blueprint #src.
    # app.register_blueprint(message_blueprint, url_prefix="/messages")
    # app.register_blueprint(document_blueprin, url_prefix="/documents")

    return app
