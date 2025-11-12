from flask import request, session, jsonify, redirect, url_for

def get_something_view():
    return jsonify(
        {
            "message": "This is a GET response from get_something_view"
        }
    )