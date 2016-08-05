# Docker-Django-Python3-Nginx

Dockerfile and configuration files for Django with Python 3, uWSGI, and Nginx.

## About this Image/Dockerfile

This **Image/Dockerfile** aims to create a container for **Django** with **Python 3** and using **uWSGI**, **Nginx** to hosting.

The most part is referenced from [dockerfiles/django-uwsgi-nginx](https://github.com/dockerfiles/django-uwsgi-nginx).

I change the version of **Python** and modify the seeting of **Nginx** to make it easier when you use static file of **Django**.

## How to use?

You can build this **Dockerfile** youself:

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

You can also change it to different **port**.

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

Or, modify the setting of **uwsgi.ini**:

```
module=website.wsgi:application
```

Replace **website** with your project name.

And, rebuild this image.

## About Django static files

If you want to use **Django** static files, you have to:

1. Modify the setting of **Django**.

   In the **Static files** section, add following seeting:

   ```
   STATICFILES_DIRS = [
       os.path.join(BASE_DIR, "templates/static"),
   ]

   STATIC_ROOT = os.path.join(BASE_DIR, "static")
   ```

2. Run following command in your project:

   ```
   python manage.py collectstatic
   ```

   This will collect all static files of your project into a folder(In default, static/).

3. If your project name is **website**, it should be all right.

   If not, you have to modify the setting of **nginx-app.conf**:

   ```
   # Django static file setting
       location /static {
           alias /home/django/website/static; # your Django project's static files
       }
   ```

   Replace the **path** with your static file path.
