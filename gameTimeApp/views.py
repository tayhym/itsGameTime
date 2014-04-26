from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.contrib.auth import logout
from django.core.exceptions import ValidationError
from django.core.validators import validate_email
from django.core.urlresolvers import reverse
from gameTimeApp.models import *
from gameTimeApp.forms import *
from django.db import transaction
from django.http import HttpResponse, HttpResponseRedirect, StreamingHttpResponse
from mimetypes import guess_type
from django.core.mail import send_mail
from django.contrib.auth import login, authenticate
from django.views.decorators.http import require_http_methods

import json
import dateutil.parser
import re
import urllib2
import os.path
import sys
import urllib2
import datetime
import time
import xml.etree.ElementTree as ET
import random

key_dict = {'nba':'y6ytb65x4aa65anucqefq2up', 'nhl':'vrnt63n7zg54symwn3m7tw4s', 'nfl':'yt477s5drjxn2eb6xumnu237', 'mlb':'z883vkekaeb48rhzkhr2bvsh'}

# home page: flash updates, search feature based on sports categories, 
def home(request):
    context = {}
    context['register_form'] = RegisterForm()
    user = request.user
    return render(request, 'gameTimeApp/index.html', context)

def about(request):
    context = {}
    return render(request,'gameTimeApp/about.html',context)

# get daily schedule from database
def find_game(request, league, date):
    context = {}
    year = date[:4]
    month = date[4:6]
    day = date[6:]
    games = Game.objects.filter(start_time__year=year, start_time__month=month, start_time__day=day, league=league.lower())
    context['games'] = games
    context['league'] = league.upper()
    context['register_form'] = RegisterForm()
    return render(request, 'gameTimeApp/find-game.html', context)


def populate_data(request, league):
    context = {}
    league_name = league.lower()
    # key_dict = {'nba':'y6ytb65x4aa65anucqefq2up', 'nhl':'vrnt63n7zg54symwn3m7tw4s', 'nfl':'yt477s5drjxn2eb6xumnu237', 'mlb':'z883vkekaeb48rhzkhr2bvsh'}
    api_key = key_dict[league_name]
    

    if league_name == 'nba' or league_name == 'nhl' or league_name == 'nfl':
        get_teams(league_name, api_key)
        time.sleep(1)
        get_season_schedule(league_name, api_key, '2013', 'PST')
    if league_name == 'mlb':

        get_venues(league_name, api_key)
        time.sleep(1)
        # get_teams(league_name, api_key, '2013')
        # time.sleep(1)
        get_teams(league_name, api_key, '2014')
        time.sleep(1)

        get_players(league_name, api_key, '2014')
        time.sleep(1)
        # get_season_schedule(league, '2013', api_key)
        # time.sleep(1)
        get_season_schedule(league_name, api_key, '2014')

    return redirect(reverse('home'))


def get_daily_schedule(request, league, date):
    context = {}
    league_name = league.lower()
    url = ''
    year = date[:4]
    month = date[4:6]
    day = date[6:]
    formated_date = year + '/' + month + '/' + day

    # key_dict = {'nba':'y6ytb65x4aa65anucqefq2up', 'nhl':'vrnt63n7zg54symwn3m7tw4s', 'nfl':'yt477s5drjxn2eb6xumnu237', 'mlb':'z883vkekaeb48rhzkhr2bvsh'}
    xmlns_pattern = r"\sxmlns=\"http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+\""    
    try:
        f = None
        if league_name == 'nba':
            url = 'http://api.sportsdatallc.org/nba-t3/games/%s/schedule.xml?api_key=%s'
            f = urllib2.urlopen(url % (formated_date, key_dict['nba']))

        xml_input = re.sub(xmlns_pattern,'',f.read())
        f.close()
        return HttpResponse(xml_input, content_type='application/xml')
    except Exception, e:
        print >> sys.stderr, e

