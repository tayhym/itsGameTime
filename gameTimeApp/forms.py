from django import forms
from gameTimeApp.models import *

class RegisterForm(forms.Form):
    email = forms.CharField(max_length=200,
                            widget=forms.TextInput(attrs={'class': 'form-control modal-input', 'placeholder': 'Email Address', 'autofocus': '', 'type': 'email', 'required': ''}))
    first_name = forms.CharField(max_length=30,
                                 widget=forms.TextInput(attrs={'class': 'form-control modal-input', 'placeholder': 'First Name', 'required': ''}))
    last_name = forms.CharField(max_length=30,
                                widget=forms.TextInput(attrs={'class': 'form-control modal-input', 'placeholder': 'Last Name', 'required': ''}))
    password1 = forms.CharField(max_length=200,
                                label='Password',
                                widget=forms.PasswordInput(attrs={'class': 'form-control modal-input', 'placeholder': 'Password', 'type': 'password', 'required': ''}))
    password2 = forms.CharField(max_length=200,
                                label='Confirm password',
                                widget=forms.PasswordInput(attrs={'class': 'form-control modal-input', 'placeholder': 'Password Again', 'type': 'password', 'required': ''}))

class QuestionForm(forms.ModelForm):
	class Meta: 
		model = Question
		fields = ['text', 'bounty']
		exclude = ('user','answers','date','gameId')
		widgets = {
            'text': forms.TextInput(attrs={'class': 'form-control', 'style':'height:70px; margin-bottom:8px;', 'placeholder': 'Ask your question here...', 'autofocus':'', 'required': ''})
        }

class PostForm(forms.ModelForm):
	class Meta: 
		model = Post
		fields = ['text','picture']
		exclude = ('user', 'date', 'game_id','ranking')
		widgets = {
            'text': forms.TextInput(attrs={'class': 'form-control', 'style':'height:70px; margin-bottom:8px;', 'placeholder': 'Post a comment...', 'autofocus':'', 'required': ''}), 'picture': forms.FileInput(attrs={'text': 'Add a picture (optional)'})
        }

class ResponseForm(forms.ModelForm):
	class Meta:
		model = Response
		fields = ['text', 'picture']
		exclude = ('user', 'date', 'post', 'question')
		widgets = {
            'text': forms.TextInput(attrs={'class': 'form-control', 'style':'height:70px; margin-bottom:8px;', 'placeholder': ' Add your answer here...', 'autofocus':'', 'required': ''}), 'picture': forms.FileInput(attrs={'text': 'Add a picture (optional)'})
        }

class HistoryForm(forms.Form):
    teams = forms.ModelMultipleChoiceField(queryset=Team.objects.none(), required=False, help_text="")
        # Countries = forms.MultipleChoiceField(widget=forms.CheckboxSelectMultiple,
        #                                      choices=OPTIONS)
    # dynamically pass league title when instantiating
    startDate = forms.DateTimeField(input_formats='%m/%d/%Y')
    endDate = forms.DateTimeField(input_formats='%m/%d/%Y')

    def __init__(self, league): 
        super(HistoryForm, self).__init__()
        self.fields['teams'].queryset = Team.objects.filter(league=league)
        # print self.fields['teams'].queryset
        self.helpText = ''




