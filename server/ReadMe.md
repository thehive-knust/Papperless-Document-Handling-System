# Backend

Flask framework is used with python for the backend or sever side of the application.
Also, the relational database used is Microsoft SQL.

# Setting up your Virtual Environment

The virtual environment is set up using virtualenv. virtualenv is a tool to create isolated Python environments. virtualenv creates a folder which contains all the necessary executables to use the packages that a Python project would need.

It can be used standalone, in place of Pipenv.

-- Install virtualenv via pip: `pip install virtualenv`

-- Test your installation: `virtualenv --version`

### Basic Usage

**Create a virtual environment for a project:**\
-- `cd project_folder`\
-- `virtualenv venv`

**Install project dependencies using pip:**\
-- `pip install -r requirements.txt`

**Save project dependencies using pip:**\
-- `pip freeze > requirements.txt`

### Read more about virtual environment here

-- https://docs.python-guide.org/dev/virtualenvs/#lower-level-virtualenv

# You can set your system up for flask

Before you install flask make sure you have python installed on your pc\
-- pip install flask

# And install the following libraries or packages:

-- pip install flask-mysqldb\
-- pip install passlib\
-- pip install requests

# Extra setup

-- Create a `.env ` file in the root folder i.e. `server`\
-- In the .env file set INSTANCE_PATH="absolute/path/to/root/folder"\
-- Set SECRET_KEY\
-- Set SQL_LITE_PATH="name_of_sqlite_db_to_be_created"\
-- Contact the Project Manager for other sensitive environment variables which are excluded for security reasons

# To run the application

--Set FLASK*APP environment variable to pdhs_app (app module) in the terminal using:*\
`$env:FLASK_APP='pdhs_app'`\
-- Run the file `run.py`

# Miscellaneous

**Migrations**\
Migration is done using flask migrated\
You can learn more here: https://flask-migrate.readthedocs.io/

**Others**\
-- Flask-SQLAlchemy as ORM\
-- This project utilizes sqlite database for local development and an SQL server for production

# APIs
**User APIs**\
Login : /user/login\
Sign-Up : /user/register/{user_id}\
Delete User : /user/delete/{user_id}\
Get User by mail    : /user/{email}\
Get User by ID  : /user/{user_id}\
Get All Users : /user/all

**Document APIs**\
Upload document : /document/upload\
Get new documents : /document/new/{user_id}\
Get approved docs : /document/approved/{user_id}\
Get rejected docs : /document/rejected/{user_id}\