def get_boxscore(request, league, game_id):
    league_name = league.lower()
    # key_dict = {'nba':'y6ytb65x4aa65anucqefq2up', 'nhl':'vrnt63n7zg54symwn3m7tw4s', 'nfl':'yt477s5drjxn2eb6xumnu237', 'mlb':'z883vkekaeb48rhzkhr2bvsh'}
    xmlns_pattern = r"\sxmlns=\"http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+\""
    try:
        f = None
        if league_name == 'nba' or league_name == 'nhl':
            url = 'http://api.sportsdatallc.org/%s-t3/games/%s/boxscore.xml?api_key=%s'
            f = urllib2.urlopen(url % (league_name, game_id, key_dict[league_name]))
        if league_name == 'mlb':
            url = 'http://api.sportsdatallc.org/mlb-t4/boxscore/%s.xml?api_key=%s'
            f = urllib2.urlopen(url % (game_id, key_dict['mlb']))
        xml_input = re.sub(xmlns_pattern,'',f.read())
        f.close()
        return HttpResponse(xml_input, content_type='application/xml')
    except Exception, e:
        print >> sys.stderr, e

def get_stats(request, league, game_id):
    league_name = league.lower()
    # key_dict = {'nba':'y6ytb65x4aa65anucqefq2up', 'nhl':'vrnt63n7zg54symwn3m7tw4s', 'nfl':'yt477s5drjxn2eb6xumnu237', 'mlb':'z883vkekaeb48rhzkhr2bvsh'}
    url = ''
    xmlns_pattern = r"\sxmlns=\"http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+\""
    try:
        f = None
        if league_name == 'nba' or league_name == 'nhl':
            url = 'http://api.sportsdatallc.org/%s-t3/games/%s/summary.xml?api_key=%s'
            f = urllib2.urlopen(url % (league_name, game_id, key_dict[league_name]))
        if league_name == 'mlb':
            url = 'http://api.sportsdatallc.org/mlb-t4/statistics/%s.xml?api_key=%s'
            f = urllib2.urlopen(url % (game_id, key_dict['mlb']))
        xml_input = re.sub(xmlns_pattern,'',f.read())
        f.close()
        return HttpResponse(xml_input, content_type='application/xml')
    except Exception, e:
        print >> sys.stderr, e

def get_season_schedule(league, api_key, year, season_type=None):
    context = {}
    # key_dict = {'nba':'y6ytb65x4aa65anucqefq2up', 'nhl':'vrnt63n7zg54symwn3m7tw4s', 'nfl':'yt477s5drjxn2eb6xumnu237', 'mlb':'z883vkekaeb48rhzkhr2bvsh'}
    xmlns_pattern = r"\sxmlns=\"http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+\""
    try:
        f = None
        if league == 'nba' or league == 'nhl':
            url = 'http://api.sportsdatallc.org/%s-t%d/games/%s/%s/schedule.xml?api_key=%s'
            f = urllib2.urlopen(url % (league, 3, year, season_type, api_key))
            
            
        if league == 'nfl':
            url = 'http://api.sportsdatallc.org/nfl-t1/%s/%s/schedule.xml?api_key=%s'
            f = urllib2.urlopen(url % (year, season_type, api_key))

        if league == 'mlb':
            url = 'http://api.sportsdatallc.org/mlb-t4/schedule/%s.xml?api_key=%s'
            f = urllib2.urlopen(url % (year, api_key))


        # delete the xmlns information associated with each tag
        xml_input = re.sub(xmlns_pattern,'',f.read())

        f.close()

        root = ET.XML(xml_input)

        games = None
        if league == 'nba' or league == 'nhl':
            games = root.find('season-schedule').find('games')
        if league == 'nfl':
            games = []
            for week_schedule in root.findall('week'):
                for game in week_schedule.findall('game'):
                    games.append(game)
        if league == 'mlb':
            games = root.findall('event')

        for game_tree in games:
            id = game_tree.get('id')
            home_team_id = None
            away_team_id = None
            start_time = None
            venue_id = None
            # print >> sys.stderr, id
            if league == 'nba' or league == 'nhl':
                home_team_id = game_tree.get('home_team')
                away_team_id = game_tree.get('away_team')
            if league == 'nfl':
                home_team_id = game_tree.get('home')
                away_team_id = game_tree.get('away')
            if league == 'mlb':
                home_team_id = game_tree.get('home')
                away_team_id = game_tree.get('visitor')

            if league == 'nba' or league == 'nhl' or league == 'nfl':
                start_time = dateutil.parser.parse(game_tree.get('scheduled'))
                venue_tree = game_tree.find('venue')
                venue_id = venue_tree.get('id')
            if league == 'mlb':
                start_time = dateutil.parser.parse(game_tree.find('scheduled_start').text)
                venue_id = game_tree.get('venue')
            

            if not Venue.objects.filter(pk=venue_id).count():
                venue_name = venue_tree.get('name')
                venue_address = ''
                if venue_tree.get('address'):
                    venue_address = venue_tree.get('address') + ', ' + venue_tree.get('city') + ', ' + venue_tree.get('country')
                else:
                    venue_address = venue_tree.get('city') + ', ' + venue_tree.get('country')
                venue_capcity = venue_tree.get('capacity')
                new_venue = Venue(venue_id=venue_id, name=venue_name, address=venue_address, capacity=int(venue_capcity))
                new_venue.save()

            if not Team.objects.filter(pk=home_team_id).count():
                home_tree = game_tree.find('home')
                team_name = home_tree.get('name')
                team_alias = home_tree.get('alias')
                new_team = Team(team_id=home_team_id, name=team_name, alias=team_alias, league=league, venue=Venue.objects.get(pk=venue_id))
                new_team.save()

            if not Team.objects.filter(pk=away_team_id).count():
                away_tree = game_tree.find('away')
                team_name = away_tree.get('name')
                team_alias = away_tree.get('alias')
                new_team = Team(team_id=away_team_id, name=team_name, alias=team_alias, league=league, venue=Venue.objects.get(pk=venue_id))
                new_team.save()

            new_game = Game(game_id=id, venue=Venue.objects.get(pk=venue_id), league=league, start_time=start_time, home_team=Team.objects.get(pk=home_team_id), away_team=Team.objects.get(pk=away_team_id))
            new_game.save()
    except Exception, e:
        print >> sys.stderr, e

