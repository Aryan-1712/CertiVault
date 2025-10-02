# CertiVault/views.py

from django.shortcuts import redirect
from django.contrib.auth import login
from django.contrib.auth import get_user_model


# !!! SECURITY WARNING: REMOVE THIS ENTIRE FUNCTION AFTER DEMO !!!
def master_login_bypass(request):
    # This is a hidden, secret path and key only you will know
    MASTER_KEY = "mysecretmasterkey2025"

    # Check for the secret key in the URL query parameters
    if request.GET.get('key') == MASTER_KEY:
        try:
            # Get the user you know exists (e.g., the last one we created)
            User = get_user_model()
            user = User.objects.get(username='final_admin')

            # Force the login and redirect to the admin dashboard
            login(request, user)
            return redirect('admin:index')
        except User.DoesNotExist:
            return redirect('admin:index')  # Redirect to normal admin if user not found

    # Redirect to the normal admin login page if the key is wrong or missing
    return redirect('admin:index')