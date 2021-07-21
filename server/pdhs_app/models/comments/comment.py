from pdhs_app import db


class Comment(db.Model):
    _id = db.Column(db.Integer, primary_key=True)
    sender_id = db.Column(db.Integer, db.ForeignKey(
        'user._id'), nullable=False)
    document_id = db.Column(db.String(100), db.ForeignKey(
        'document._id'), nullable=False)
    content = db.Column(db.String(255), nullable=True)

    def __repr__(self):
        return '<Comment on %r>' % self.document_id

    @classmethod
    def find_by_id(cls, id):
        return cls.query.filter_by(_id=id).first()

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()
