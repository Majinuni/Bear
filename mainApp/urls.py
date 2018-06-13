from django.urls import path
from mainApp import views

urlpatterns = [
    path("home/", views.home, name="name"),
    # url(r'^home/$', home, name='home'),
    path("", views.dashboard, name="dashboard"),
    # url(r'^$', dashboard, name='dashboard'),
    path("area/", views.area, name="area"),
    # url(r'^area/$', area, name='area'),
    path("water/", views.water, name="water"),
    # url(r'^water/$', water, name='water'),
    path("waterpoints/<str:county>", views.waterpoints, name="waterpoints"),
]
