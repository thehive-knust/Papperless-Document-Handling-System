from database import db
from datetime import datetime


class Document(db.Model):
    _id = db.Column(db.String(50), primary_key=True)
    name = db.Column(db.String(120), nullable=False)
    created_at = db.Column(db.DateTime, nullable=False,
                           default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, nullable=False,
                           default=datetime.utcnow)
    subject = db.Column(db.String(255), nullable=False)
    user_id = db.Column(db.String(255), db.ForeignKey(
        'user._id'), nullable=False)
    filename = db.Column(db.String(255), nullable=False)
    progress = db.Column(db.String(50), nullable=False)
    description = db.Column(db.String, nullable=True)
    approvals = db.relationship('Approval', backref='document', lazy='joined')

    def __repr__(self):
        return '<Document %r>' % self.name

    @classmethod
    def find_by_name(cls, name):
        return cls.query.filter_by(name=name).first()

    @classmethod
    def find_by_id(cls, id):
        return cls.query.filter_by(_id=id).first()

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()
