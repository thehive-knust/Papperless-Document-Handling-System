from database.db import db
from datetime import datetime


class Document(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(120), nullable=False)
    created_at = db.Column(db.DateTime, nullable=False,
                           default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, nullable=False,
                           default=datetime.utcnow)
    subject = db.Column(db.String(255), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey(
        'user.id'), nullable=False)
    file = db.Column(db.String(255), nullable=False)
    progress = db.Column(db.String(50), nullable=False, default='Pending')
    description = db.Column(db.String(255), nullable=True)
    approvals = db.relationship('Approval', backref='document', lazy='joined')
    comment = db.relationship(
        'Comment', backref='document', lazy='joined', uselist=False)

    def __repr__(self):
        return '<Document %r>' % self.name

    @classmethod
    def find_by_name(cls, name):
        """
        Query the table represented by this model
        by the name column.
        :return: A Document object or None
        """
        return cls.query.filter_by(name=name).first()

    @classmethod
    def find_by_id(cls, id):
        """
        Query the table represented by this model
        by the id column.
        :return: A Document object or None
        """
        return cls.query.get(id)

    def save_to_db(self):
        """
        Save a record represented by this model object 
        into its table in the database.
        """
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        """
        Delete the record represented by this model object, 
        from its the table in the database.
        """
        db.session.delete(self)
        db.session.commit()

    def to_json(self):
        """
        Convert the model into a json serializable object.
        :return: a dictionary that maps table columns to their values
        """
        doc = {
            'id': self.id,
            'user_id': self.user_id,
            'name': self.name,
            'subject': self.subject,
            'file': self.file,
            'description': self.description,
            'progress': self.progress,
        }
        return doc
