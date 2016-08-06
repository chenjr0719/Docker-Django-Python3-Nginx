From ubuntu:16.04

MAINTAINER Jacob chenjr0719@gmail.com

RUN apt-get update && apt-get install -y \
    git \
    vim \
    python3 \
    python3-pip \
    software-properties-common\
    python3-software-properties \
    sqlite3 \
    supervisor
 

RUN add-apt-repository ppa:nginx/stable
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

RUN pip3 install uwsgi django

# setup all the configfiles
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
COPY nginx-app.conf /etc/nginx/sites-available/default
COPY supervisor-app.conf /etc/supervisor/conf.d/

COPY uwsgi.ini /home/django/
COPY uwsgi_params /home/django/

RUN mkdir -p /home/django/website
RUN django-admin.py startproject website /home/django/website

EXPOSE 80
CMD ["supervisord", "-n"]
