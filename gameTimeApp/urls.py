from django.conf.urls import patterns, include, url
from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from gameTimeApp import views
admin.autodiscover()

urlpatterns = patterns('',
	url(r'^$', views.home, name= "home"),
	# url(r'^login$', 'django.contrib.auth.views.login', {'template_name':'gameTimeApp/login.html'}),
	url(r'^about$', views.about, name="about"),
	url(r'^find-game/(?P<league>\w+)/(?P<date>\d{8})$',views.find_game, name="find-game"),
	url(r'^get-boxscore/(?P<league>\w+)/(?P<game_id>[0-90-z\-]{36})$', views.get_boxscore, name="boxscore"),
	url(r'^get-stats/(?P<league>\w+)/(?P<game_id>[0-90-z\-]{36})$', views.get_stats, name="get-stats"),
	# url(r'^register$', 'gameTimeApp.views.register', name="register"),
	url(r'^populate/(?P<league>\w+)$', views.populate_data, name='populate'),
	url(r'^register$', 'gameTimeApp.views.register', name="register"),
	url(r'^game-page/(?P<game_id>[0-90-z\-]{36})/(?P<activeTab>\S+)$', views.get_game_page, name="game-page"),
	url(r'^confirmation/confirmKey=(?P<confirmKey>\w+)/userid=(?P<userid>\w+)', views.confirmation, name="confirmation"),
	# url(r'^game-page/(?P<game_id>[0-90-z\-]{36})$', views.get_game_page, name="game-page"),
 
	# url(r'^getQuestions/(?P<gameId>\S+)$', views.getQuestions, name="getQuestions"),
	url(r'^post-question/(?P<game_id>\S+)$', views.post_question, name="post-question"),
	url(r'^add-answer/(?P<source>\w+)/(?P<question_id>\d+)$', views.add_answer, name="add-answer"),
	url(r'^add-reply/(?P<source>\w+)/(?P<comment_id>\d+)$', views.add_reply, name="add-reply"),
	url(r'^post-blog/(?P<game_id>[0-90-z\-]{36})$', views.post_blog, name="post-blog"),
	url(r'^like/(?P<post_id>\d+)/(?P<flag>0|1)$', views.like),
	url(r'^up-vote/(?P<answer_id>\d+)$', views.up_vote),
	url(r'^dn-vote/(?P<answer_id>\d+)$', views.dn_vote),
	url(r'^get-mlbplayer/(?P<player_id>[0-90-z\-]{36})$', views.get_mlbplayer),
	url(r'^comment-photo/(?P<post_id>\d+)$',views.get_post_photo, name='comment-photo'),
	url(r'^response-photo/(?P<response_id>\d+)$',views.get_response_photo, name='response-photo'),
	
	url(r'^selectBounty/(?P<response_id>\d+)$', views.select_bounty, name="selectBounty"),
	url(r'^historyGames/(?P<league>\w+)$', views.history_games, name="historyGames"),
	url(r'^test$', views.test, name="test"),
	url(r'^refreshPosts/(?P<game_id>[0-90-z\-]{36})$',views.refreshPosts, name="refreshPosts"),

	url(r'^login$', views.login_ajax, name='login'),
	url(r'^logout$', views.doLogout, name='logout'),
	url(r'^register$', views.register, name='register'),

	url(r'^manage$', views.manage, name='manage'),
	url(r'^stop-following/(?P<game_id>[0-90-z\-]{36})$', views.stop_following, name='stop-following'),
	
	url(r'^admin/', include(admin.site.urls)),
) + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT) 