def get_teams(league, api_key, year=None):

    url = 'http://api.sportsdatallc.org/%s-t%d/league/hierarchy.xml?api_key=%s'
    xmlns_pattern = r"\sxmlns=\"http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+\""
    try:
        f = None
        if league == 'nba' or league == 'nhl':
            f = urllib2.urlopen(url % (league, 3, api_key))

        if league == 'nfl':
            url = 'http://api.sportsdatallc.org/nfl-t1/teams/hierarchy.xml?api_key=%s'
            f = urllib2.urlopen(url % (api_key))

        if league == 'mlb':
            url = 'http://api.sportsdatallc.org/mlb-t4/teams/%s.xml?api_key=%s'
            f = urllib2.urlopen(url % (year, api_key))

        xml_input = re.sub(xmlns_pattern,'',f.read())
        f.close()

        root = ET.XML(xml_input)

        teams = None
        if league == 'nba' or league == 'nhl' or league == 'nfl':
            teams = []
            for conference in root.findall('conference'):
                for division in conference.findall('division'):
                    for team in division.findall('team'):
                        teams.append(team)
        if league == 'mlb':
            teams = root.findall('team')

        for team_tree in teams:
            id = team_tree.get('id')
            if team_tree.get('market'):
                market = team_tree.get('market')
                name = team_tree.get('name')
                whole_name = market + ' ' + name
                if league == 'nba' or league == 'nhl' or league == 'nfl':
                    alias = team_tree.get('alias')
                    venue_tree = team_tree.find('venue')
                    venue_id = venue_tree.get('id')
                    venue_name = venue_tree.get('name')
                    venue_address = venue_tree.get('address') + ', ' + venue_tree.get('city') + ', ' + venue_tree.get('state') + ', ' + venue_tree.get('zip') + ', ' + venue_tree.get('country')
                    venue_capcity = venue_tree.get('capacity')
                    venue = Venue(venue_id=venue_id, name=venue_name, address=venue_address, capacity=int(venue_capcity))
                    venue.save()
                if league == 'mlb':
                    if team_tree.get('venue'):
                        alias = team_tree.get('abbr')
                        venue_id = team_tree.get('venue')
                        venue = Venue.objects.get(pk=venue_id)

                team = Team(team_id=id, market=market, name=name, whole_name=whole_name, league=league, venue=venue, alias=alias)
                team.save()
    except Exception, e:
        print >> sys.stderr, e

