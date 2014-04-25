from django.db import models
# from easy_maps import models
from django.contrib.auth.models import User

# current understanding: scores displayed in real time at the corner of the screen
# users can log in the contribute to commentary of what's happening if they are in the vicinity of the game
# otherwise, users can give their opinions of what is happening. 
# users in vicinity of game can +5 or -1 the reputation points of users in the vicinity who are giving a description of the game 

# stores meta info about each sports league

class Venue(models.Model):
	venue_id = models.CharField(primary_key=True, max_length=36)
	name = models.CharField(max_length=50) # name of the venue
	capacity = models.IntegerField(blank=True, null=True)
	address = models.CharField(max_length=200) 

# stores meta info about each team
class Team(models.Model):
	team_id = models.CharField(primary_key=True, max_length=36)
	whole_name = models.CharField(max_length=36) # whole name of the team, i.e., market + name
	market = models.CharField(max_length=36, blank=True, null=True)
	name = models.CharField(max_length=36, blank=True, null=True)

	league = models.CharField(max_length=20) # league to which the team belongs
	venue = models.ForeignKey(Venue) # home venue of the team
	alias = models.CharField(max_length=3, blank=True, null=True)

	def __unicode__(self):
		return self.name

# stores meta info about each game
class Game(models.Model):
	game_id = models.CharField(primary_key=True, max_length=36)
	venue = models.ForeignKey(Venue)
	league = models.CharField(max_length=20) # league to which the game belongs
	start_time = models.DateTimeField()
	home_team = models.ForeignKey(Team, related_name='home_team')
	away_team = models.ForeignKey(Team, related_name='away_team')

# stores player info of each team
class Player(models.Model):
	player_id = models.CharField(primary_key=True, max_length=36)
	team = models.ForeignKey(Team)
	position = models.CharField(max_length=10)
	jersey = models.CharField(max_length=3, blank=True, null=True)
	first_name = models.CharField(max_length=50)
	last_name = models.CharField(max_length=50)
	weight = models.CharField(max_length=5, blank=True, null=True)
	height = models.CharField(max_length=1, blank=True, null=True)
	birth_date = models.DateField(blank=True, null=True)
	birth_city = models.CharField(max_length=30, blank=True, null=True)
	birth_state = models.CharField(max_length=2, blank=True, null=True)
	birth_country = models.CharField(max_length=30, blank=True, null=True)
	college = models.CharField(max_length=50, blank=True, null=True)



# stores user meta information
class UserInfo(models.Model):
	confirmKey = models.CharField(max_length=100,verbose_name="confirmation Key")
	user = models.OneToOneField(User)
	gamesFollowing = models.ManyToManyField(Game) # has list of games user is following
	reputation = models.IntegerField() # stores reputation points of user

# each post about an update in the game, or a question about a controversial event in the game
class Post(models.Model):
	text = models.CharField(max_length=500)
	user = models.ForeignKey(User)
	# date field set to now when created
	# required is False in ModelForm
	date = models.DateTimeField(auto_now_add=True, blank=True, null=True)
	picture = models.ImageField(upload_to="game-photos", blank=True)
	game = models.ForeignKey(Game)
	likers = models.ManyToManyField(User, related_name="like_posts")

	def sorted_response_set(self):
		return self.response_set.order_by('-date')

	def __unicode__(self):
		return self.id


class Question(models.Model):
	text = models.CharField(max_length=500)
	user = models.ForeignKey(User)
	resolved = models.BooleanField() # true if the question is marked as resolved by the owner
	bounty = models.IntegerField() # the bounty of a question, to be added to the user who resolved it
	# answers = models.ManyToManyField(Post) # a question can have multiple posts as answers
	date = models.DateTimeField(auto_now_add=True, blank=True,null=True)
	game = models.ForeignKey(Game)

	def sorted_answer_set(self):
		return self.response_set.order_by('-date')

	def __unicode__(self): 
		return self.id


class Response(models.Model):
	text = models.CharField(max_length=500)
	user = models.ForeignKey(User)
	date = models.DateTimeField(auto_now_add=True, blank=True, null=True)

	post = models.ForeignKey(Post, blank=True, null=True)
	question = models.ForeignKey(Question, blank=True, null=True)

	best_answer = models.NullBooleanField(blank=True, null=True) # true if it is the best answer for a question
	picture = models.ImageField(upload_to="game-photos", blank=True)
	votes = models.IntegerField(blank=True, null=True)
	voters = models.ManyToManyField(User, related_name='voters')

