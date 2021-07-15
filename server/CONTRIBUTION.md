# Setting up your environment

# Virtual Environment

The virtual environment is set up using virtualenv. Youvirtualenv is a tool to create isolated Python environments. virtualenv creates a folder which contains all the necessary executables to use the packages that a Python project would need.

It can be used standalone, in place of Pipenv.

-- Install virtualenv via pip: `pip install virtualenv`

-- Test your installation: `virtualenv --version`

### Basic Usage

- **Create a virtual environment for a project:**
  -- `cd project_folder`
  -- `virtualenv venv`

`virtualenv venv` will create a folder in the current directory which will contain the Python executable files, and a copy of the pip library which you can use to install other packages. The name of the virtual environment (in this case, it was venv) can be anything; omitting the name will place the files in the current directory instead.

#### Note

‘venv’ is the general convention used globally. As it is readily available in ignore files (eg: .gitignore’)
This creates a copy of Python in whichever directory you ran the command in, placing it in a folder named `venv`.

- **To begin using the virtual environment, it needs to be activated:**
  Assuming that you are in your project directory:

`C:\Users\SomeUser\project_folder> venv\Scripts\activate`

The name of the current virtual environment will now appear on the left of the prompt (e.g. (venv)Your-Computer:project_folder UserName$) to let you know that it’s active. From now on, any package that you install using pip will be placed in the venv folder, isolated from the global Python installation.

**Install packages using the pip command:**
-- eg `pip install requests`

- **If you are done working in the virtual environment for the moment, you can deactivate it:**
  `deactivate`

This puts you back to the system’s default Python interpreter with all its installed libraries.

To delete a virtual environment, just delete its folder. (In this case, it would be `rm -rf venv`.)

In order to keep your environment consistent, it’s a good idea to “freeze” the current state of the environment packages. To do this, run:

#### `pip freeze > requirements.txt`

This will create a requirements.txt file, which contains a simple list of all the packages in the current environment, and their respective versions. You can see the list of installed packages without the requirements format using `pip list`. Later it will be easier for a different developer (or you, if you need to re-create the environment) to install the same packages using the same versions:

#### `pip install -r requirements.txt`

This can help ensure consistency across installations, across deployments, and across developers.
