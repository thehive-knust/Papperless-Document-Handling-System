from pdhs_app import db


class Approval(db.Model):
    approval_id = db.Column(db.Integer, primary_key=True)
    document_id = db.Column(
        db.Integer, db.ForeignKey('Document'), nullable=False)
    recepiece_id = db.Column(db.Integer, db.ForeignKey('User'), nullable=False)
    status = db.Column(db.Boolean)
