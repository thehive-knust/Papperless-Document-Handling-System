from database import db

users_approvals_table = db.Table(
    'users_approvals',
    db.Column('user_id', db.Integer, db.ForeignKey(
        'user.id'), primary_key=True),
    db.Column('approval_id', db.Integer, db.ForeignKey(
        'approval.id'), primary_key=True)
)
