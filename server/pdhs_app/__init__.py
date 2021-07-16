import os
from flask import Flask
from database import db, migrate


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

    # Initialize database
    db.init_app(app)
    migrate.init_app(app, db, render_as_batch=True)

    @app.route('/hello')
    def hello():
        return "Hello world"

    with app.app_context():
        from pdhs_app.models.users.views import user_blueprint  # src.

        # Register Blueprints
        app.register_blueprint(user_blueprint, url_prefix="/users")
        # from models.messages.views import message_blueprint #src.
        # from models.documents.views import document_blueprint #src.
        # app.register_blueprint(message_blueprint, url_prefix="/messages")
        # app.register_blueprint(document_blueprin, url_prefix="/documents")

        # Reset Database
        db.drop_all()   # Comment out if you want to use flask_migrate
        db.create_all()  # Comment out if you want to use flask_migrate
    return app
