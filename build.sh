#!/usr/bin/env bash
# Exit on error
set -o errexit

# Install Python dependencies
pip install -r requirements.txt

# Collect static assets
python manage.py collectstatic --no-input

# Apply database migrations
python manage.py migrate
