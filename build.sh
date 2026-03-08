#!/usr/bin/env bash
# Exit immediately if any command fails
set -o errexit

# Install all dependencies
pip install -r requirements.txt

# Collect static files (CSS, JS, images) into staticfiles/
python manage.py collectstatic --noinput

# Apply any pending database migrations
python manage.py migrate