def get_venues(league, api_key):
    context = {}

    url = 'http://api.sportsdatallc.org/%s-t%d/venues/venues.xml?api_key=%s'
    xmlns_pattern = r"\sxmlns=\"http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+\""

    try:
        f = None
        if league == 'mlb':
            f = urllib2.urlopen(url % (league, 4, api_key))

        xml_input = re.sub(xmlns_pattern,'',f.read())
        f.close()

        root = ET.XML(xml_input)
        for venue_tree in root.findall('venue'):
            venue_id = venue_tree.get('id')
            venue_name = venue_tree.get("name")
            if venue_tree.get('market'):
                venue_address = venue_name + ', ' + venue_tree.get('market')
            else:
                venue_address = venue_name
            venue = Venue(venue_id=venue_id, name=venue_name, address=venue_address)
            venue.save()
    except Exception, e:
        print >> sys.stderr, e

def get_players(league, api_key, year):

    xmlns_pattern = r"\sxmlns=\"http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+\""
    try:
        f = None
        if league == 'mlb':
            url = 'http://api.sportsdatallc.org/mlb-t4/rosters-full/%s.xml?api_key=%s'
            f = urllib2.urlopen(url % (year, api_key))

        xml_input = re.sub(xmlns_pattern,'',f.read())
        f.close()

        root = ET.XML(xml_input)

        if league == "mlb":
            teams = root.findall('team')
            for team_tree in teams:
                team_id = team_tree.get('id')
                if team_tree.find('players'):
                    for player_tree in team_tree.find('players').findall('player'):
                        jersey = player_tree.get('jersey')
                        position = player_tree.get('primary_position')
                        player_id = player_tree.get('id')
                        last_name = player_tree.get('last_name')
                        first_name = player_tree.get('first_name')
                        weight = player_tree.get('weight')
                        height = player_tree.get('height')
                        birth_date = ''
                        if player_tree.get('birthdate'):
                            birth_date = datetime.datetime.strptime(player_tree.get('birthdate'), "%Y-%m-%d")
                        birth_city = player_tree.get('birthcity')
                        birth_state = player_tree.get('birthstate')
                        birth_country = player_tree.get('birthcountry')
                        college = player_tree.get('college')
                        new_player = Player(jersey=jersey, position=position,
                                            player_id=player_id, last_name=last_name,
                                            first_name=first_name, weight=weight, 
                                            height=height, 
                                            birth_city=birth_city, birth_state=birth_state,
                                            birth_country=birth_country, college=college,
                                            team=Team.objects.get(pk=team_id))

                        if birth_date:
                            new_player.birth_date=birth_date

                        new_player.save()

    except Exception, e:
        print >> sys.stderr, e        

@require_http_methods(["POST"])
def login_ajax(request):
    if request.is_ajax:
        usrname = request.POST['usrname']
        pwd = request.POST['pwd']
        user = authenticate(username=usrname, password=pwd)
        result = {}
        if user:
            if user.is_active:
                login(request, user)
                result['status'] = 'true'
                result['name'] = user.first_name
            else:
                result['status'] = 'false'
                result['reason'] = 'Please confirm your registration before login.'
        else:
            result['status'] = 'false'
            result['reason'] = 'Invalid email and password combination.'
    data = json.dumps(result)
    return HttpResponse(data, content_type='application/json')

