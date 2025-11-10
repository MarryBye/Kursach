import flask
import config

from database.controller import Database

app = flask.Flask(__name__)

app.static_folder = config.STATIC_FOLDER
app.template_folder = config.TEMPLATE_FOLDER
app.secret_key = config.SECRET_KEY

db = Database(**config.DB_CONFIG)

@app.route('/')
def home():
    return "Welcome to the Home Page!"

app.run(debug=config.DEBUG)