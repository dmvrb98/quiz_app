from django.contrib import admin
from django.urls import path, include
from . import views

app_name = "main_app"

urlpatterns = [
    path('', views.base, name='base'),
    path('', include('django.contrib.auth.urls')),
    path('make_question/', views.question, name='question'),
    path('quest/', views.quest, name='quest'),
    path('count_result/<int:quest_id>/', views.count_result, name='count_result'),


]