@require_http_methods(["POST"])
@transaction.commit_on_success
def register(request):
    if request.is_ajax:
        result = {}
        result['status'] = 'true'
        data_dict = request.POST
        # cleaned_data = register_form.cleaned_data
        # print cleaned_data

        errors = []


        if data_dict['password1'] != data_dict['password2']:
            result['status'] = 'false'
            errors.append('Passwords do not match.')

        if User.objects.filter(username=data_dict['email']).exists():
            result['status'] = 'false'
            errors.append('Email address already registered.')
            User.objects.get(username=data_dict['email']).delete() # must change this back when not in debug

        try:
            validate_email(data_dict['email'])
        except (ValidationError):
            result['status'] = 'false'
            errors.append('Email address format not valid.')

        if result['status'] == 'false':
            result['errors'] = errors
            return HttpResponse(json.dumps(result), content_type='application/json')
        else:
            # register User instance with database.
            new_user = User.objects.create_user(username=data_dict['email'],\
                                                first_name=data_dict['first_name'],\
                                                last_name=data_dict['last_name'],\
                                                email=data_dict['email'],\
                                                password=data_dict['password1'])

            new_user.is_active=False
            new_user.save()
            # user is not considered active until he submits confirmation email
            minNum = 1
            maxNum = 100000000000000
            randNumString = str(random.randint(minNum, maxNum))
            new_userInfo = UserInfo(confirmKey=randNumString,user=new_user,reputation=10)
            new_userInfo.save() 

            # send confirmation email
            message = 'Thanks for signing up for gameTime, '+ \
                       data_dict['first_name'] + \
                       '. Click this link to confirm your account: '+ \
                       '\nhttp://localhost:8000/gameTime/confirmation/confirmKey='+\
                       randNumString+'/userid='+ str(new_user.id)+'/'

            subject = 'Confirm your GameTime account'

            send_mail(subject, message,'xiaohuay@cs.cmu.edu', \
                      [data_dict['email']])

            result['message'] = "Thank you for registrating! A confirmation email has been sent to you."
            return HttpResponse(json.dumps(result), content_type='application/json')


def get_game_page(request, game_id,activeTab):
    context = {}
    target_game = get_object_or_404(Game, game_id=game_id)
    context['home_team'] = target_game.home_team
    context['away_team'] = target_game.away_team
    if (activeTab):
        context['activeTab'] = activeTab
    else: 
        context['activeTab'] = "commentary"
    context['game_id'] = game_id

    context['questions'] = Question.objects.filter(game=target_game).order_by('-date')
    context['blog_posts'] = Post.objects.filter(game=target_game).order_by('-date')
    context['reply_form'] = ResponseForm()
    context['blog_form'] = PostForm()
    context['question_form'] = QuestionForm()
    context['answer_form'] = ResponseForm()
    context['register_form'] = RegisterForm()
    if request.user.is_authenticated():
        request.user.userinfo.gamesFollowing.add(target_game)
    print game_id
    return render(request, 'gameTimeApp/game-page.html',context)

@login_required
def stop_following(request, game_id):
    target_game = get_object_or_404(Game, game_id=game_id)
    request.user.userinfo.gamesFollowing.remove(target_game)
    return HttpResponse('true')

# def getQuestions(request, game_id):
#     context = {}
#     return render(request, 'gameTimeApp/gamePage.html',context)

@transaction.commit_on_success
@login_required
def post_question(request, game_id):
    context = {}
    user = request.user
    target_game = get_object_or_404(Game, game_id=game_id)
    context['home_team'] = target_game.home_team
    context['away_team'] = target_game.away_team
    request.user.userinfo.gamesFollowing.add(target_game)
    context['game_id'] = game_id

    context['questions'] = Question.objects.filter(game=target_game).order_by('-date')
    context['activeTab'] = "q&A"



    if (request.method == 'POST'): 
        form = QuestionForm(request.POST)
        context['qustion_form'] = form
        if (form.is_valid()):
            # save to database
            cleaned_data = form.cleaned_data
            new_question = Question(text=cleaned_data['text'], user=request.user, 
                                    game=target_game, resolved=False, bounty=cleaned_data['bounty']) # will add in user=request.user when registration page is added
            new_question.save()
            print "new_question: "+ new_question.text 
            # print "checkDB" + str(len(Question.objects.filter(game_id=game_id).order_by('-date')))
            return redirect('/gameTime/game-page/'+game_id+'/q&A')
        else:
            length = len(form.data['text'])
            if (length == 0):
                context['message'] = "Too few characters"
            elif (length > 500):
                context['message'] = "Too many characters (500 max)"
    else:
        form = QuestionForm()
        context['question_form'] = form

    # update questions displayed
    context['blog_form'] = PostForm()
    context['reply_form'] = ResponseForm()
    context['answer_form'] = ResponseForm()
    context['question_form'] = QuestionForm()
    context['questions'] = Question.objects.filter(game=target_game).order_by('-date')
    context['blog_posts'] = Post.objects.filter(game=target_game).order_by('-date')
        
    return render(request, 'gameTimeApp/game-page.html',context)

