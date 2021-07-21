from database import db


class Approval(db.Model):
    _id = db.Column(db.Integer, primary_key=True)
    document_id = db.Column(
        db.Integer, db.ForeignKey('document._id'), nullable=False)
    recipient_id = db.Column(
        db.Integer, db.ForeignKey('user._id'), nullable=False)
    status = db.Column(db.Boolean)

    def __repr__(self):
        return '<Approval %r>' % self._id

    @classmethod
    def find_by_email(cls, email):
        return cls.query.filter_by(email=email).first()

    @classmethod
    def find_by_id(cls, id):
        return cls.query.filter_by(_id=id).first()

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()
