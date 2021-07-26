from database.db import db


class College(db.Model):
    college_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)
    provost = db.Column(db.Integer, db.ForeignKey('user.user_id', use_alter=True), nullable=False)
    faculty = db.relationship("Faculty", lazy='select', backref=db.backref('college', lazy='joined'))
    
    def __init__(self, college_id, name, provost):
        self.college_id = college_id
        self.name = name
        self.provost = provost

    def __repr__(self):
        return '<College %r>' % self.name

    @classmethod
    def find_by_name(cls, name):
        return cls.query.filter_by(name=name).first()

    @classmethod
    def find_by_id(cls, id):
        return cls.query.filter_by(college_id=id).first()

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()
