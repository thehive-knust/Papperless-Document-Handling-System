from database.db import db


class Portfolio(db.Model):
    portfolio_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    users = db.relationship("User", lazy='select', backref=db.backref('portfolio', lazy='joined'))

    def __repr__(self):
        return '<Portfolio %r>' % self.portfolio_id
