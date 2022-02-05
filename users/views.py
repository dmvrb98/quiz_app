from django.shortcuts import render
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User


def register(request):
    """This one allows to register new user and redirects to the home page"""
    if request.method != "POST":
        form = UserCreationForm()
    else:
        form = UserCreationForm(data=request.POST)
        if form.is_valid():
            new_user = form.save()
            login(request, new_user)
            return redirect("main_app:base")
    context = {"form": form}
    return render(request, "registration/register.html", context)
