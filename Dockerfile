From ubuntu:16.04

MAINTAINER Jacob chenjr0719@gmail.com

RUN apt-get update && apt-get install -y \
    git \
    vim \
    python3 \
    python3-pip \
    nginx \
    sqlite3 \
    supervisor && rm -rf /var/lib/apt/lists/*

RUN pip3 install uwsgi django

# setup all the configfiles
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
COPY nginx-site.conf /etc/nginx/sites-available/default
COPY supervisor.conf /etc/supervisor/conf.d/

COPY uwsgi.ini /home/django/
COPY uwsgi_params /home/django/

COPY start.sh /home/django/

EXPOSE 80
CMD ["/bin/bash", "/home/django/start.sh"]
