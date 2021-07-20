__author__ = 'Koffi-Cobbin'
import MySQLdb 
from MySQLdb.cursors import DictCursor
# from config import mysql


class Database(object):
    ''' This is a code base for handling MySQL instructions '''
    @staticmethod
    def init_db():
        dpt_columns = "department_name VARCHAR(50) PRIMARY KEY, college VARCHAR(50) NOT NULL, faculty VARCHAR(50)"
        stf_columns = "staff_id INT PRIMARY KEY, first_name VARCHAR(20) NOT NULL, last_name VARCHAR(100) NOT NULL, email VARCHAR(50) NOT NULL, password VARCHAR(20) NOT NULL, position VARCHAR(50) NOT NULL, department_name VARCHAR(50) NOT NULL, profile_image_link VARCHAR(100), FOREIGN KEY (department_name) REFERENCES department(department_name)"
        ass_columns = "association_name VARCHAR(50) PRIMARY KEY,  department_name VARCHAR(50) NOT NULL, patron INT NOT NULL, FOREIGN KEY (department_name) REFERENCES department(department_name), CONSTRAINT patron FOREIGN KEY (patron) REFERENCES staff(staff_id)"
        std_columns = "student_id INT PRIMARY KEY, first_name VARCHAR(20) NOT NULL, last_name VARCHAR(100) NOT NULL, email VARCHAR(50) NOT NULL, password VARCHAR(20) NOT NULL, position VARCHAR(50) NOT NULL, department_name VARCHAR(50) NOT NULL, association_name VARCHAR(50) NOT NULL, profile_image_link VARCHAR(100), FOREIGN KEY (department_name) REFERENCES department(department_name), FOREIGN KEY (association_name) REFERENCES association(association_name)"
        doc_columns = "document_id VARCHAR(20) PRIMARY KEY, doc_name VARCHAR(50) NOT NULL, doc_type VARCHAR(20) NOT NULL, status VARCHAR(20), upload_time DATETIME, student_id INT NOT NULL, staff_id INT NOT NULL, FOREIGN KEY (student_id) REFERENCES student(student_id), FOREIGN KEY (staff_id) REFERENCES staff(staff_id)"
        msg_columns = "message_id INT PRIMARY KEY, content VARCHAR(255) NOT NULL, student_id INT NOT NULL, staff_id INT NOT NULL, FOREIGN KEY (student_id) REFERENCES student(student_id), FOREIGN KEY (staff_id) REFERENCES staff(staff_id)"
        apv_columns = "document_id VARCHAR(20), staff_id INT, PRIMARY KEY (document_id,staff_id), FOREIGN KEY (document_id) REFERENCES document(document_id), FOREIGN KEY (staff_id) REFERENCES staff(staff_id)"
        Database.create_table("department", dpt_columns)
        Database.create_table("staff", stf_columns)
        Database.create_table("association", ass_columns)
        Database.create_table("student", std_columns)
        Database.create_table("document", doc_columns)
        Database.create_table("message", msg_columns)
        Database.create_table("approval", apv_columns)

    @staticmethod
    def connect(query):
        cursor = mysql.connection.cursor(cursorclass=DictCursor) # The cursorclass arg was passed to override the default tuple output as a dict
        cursor.execute(f''' {query}''') # f string was used bc passing just the query wasn't working, it needed the quotes to execute
        mysql.connection.commit()
        return cursor

    @staticmethod
    def disconnect(cursor):
        cursor.close()
        return "Done!"

    @staticmethod
    def create_table(table_name, columns):
        query = '''CREATE TABLE ''' + table_name + ''' (''' + columns + ''')'''
        return Database.disconnect(Database.connect(query))

    @staticmethod
    def insert(table_name, data):
        ''' This piec of code generates a query based on the args given to pass to the db 
            :data = list of values to insert
            :table = table_name to insert data into 
        '''
        query = '''INSERT INTO ''' + table_name + ''' VALUES('''
        for value in data:
            if (value == data[len(data)-1]):
                query = query + "'"+ value + "')" if (type(value) == str) else query + str(value) + ")"
            else:
                query = query + "'"+ value + "'," if type(value) == str else query + str(value) + ","
        return Database.disconnect(Database.connect(query))


    @staticmethod
    def select_from_where(columns, table_name, data=None):
        query = ''' SELECT '''
        if type(columns)==list:
            for column in columns:
                query = query + column if column == columns[len(columns)-1] else query + column + ", "
        else:
            query = query + columns  

        if data:
            query = query + ''' FROM ''' + table_name + ''' WHERE ''' + data
        else:
            query = query + ''' FROM ''' + table_name 

        cursor = Database.connect(query)
        result = cursor.fetchall()
        val = Database.disconnect(cursor)
        return result

    @staticmethod
    def update(table_name, values, condition):
        query = '''UPDATE ''' + table_name + ''' SET ''' + values + ''' WHERE ''' + condition
        return  Database.disconnect(Database.connect(query))


    @staticmethod
    def delete(table_name, condition):
        query = '''DELETE FROM ''' + table_name + ''' WHERE ''' + condition
        return Database.disconnect(Database.connect(query))        
