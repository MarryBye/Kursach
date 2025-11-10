from vars import SECRET_KEY, DB_CONFIG
from os import path

DEBUG = True
SECRET_KEY = SECRET_KEY
DB_CONFIG = DB_CONFIG
STATIC_FOLDER = path.join('src', 'static')
TEMPLATE_FOLDER = path.join('src', 'templates')