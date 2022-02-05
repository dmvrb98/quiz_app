from django.db import models
from django.contrib.auth.models import User


BOOL_CHOICES = ((True, 'True'), (False, 'False'))


class QuestionBase(models.Model):
	question = models.CharField(max_length=70)
	answer = models.BooleanField(choices=BOOL_CHOICES)

	def __str__(self):
		return f"{self.question[:50]}..."


class AnswersCount(models.Model):
	user = models.OneToOneField(User, on_delete=models.CASCADE)
	question = models.OneToOneField(QuestionBase, on_delete=models.CASCADE)
	points_count = models.IntegerField(default=0)

	def __str__(self):
		return "Question - User - correct answers"
