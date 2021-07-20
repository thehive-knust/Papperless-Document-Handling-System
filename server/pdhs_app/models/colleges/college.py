from pdhs_app import db

class College(db.Model):
    college_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)
    faculty = db.relationship("Faculty", lazy='select', backref = db.backref('college', lazy='joined'))
    
    def __repr__(self):
        return '<College %r>' % self.college_id