from flask_restful import Resource, reqparse
from pdhs_app.models.users.user import User
from flask import request


class UserResource(Resource):
    parser = reqparse.RequestParser()

    parser.add_argument(
        'first_name',
        type=str,
        required=True,
        help='First Name is required'
    )
    parser.add_argument(
        'last_name',
        type=str,
        required=True,
        help='Last Name is required'
    )
    parser.add_argument(
        'email',
        type=str,
        required=True,
        help='Email address cannot be blank'
    )
    parser.add_argument(
        'password',
        type=str,
        required=True,
        help='Password field cannot be blank'
    )

    def post(self):
        data = self.parser.parse_args()
        # data = request.get_json()

        if User.find_by_email(data['email']):
            return {'message': "A user with that username already exists"}, 400

        user = User(**data)
        user.save_to_db()

        return {'message': 'User created successfully'}

    def get(self):
        result = User.query.all()
        users = [user.to_json() for user in result]
        return {'users': users}