# set ranking to start at 0 points. higher points means higher ranking.
@transaction.commit_on_success
@login_required
def add_answer(request, source, question_id): 
    context={}
    question = Question.objects.get(id=question_id)
    game_id = question.game.game_id

    target_game = get_object_or_404(Game, game_id=game_id)
    context['home_team'] = target_game.home_team
    context['away_team'] = target_game.away_team
    request.user.userinfo.gamesFollowing.add(target_game)

    context['game_id'] = game_id
    context['questions'] = Question.objects.filter(game=target_game).order_by('-date')
    context['activeTab'] = "q&A"
    

    if (request.method=='POST'):
        form=ResponseForm(request.POST, request.FILES)
        if (form.is_valid()):
            cleaned_data = form.cleaned_data
            new_answer = Response(text=cleaned_data['text'], user=request.user,
                             picture=cleaned_data['picture'], votes=0, best_answer=False, question=question)
            new_answer.save()

        else:
            length = len(form.data['text'])
            if (length == 0):
                context['message'] = "Too few characters"
            elif (length > 500):
                context['message'] = "Too many characters (500 max)"

    # step might not be necessary, but is to update question after addition of answers
    context['blog_posts'] = Post.objects.filter(game=target_game).order_by('-date')
    context['questions'] = Question.objects.filter(game=target_game).order_by('-date')
    context['blog_form'] = PostForm()
    context['reply_form'] = ResponseForm()
    context['question_form'] = QuestionForm()
    context['answer_form'] = ResponseForm()
    if source == 'game':
        return render(request,'gameTimeApp/game-page.html',context)
    if source == 'manage':
        return render(request,'gameTimeApp/manage.html', context)

@transaction.commit_on_success
@login_required
def add_reply(request, source, comment_id):
    context={}
    user = request.user
    comment = Post.objects.get(id=comment_id)
    game_id = comment.game.game_id

    target_game = get_object_or_404(Game, game_id=game_id)
    context['home_team'] = target_game.home_team
    context['away_team'] = target_game.away_team
    request.user.userinfo.gamesFollowing.add(target_game)

    context['game_id'] = game_id
    context['questions'] = Question.objects.filter(game=target_game).order_by('-date')
    context['activeTab'] = 'commentary'
    context['blog_posts'] = Post.objects.filter(game=target_game).order_by('-date')
    if (request.method == 'POST'):
        form = ResponseForm(request.POST)
        context['reply_form'] = form
        if (form.is_valid()):
            cleaned_data = form.cleaned_data
            new_reply = Response(text=cleaned_data['text'], user=request.user,
                                 post=comment)
            new_reply.save()

    context['blog_form'] = PostForm()
    context['reply_form'] = ResponseForm()
    context['question_form'] = QuestionForm()
    context['answer_form'] = ResponseForm()
    if source == 'game':
        return render(request,'gameTimeApp/game-page.html',context)
    if source == 'manage':
        return render(request,'gameTimeApp/manage.html', context)

@transaction.commit_on_success
@login_required
def post_blog(request,game_id):
    context={}
    target_user = request.user

    target_game = get_object_or_404(Game, game_id=game_id)
    context['home_team'] = target_game.home_team
    context['away_team'] = target_game.away_team
    request.user.userinfo.gamesFollowing.add(target_game)

    context['game_id'] = game_id
    context['questions'] = Question.objects.filter(game=target_game).order_by('-date')
    context['activeTab'] = 'commentary'
    context['blog_posts'] = Post.objects.filter(game=target_game).order_by('-date')

    if (request.method=='POST'):
        form=PostForm(request.POST, request.FILES)
        context['blog_form'] = form
        if (form.is_valid()):
            cleaned_data = form.cleaned_data
            new_blog = Post(text=cleaned_data['text'], user=target_user,
                             picture=cleaned_data['picture'],game=target_game)
            new_blog.save()
        # else:
        #     length = len(form.data['text'])
        #     if (length > 500):
        #         context['blogmessage'] = "Too many characters (500 max)"

    context['blog_form'] = PostForm()
    context['reply_form'] = ResponseForm()
    context['question_form'] = QuestionForm()
    context['answer_form'] = ResponseForm()

    # step might not be necessary, but is to update question after addition of answers
    return render(request,'gameTimeApp/game-page.html',context)

