# Docker-Django-Python3-Nginx

Dockerfile and configuration files for Django with Python 3, uWSGI, and Nginx.

## About this Image/Dockerfile

This **Image/Dockerfile** aims to create a container for **Django** with **Python 3** and using **uWSGI**, **Nginx** to hosting.

The most part is referenced from [dockerfiles/django-uwsgi-nginx](https://github.com/dockerfiles/django-uwsgi-nginx).

I change the version of **Python** and modify the setting of **Nginx** to make it easier when you use static file of **Django**.

## How to use?

You can build this **Dockerfile** yourself:

```
sudo docker build -t "chenjr0719/django-uwsgi-nginx" .
```

Or, just pull my image:

```
sudo docker pull chenjr0719/django-uwsgi-nginx
```

Then, run this image:

```
sudo docker run -itd -p 80:80 chenjr0719/django-uwsgi-nginx
```

Now, you can see the initial project of **Django** at http://127.0.0.1

You can also change it to a different **port**.

For example, use 8080:

```
sudo docker run -itd -p 8080:80 chenjr0719/django-uwsgi-nginx
```

## Use your Django project?

If you want to use your **Django** project which you already developed, use following command:

```
sudo docker run -itd -p 80:80 -v $YOUR_PROJECET_DIR:/home/django/website chenjr0719/django-uwsgi-nginx
```

In order to make it work properly, make sure you project name is **website**.

If not, you need modify the setting of **uwsgi.ini** in your container:

```
sudo docker exec $CONTAINER_ID sed -i 's|'module=website.wsgi:application'|'module=$PROJECT_NAME.wsgi:application'|g' /home/django/uwsgi.ini
```

Or, you can just modify **uwsgi.ini** and rebuild this image.

## About Django static files

If you want to use **Django** static files, you have to:

1. Modify the setting of **Django**.

   In the **Static files** section, if your static files are in templates/static, add following setting:

   ```
   STATICFILES_DIRS = [
       os.path.join(BASE_DIR, "templates/static"),
   ]

   STATIC_ROOT = os.path.join(BASE_DIR, "static")
   ```

2. Run following command in your project to collect all static files of your project into a folder(In default, /static/):

   ```
   python manage.py collectstatic
   ```

3. If your want to use different name of static folder, you need to modify the setting of **nginx-app.conf** in your container.

   You can this command:

   ```
   sudo docker exec $CONTAINER_ID sed -i 's|'/home/django/website/static'|'/home/django/website/$STATIC_FOLDER_NAME'|g' /etc/nginx/sites-available/default
   ```

    Or, modify **nginx-app.conf** and revuild this image.
