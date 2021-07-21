from pdhs_app import db

class Document(db.Model):
    document_id = db.Column(db.String(50), primary_key=True)
    email = db.Column(db.String(120), nullable=False)
    created_at = db.Column(db.DateTime(), nullable=False)
    updated_at = db.Column(db.DateTime(), nullable=False)
    subject = db.Column(db.String(255), nullable=False)
    user_id = db.Column(db.String(255), db.ForeignKey(
        'user.user_id'), nullable=False)
    filename = db.Column(db.String(255), nullable=False)
    progress = db.Column(db.String(50), nullable=False)
    description = db.Column(db.String, nullable=True)

    def __repr__(self):
        return '<User %r>' % self.username