@login_required
def like(request, post_id, flag):
    target_post = Post.objects.get(id=post_id)
    if flag == '0':
        target_post.likers.add(request.user)
    if flag == '1':
        target_post.likers.remove(request.user)
    target_post.save()
    return HttpResponse('')

@login_required
def up_vote(request, answer_id):
    target_answer = Response.objects.get(id=answer_id)
    target_user = request.user
    if target_user not in target_answer.voters.all():
        target_answer.voters.add(target_user)
        target_answer.votes += 1
        target_answer.save()
        return HttpResponse('vote allowed')
    else:
        return HttpResponse('vote denied')

@login_required
def dn_vote(request, answer_id):
    target_answer = Response.objects.get(id=answer_id)
    target_user = request.user
    if target_user not in target_answer.voters.all():
        target_answer.voters.add(target_user)
        target_answer.votes -= 1
        target_answer.save()
        return HttpResponse('vote allowed')
    else:
        return HttpResponse('vote denied')

def get_response_photo(request, response_id):
    target_user = Response.objects.get(id=response_id).user
    response = get_object_or_404(Response, user=target_user, id=response_id)
    if not response.picture:
        raise Http404
    mimetype = guess_type(response.picture.name)[0]
    return HttpResponse(response.picture.read(), content_type=mimetype)

def get_post_photo(request, post_id):
    target_user = Post.objects.get(id=post_id).user
    comment = get_object_or_404(Post, user=target_user, id=post_id)
    if not comment.picture:
        raise Http404

    mimetype = guess_type(comment.picture.name)[0]
    return HttpResponse(comment.picture.read(), content_type=mimetype)

def select_bounty(request, response_id): 
    response = get_object_or_404(Response,id=response_id)

    self_user = request.user 
    response_owner = response.user

    target_question = response.question
    question_owner = target_question.user
    bounty = target_question.bounty


    if target_question.resolved:
        return HttpResponse('Best answer selected already')

    else: 
        if self_user != question_owner:
            return HttpResponse('Selection not allowed')
        else:
            if (self_user!= response_owner):
            # can't give bounty to self
            # check for overflow
                ownerInfo = response_owner.userinfo
                old_bounty = ownerInfo.reputation
                new_bounty = old_bounty + bounty
                if (new_bounty > old_bounty):
                    ownerInfo.reputation = new_bounty
                    ownerInfo.save()

                target_question.resolved = True
                response.best_answer = True
                target_question.save()
                response.save()
                return HttpResponse('Chosen best answer')
            else:
                return HttpResponse('Cannot select own answer')

def get_mlbplayer(request, player_id):
    target_player = get_object_or_404(Player, player_id=player_id)
    return HttpResponse(target_player.first_name + ' ' + target_player.last_name + ', ' + target_player.position)

@login_required
def doLogout(request):
    logout(request)
    return redirect(reverse('home'))

def confirmation(request, confirmKey, userid):
    context = {}
    message = 'Unable to confirm account. \
            Ensure that confirmation link is clicked directly from email.'
    if (not confirmKey):
        message = "ConfirmationKeyError: " + message
        context['message'] = message
        return render(request, 'gameTimeApp/confirm.html', context)
    if (not userid):
        message = "Userid error: " + message
        context['message'] = message
        return render(request, 'gameTimeApp/confirm.html', context)


    try:
        target_user = User.objects.get(id=userid) #unique userInfo id

    except User.DoesNotExist: 
        message = "Userid error: " + message
        context['message'] = message
        return render(request, 'gameTimeApp/confirm.html', context)

    
    if (confirmKey != str(target_user.userinfo.confirmKey)):
        message = "Non-matching ConfirmationKey: " + message
        context['message'] = message
        return render(request, 'gameTimeApp/confirm.html', context)

    # at this point user has successfully activated account
    user = User.objects.get(id = userid)
    if user.is_active:
        message = "Account already active: You may proceed to GameTime"
        context['message'] = message
        return render(request, 'gameTimeApp/confirm.html', context)

    user.is_active = True
    user.save()
    context['message'] = "Your account is now active. Enjoy the game!"
    context['register_form'] = RegisterForm()
    # Login(request, new_user)
    # return redirect('/home.html')
    return render(request, 'gameTimeApp/confirm.html',context)

