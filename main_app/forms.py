from django import forms
from .models import QuestionBase


class QuestionForm(forms.ModelForm):
    class Meta:
        model = QuestionBase
        fields = ["question", "answer"]
        labels = {"question": "", "answer": ""}
