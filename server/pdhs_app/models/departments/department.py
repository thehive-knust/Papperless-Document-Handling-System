__author__ = "Koffi Cobbin"
import uuid
from common.database import Database
import models.departments.errors as DepartmentErrors
        

class User(object):
    def __init__(self, department_name, college):
        self.department_name = department_name  # INT PRIMARY KEY
        self.college = college                  # VARCHAR(50) NOT NULL

    