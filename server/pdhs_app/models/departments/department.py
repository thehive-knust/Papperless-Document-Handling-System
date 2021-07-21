from database import db


class Department(db.Model):
    _id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    faculty_id = db.Column(
        db.Integer, db.ForeignKey('faculty._id'), nullable=False)
    head = db.Column(db.Integer, db.ForeignKey(
        'user._id', use_alter=True), nullable=False)
    users = db.relationship(
        "User", lazy='select', backref=db.backref('department', lazy='joined'))

    def __repr__(self):
        return '<Department %r>' % self.name

    @classmethod
    def find_by_name(cls, name):
        return cls.query.filter_by(name=name).first()

    @classmethod
    def find_by_id(cls, id):
        return cls.query.filter_by(id=id).first()

    @classmethod
    def find_by_head(cls, head):
        return cls.query.filter_by(head=head).first()

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()
