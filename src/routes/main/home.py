from flask import request, session, render_template, redirect, url_for

def main_home_view():
    return render_template('main/home.html', **{
        "page_name": "Main home"
    })