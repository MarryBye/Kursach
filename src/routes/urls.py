from src.routes.admin.home import admin_home_view
from src.routes.main.home import main_home_view

URLS = [
    ('/', "main_home_page", main_home_view),
    ('/admin', 'admin_home_page', admin_home_view),
]