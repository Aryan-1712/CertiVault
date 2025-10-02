CertiVault: Secure Certificate Verification System
CertiVault is a secure, web-based platform built with Django for issuing and verifying digital certificates. It uses a PostgreSQL database to store immutable certificate records, including a unique ID, recipient name, and an IPFS hash for authenticity, ensuring that all credentials can be verified against a single source of truth.

🚀 Live Deployment
The application is currently deployed and running live on Render:
https://certivault-52wn.onrender.com

🛠️ Technology Stack
Backend: Python 3.x, Django 4.x

Database: PostgreSQL (Managed by Render)

Hosting: Render (Web Service and Database)

Dependencies: gunicorn, dj-database-url, psycopg2-binary, whitenoise

⚙️ Local Setup and Installation
Follow these steps to get a local copy of the project running for development and testing.

1. Clone the Repository
git clone [https://github.com/your-username/CertiVault.git](https://github.com/your-username/CertiVault.git)
cd CertiVault

2. Create and Activate Virtual Environment
It is highly recommended to use a virtual environment to manage dependencies.

# Create the environment
python3 -m venv venv

# Activate the environment (Mac/Linux)
source venv/bin/activate

# Activate the environment (Windows)
.\venv\Scripts\activate

3. Install Dependencies
Install all necessary packages from the requirements.txt file.

pip install -r requirements.txt

4. Database Setup
For local development, the settings.py file is configured to use SQLite.

# Apply initial migrations
python manage.py migrate

# Create a local superuser for accessing the Admin panel (optional)
python manage.py createsuperuser

5. Run the Server
python manage.py runserver

The application will be accessible at http://127.0.0.1:8000/.

☁️ Production Deployment (Render)
CertiVault is configured for seamless deployment on Render using the following files:

Environment Variables
The following environment variables MUST be set on the Render dashboard:

Variable Name

Value

Description

SECRET_KEY

Your unique key

Django's security key.

DATABASE_URL

Your PostgreSQL connection string

Used by dj-database-url to connect to the DB.

DEBUG

False

Must be False for production security.

ALLOWED_HOSTS

* or your Render URL

Allows access from the live domain.

Build and Startup Commands
Render uses the following commands:

Command

Usage

Build Command

pip install -r requirements.txt

Start Command

gunicorn CertiVault.wsgi

🔑 Admin Access (Troubleshooting Note)
Note on Admin Login: Due to complex session handling issues with the cloud proxy server, direct admin login can sometimes be temporarily unstable.

The recommended solution for data management and login is to:

Run python manage.py changepassword [username] while connected to the live PostgreSQL database to reset credentials.

Use the Admin panel when logged in from a fresh Incognito/Private browser window.

✅ Core Functionality Verification
To confirm the entire stack (App, Database, Deployment) is working:

Insert Sample Data into the live database using the Django shell (as done during setup).

Certificate ID: CERT-0001-DEMO

Navigate to the live site: https://certivault-52wn.onrender.com

Enter the ID and click Verify. A successful return confirms the full system integrity.
