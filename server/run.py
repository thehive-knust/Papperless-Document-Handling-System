__author__ = "Koffi-Cobbin"

from app import app #src

app.run(host='0.0.0.0', port="5000", debug=app.config['DEBUG'])