def manage(request):
    context = {}
    if not request.user.is_authenticated():
        messages.info(request, 'Please log in to manage your account.');
        context['register_form'] = RegisterForm()
        return render(request, 'gameTimeApp/index.html', context)
    else:
        context['reply_form'] = ResponseForm()
        context['blog_form'] = PostForm()
        context['question_form'] = QuestionForm()
        context['answer_form'] = ResponseForm()
        context['register_form'] = RegisterForm()
        return render(request, 'gameTimeApp/manage.html', context)

def history_games(request,league):
    context={}
    context['league'] = league
    context['register_form'] = RegisterForm()
    context['history_form'] = HistoryForm(league=league.lower())
    # return render(request, 'gameTimeApp/history-games.html', context)
    # print request.POST
    # form = HistoryForm(request.POST)
    # form = HistoryForm({'startDate': '12/12/2014', 'endDate':'12/12/2014', 'teams': ['']})
    # form = HistoryForm(league)
    # print form.is_bound

    # form2 = QuestionForm({})
    # print form2.is_bound

    # note: no data validation because there is no room for user input: rather all the fields are 
    # pre-selected
    if request.method=='POST':
        startDateTemp = request.POST['startDate']
        endDateTemp = request.POST['endDate']
        teams = request.POST.getlist('teams')
        # print request.POST['teams']
        # print "startDate error: " + form.errors['startDate']
        # print "endDate error: " + form.errors['endDate']
        # print "teams error: " + form.errors['teams']
        if ((len(startDateTemp)==0) or (len(endDateTemp)==0)):
            context['errorMsg'] = "A start date and end date is required"
            return render(request, 'gameTimeApp/history-games.html', context)
        startMonth = int(startDateTemp[0:2])
        startDay = int(startDateTemp[3:5])
        startYear = int(startDateTemp[6:10])
        
        endMonth = int(endDateTemp[0:2])
        endDay = int(endDateTemp[3:5])
        endYear = int(endDateTemp[6:10])

        startDate = datetime.date(startYear, startMonth, startDay)
        endDate = datetime.date(endYear, endMonth, endDay)

        startDateTime = datetime.datetime.combine(startDate, datetime.time.min)
        endDateTime = datetime.datetime.combine(endDate, datetime.time.max)
        print startDateTime
        print endDateTime
        if (len(teams) == 0):
            teamsFollowing = Team.objects.filter(league=league)
            # games_to_get = Game.objects.filter(home_team__in=teamsFollowing, start_time__range=[startDate,endDate])
            # games_to_get_two = Game.objects.filter(away_team__in=teamsFollowing, start_time__range=[startDate,endDate])
            games_to_get = Game.objects.filter(home_team__in=teamsFollowing, start_time__range=(startDateTime,endDateTime))
            games_to_get_two = Game.objects.filter(away_team__in=teamsFollowing, start_time__range=(startDateTime,endDateTime))
            games_to_get = games_to_get | games_to_get_two
            context['games'] = games_to_get
        else: 
            teamsFollowing = Team.objects.filter(league=league, pk__in=teams)
            # games_to_get = Game.objects.filter(home_team__in=teamsFollowing, start_time__range=[startDate,endDate])
            # games_to_get_two = Game.objects.filter(away_team__in=teamsFollowing, start_time__range=[startDate,endDate])
            games_to_get = Game.objects.filter(home_team__in=teamsFollowing, start_time__range=(startDateTime,endDateTime))
            games_to_get_two = Game.objects.filter(away_team__in=teamsFollowing, start_time__range=(startDateTime,endDateTime))
            games_to_get = games_to_get | games_to_get_two
            context['games'] = games_to_get

    return render(request, 'gameTimeApp/history-games.html', context)

def test(request):
    return render(request, 'gameTimeApp/test.html')

def refreshPosts(request, game_id): 
    context = {}
    game = Game.objects.get(game_id=game_id)
    posts = game.post_set.all()
    context['blog_posts'] = posts
    context['reply_form'] = ResponseForm()
    context['blog_form'] = PostForm()
    context['question_form'] = QuestionForm()
    context['answer_form'] = ResponseForm()
    context['register_form'] = RegisterForm()
    
    return render(request, 'gameTimeApp/post-refresh.html',context)

