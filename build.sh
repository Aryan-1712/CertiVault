#!/usr/bin/env bash
# Exit immediately if any command fails
set -o errexit

# Install dependencies
python -m pip install --upgrade pip
python -m pip install -r requirements.txt

# Collect static files
python manage.py collectstatic --noinput

# Apply database migrations
python manage.py migrate

# Auto-create superuser
python manage.py shell << 'EOF'
from django.contrib.auth import get_user_model
User = get_user_model()
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@certivault.com', 'certivault2024')
    print("Superuser created successfully.")
else:
    print("Superuser already exists.")
EOF

# Load sample certificate data
python manage.py shell << 'EOF'
from core.models import Certificate
import datetime

samples = [
    {
        "certificate_id": "CERT-2024-001",
        "name": "Aryan Sharma",
        "ipfs_hash": "QmXg9Pp2ytZnifjeRbexXt7vavJD8TZZReFuLS9BS6YA2rT",
        "issue_date": datetime.date(2024, 6, 15),
    },
    {
        "certificate_id": "CERT-2024-002",
        "name": "Priya Patel",
        "ipfs_hash": "QmT4AeWE9Q8vRmF6nKjbXoP1cD7sHgLpMnQwZuYiBf3Ckv",
        "issue_date": datetime.date(2024, 8, 22),
    },
    {
        "certificate_id": "CERT-2024-003",
        "name": "Rahul Mehta",
        "ipfs_hash": "QmW7dNpRk2sVhCqJtXmAeLbP9uFyGo4ZrEiDwMnBv8Hs5j",
        "issue_date": datetime.date(2024, 11, 10),
    },
    {
        "certificate_id": "CERT-2024-004",
        "name": "Sneha Gupta",
        "ipfs_hash": "QmR3bKpNs6wXcVhDqJtYmAeLbP2uFyGo8ZrEiDwMnBv4Hs",
        "issue_date": datetime.date(2024, 9, 5),
    },
    {
        "certificate_id": "CERT-2024-005",
        "name": "Vikram Singh",
        "ipfs_hash": "QmP9cLqMs7vYdWhErKuJsZnBfPt3xGh5iRoDmEnCw6Aj1T",
        "issue_date": datetime.date(2024, 12, 1),
    },
]

created = 0
for data in samples:
    obj, was_created = Certificate.objects.get_or_create(
        certificate_id=data["certificate_id"],
        defaults=data
    )
    if was_created:
        created += 1

print(f"{created} sample certificate(s) created. {len(samples) - created} already existed.")
EOF
