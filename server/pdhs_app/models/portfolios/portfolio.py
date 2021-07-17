from pdhs_app import db

class Portfolio(db.Model):
    portfolio_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    can_approve = db.Column()
    is_student = db.Column()
    faculty = db.relationship("Faculty", lazy='select', backref = db.backref('college', lazy='joined'))
    
    def __repr__(self):
        return '<Portfolio %r>' % self.portfolio_id