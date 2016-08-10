#!/bin/bash

SETTING_PATH=`find /home/django/ -name settings.py`

# Check is there already exist any django project
if [ -z "$SETTING_PATH" ] ; then

    # Create new django project
    mkdir -p /home/django/website/
    django-admin startproject website /home/django/website

    SETTING_PATH=`find /home/django/ -name settings.py`

else

    # Install requirements
    if [ -f /home/django/website/requirements.txt ]; then
        pip3 install -r /home/django/website/requirements.txt
    fi

fi

# Start all the services
/usr/bin/supervisord -n
