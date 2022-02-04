from django.db import models

class QuestionBase(models.Model):
	question = models.CharField(max_length=70)
	BOOL_CHOICES = ((True, 'True'), (False, 'False'))
	answer = models.BooleanField(choices=BOOL_CHOICES)
	

	def __str__(self):
		return f"{self.question[:50]}..."

