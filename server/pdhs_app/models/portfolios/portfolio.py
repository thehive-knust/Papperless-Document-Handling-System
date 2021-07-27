from database.db import db


class Portfolio(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
<<<<<<< HEAD
    users = db.relationship("User", lazy='select', backref=db.backref('portfolio', lazy='joined'))
=======
    can_approve = db.Column(db.Boolean, default=False)
    is_student = db.Column(db.Boolean, default=False)
    users = db.relationship("User", lazy='select',
                            backref=db.backref('portfolio', lazy='joined'))
>>>>>>> f48fc4ec1e3e8c833ec0f44b33941a110903d53d

    def __repr__(self):
        return '<Portfolio %r>' % self.id

    @classmethod
    def find_by_name(cls, name):
        return cls.query.filter_by(name=name).first()

    @classmethod
    def find_by_id(cls, id):
        return cls.query.get(id)

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()

    def to_json(self):
        portfolio = {
            'id': self.id,
            'can_approve': self.can_approve,
            'is_student': self.is_student
        }
        return portfolio
