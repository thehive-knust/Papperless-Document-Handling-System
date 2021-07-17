from pdhs_app import db

class Comment(db.Model):
    sender_id = db.Column(db.Integer, db.ForeignKey('user.user_id'), nullable=False)
    document_id = db.Column(db.String(100), db.ForeignKey('document.document_id'), nullable=False)
    content = db.Column(db.String(255), nullable=True)
    def __repr__(self):
        return '<Comment on %r>' % self.document_id