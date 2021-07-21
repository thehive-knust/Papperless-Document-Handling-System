from pdhs_app import db


class Department(db.Model):
    department_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50))
    faculty_id = db.Column(
        db.Integer, db.ForeignKey('Faculty'), nullable=False)
    head = db.Column(db.Integer, db.ForeignKey('User'), nullable=False)
