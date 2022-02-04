from django.shortcuts import render,redirect,get_object_or_404,get_list_or_404
from .forms import QuestionForm
from .models import QuestionBase


def base(request):
	return render(request, 'main_app/base.html')


def quest(request):
	question = QuestionBase.objects.all()
	form = QuestionForm(request.GET)
	context = {'question': question, 'form': form}
	return render(request, 'main_app/quiz.html', context)



def question(request):
	return render(request, 'main_app/make_question.html')


def count_result(request, quest_id):
	q = 0
	question = QuestionBase.objects.get(id=quest_id)
	if request.method == 'POST':
		form = QuestionForm(request.POST)
		if form.is_valid():
			user_answer = form.cleaned_data['answer']
			for u_a in user_answer:
				if u_a == question.answer:
					q += 1
			
	context = {'q': q}
	return render(request, 'main_app/score.html', context)
		



