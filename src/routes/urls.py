from src.routes.admin.home import admin_home_view
from src.routes.main.home import main_home_view
from src.routes.api.get_something import get_something_view

URLS = [
    ('/', "main_home_page", main_home_view),
    ('/admin', 'admin_home_page', admin_home_view),
    ('/api/get_something', 'get_something', get_something_view),
]