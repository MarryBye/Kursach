from flask import request, session, render_template, redirect, url_for

def admin_home_view():
    return render_template('admin/home.html', **{
        "page_name": "Admin home"
    })