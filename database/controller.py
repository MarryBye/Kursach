import psycopg2 as sql

from os import path, walk
from typing import Literal

MAP = {}

for root, dirs, files in walk("./database/queries/"):
    for file in files:
        if file.endswith(".sql"):
            full_path = path.join(root, file)
            filename_without_ext = path.splitext(file)[0]
            MAP[filename_without_ext] = full_path

QUERIES = Literal[
    "create_tables",
    "create_types",
    "create_functions",
    "fill_administrator",
    "fill_car_class",
    "fill_car_status",
    "fill_car",
    "fill_clients",
    "fill_dispatcher"
]

class Database:
    def __init__(self, **config):
        self.__config: dict[str, str] = config
        self.__connection: None | sql.extensions.connection = None
        self.__cursor: None | sql.extensions.cursor = None
        
    def connect(self):
        self.__connection = sql.connect(**self.__config)
        self.__cursor = self.__connection.cursor()
        return self.__cursor

    def disconnect(self):
        self.__cursor.close()
        self.__connection.close()
        
    def load_query(self, query: QUERIES) -> str:
        with open(MAP[query], "r", encoding="utf-8") as file:
            return file.read()
        
    def execute(self, query: QUERIES, parameters=tuple[any], auto_commit=True, fetch_count=-1):
        self.connect()

        self.__cursor.execute(self.load_query(query), parameters)

        if auto_commit:
            self.__connection.commit()
            
        match fetch_count:
            case 0:
                result = None
            case 1:
                result = self.__cursor.fetchone()
            case -1:
                result = self.__cursor.fetchmany(fetch_count)
            case _:
                result = self.__cursor.fetchall()

        self.disconnect()
        
        return result