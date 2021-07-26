from database.db import db


class Approval(db.Model):
    approval_id = db.Column(db.Integer, primary_key=True)
    document_id = db.Column(db.Integer, db.ForeignKey('document.document_id'), nullable=False)
    recipient_id = db.Column(db.Integer, db.ForeignKey('user.user_id'), nullable=False)
    status = db.Column(db.Boolean)

    def __init__(self, approval_id, document_id, recipient_id, status):
        self.approval_id = approval_id
        self.document_id = document_id
        self.recipient_id = recipient_id
        self.status = status

    def __repr__(self):
        return '<Approval %r>' % self.approval_id

    @classmethod
    def find_by_id(cls, id):
        return cls.query.filter_by(approval_id=id).first()

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()
