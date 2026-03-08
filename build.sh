#!/usr/bin/env bash
# Exit immediately if any command fails
set -o errexit

# Use python -m pip to ensure we install into the correct Python environment
python -m pip install --upgrade pip
python -m pip install -r requirements.txt

# Collect static files
python manage.py collectstatic --noinput

# Apply database migrations
python manage.py migrate
