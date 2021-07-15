# Backend

Flask framework is used with python for the backend or sever side of the application.
Also, the relational database used is Microsoft SQL.

# Setting up your Virtual Environment

The virtual environment is set up using virtualenv. virtualenv is a tool to create isolated Python environments. virtualenv creates a folder which contains all the necessary executables to use the packages that a Python project would need.

It can be used standalone, in place of Pipenv.

-- Install virtualenv via pip: `pip install virtualenv`

-- Test your installation: `virtualenv --version`

### Basic Usage

**Create a virtual environment for a project:**
-- `cd project_folder`
-- `virtualenv venv`

**Install project dependencies using pip:**
-- `pip install -r requirements.txt`

**Save project dependencies using pip:**
-- `pip freeze > requirements.txt`

### Read more about virtual environment here

-- https://docs.python-guide.org/dev/virtualenvs/#lower-level-virtualenv

# You can set your system up for flask

Before you install flask make sure you have python installed on your pc
-- pip install flask

# And install the following libraries or packages:

-- pip install flask-mysqldb
-- pip install passlib
-- pip install requests

# To run the application

-- Run the file `run.py`

# API

-- Login "192.168.43.205:5000/users/login"
