from pdhs_app import db


class Faculty(db.Model):
    faculty_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50))
    college_id = db.Column(
        db.Integer, db.ForeignKey('Faculty'), nullable=False)
    departments = db.relationship(
        'Department', lazy='select', backref=db.backref('faculty', lazy='joined'))
    head = db.Column(db.Integer, db.ForeignKey('User'), nullable=False)
