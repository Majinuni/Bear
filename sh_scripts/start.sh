#!/bin/sh

pip3 install -r requirements.txt

python manage.py collectstatic --no-input
python manage.py makemigrations --no-input
python manage.py migrate --noinput

NAME=”majinuni” # Name of the application
NUM_WORKERS=3 # how many worker processes should Gunicorn spawn
MAX_REQUESTS=1 # reload the application server for each request

echo “Starting $NAME as `whoami` with Gunicorn.”

# Start your Django Unicorn
# Programs meant to be run under supervisor should not daemonize themselves
# (do not use –daemon)

exec gunicorn django_majinuni.wsgi:application \
    --name $NAME \
    --workers $NUM_WORKERS \
    --max-requests $MAX_REQUESTS \
    --bind=0.0.0.0:8000 \
    --log-level=error \
    --timeout=1200 \
    --reload
