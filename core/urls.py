from django.urls import path
from . import views

urlpatterns = [
    path('', views.verify_certificate, name='verify_certificate'),
]