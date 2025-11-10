from vars import SECRET_KEY
from os import path

DEBUG = True
SECRET_KEY = SECRET_KEY
STATIC_FOLDER = path.join('src', 'static')
TEMPLATE_FOLDER = path.join('src', 'templates')