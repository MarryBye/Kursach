import flask
import config
import src.routes.urls as urls

class App(flask.Flask):
    def __init__(self, *args, **kwargs):
        super(App, self).__init__(*args, **kwargs)
        
        self.__config()
        self.__load_urls()
        
    def __config(self):
        self.static_folder = config.STATIC_FOLDER
        self.template_folder = config.TEMPLATE_FOLDER
        self.secret_key = config.SECRET_KEY
        self.debug = config.DEBUG

    def __load_urls(self):
        for url in urls.URLS:
            self.add_url_rule(url[0], url[1], url[2])
