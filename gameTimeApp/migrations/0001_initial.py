# -*- coding: utf-8 -*-
from south.utils import datetime_utils as datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Adding model 'Venue'
        db.create_table(u'gameTimeApp_venue', (
            ('venue_id', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=50)),
            ('capacity', self.gf('django.db.models.fields.IntegerField')(null=True, blank=True)),
            ('address', self.gf('django.db.models.fields.CharField')(max_length=200)),
        ))
        db.send_create_signal(u'gameTimeApp', ['Venue'])

        # Adding model 'Team'
        db.create_table(u'gameTimeApp_team', (
            ('team_id', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('whole_name', self.gf('django.db.models.fields.CharField')(max_length=36)),
            ('market', self.gf('django.db.models.fields.CharField')(max_length=36, null=True, blank=True)),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=36, null=True, blank=True)),
            ('league', self.gf('django.db.models.fields.CharField')(max_length=20)),
            ('venue', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['gameTimeApp.Venue'])),
            ('alias', self.gf('django.db.models.fields.CharField')(max_length=3, null=True, blank=True)),
        ))
        db.send_create_signal(u'gameTimeApp', ['Team'])

        # Adding model 'Game'
        db.create_table(u'gameTimeApp_game', (
            ('game_id', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('venue', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['gameTimeApp.Venue'])),
            ('league', self.gf('django.db.models.fields.CharField')(max_length=20)),
            ('start_time', self.gf('django.db.models.fields.DateTimeField')()),
            ('home_team', self.gf('django.db.models.fields.related.ForeignKey')(related_name='home_team', to=orm['gameTimeApp.Team'])),
            ('away_team', self.gf('django.db.models.fields.related.ForeignKey')(related_name='away_team', to=orm['gameTimeApp.Team'])),
        ))
        db.send_create_signal(u'gameTimeApp', ['Game'])

        # Adding model 'Player'
        db.create_table(u'gameTimeApp_player', (
            ('player_id', self.gf('django.db.models.fields.CharField')(max_length=36, primary_key=True)),
            ('team', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['gameTimeApp.Team'])),
            ('position', self.gf('django.db.models.fields.CharField')(max_length=10)),
            ('jersey', self.gf('django.db.models.fields.CharField')(max_length=3, null=True, blank=True)),
            ('first_name', self.gf('django.db.models.fields.CharField')(max_length=50)),
            ('last_name', self.gf('django.db.models.fields.CharField')(max_length=50)),
            ('weight', self.gf('django.db.models.fields.CharField')(max_length=5, null=True, blank=True)),
            ('height', self.gf('django.db.models.fields.CharField')(max_length=1, null=True, blank=True)),
            ('birth_date', self.gf('django.db.models.fields.DateField')(null=True, blank=True)),
            ('birth_city', self.gf('django.db.models.fields.CharField')(max_length=30, null=True, blank=True)),
            ('birth_state', self.gf('django.db.models.fields.CharField')(max_length=2, null=True, blank=True)),
            ('birth_country', self.gf('django.db.models.fields.CharField')(max_length=30, null=True, blank=True)),
            ('college', self.gf('django.db.models.fields.CharField')(max_length=50, null=True, blank=True)),
        ))
        db.send_create_signal(u'gameTimeApp', ['Player'])

        # Adding model 'UserInfo'
        db.create_table(u'gameTimeApp_userinfo', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('confirmKey', self.gf('django.db.models.fields.CharField')(max_length=100)),
            ('user', self.gf('django.db.models.fields.related.OneToOneField')(to=orm['auth.User'], unique=True)),
            ('reputation', self.gf('django.db.models.fields.IntegerField')()),
        ))
        db.send_create_signal(u'gameTimeApp', ['UserInfo'])

        # Adding M2M table for field gamesFollowing on 'UserInfo'
        m2m_table_name = db.shorten_name(u'gameTimeApp_userinfo_gamesFollowing')
        db.create_table(m2m_table_name, (
            ('id', models.AutoField(verbose_name='ID', primary_key=True, auto_created=True)),
            ('userinfo', models.ForeignKey(orm[u'gameTimeApp.userinfo'], null=False)),
            ('game', models.ForeignKey(orm[u'gameTimeApp.game'], null=False))
        ))
        db.create_unique(m2m_table_name, ['userinfo_id', 'game_id'])

        # Adding model 'Post'
        db.create_table(u'gameTimeApp_post', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('text', self.gf('django.db.models.fields.CharField')(max_length=500)),
            ('user', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['auth.User'])),
            ('date', self.gf('django.db.models.fields.DateTimeField')(auto_now_add=True, null=True, blank=True)),
            ('picture', self.gf('django.db.models.fields.files.ImageField')(max_length=100, blank=True)),
            ('game', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['gameTimeApp.Game'])),
        ))
        db.send_create_signal(u'gameTimeApp', ['Post'])

        # Adding M2M table for field likers on 'Post'
        m2m_table_name = db.shorten_name(u'gameTimeApp_post_likers')
        db.create_table(m2m_table_name, (
            ('id', models.AutoField(verbose_name='ID', primary_key=True, auto_created=True)),
            ('post', models.ForeignKey(orm[u'gameTimeApp.post'], null=False)),
            ('user', models.ForeignKey(orm[u'auth.user'], null=False))
        ))
        db.create_unique(m2m_table_name, ['post_id', 'user_id'])

        # Adding model 'Question'
        db.create_table(u'gameTimeApp_question', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('text', self.gf('django.db.models.fields.CharField')(max_length=500)),
            ('user', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['auth.User'])),
            ('resolved', self.gf('django.db.models.fields.BooleanField')()),
            ('bounty', self.gf('django.db.models.fields.IntegerField')()),
            ('date', self.gf('django.db.models.fields.DateTimeField')(auto_now_add=True, null=True, blank=True)),
            ('game', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['gameTimeApp.Game'])),
        ))
        db.send_create_signal(u'gameTimeApp', ['Question'])

        # Adding model 'Response'
        db.create_table(u'gameTimeApp_response', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('text', self.gf('django.db.models.fields.CharField')(max_length=500)),
            ('user', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['auth.User'])),
            ('date', self.gf('django.db.models.fields.DateTimeField')(auto_now_add=True, null=True, blank=True)),
            ('post', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['gameTimeApp.Post'], null=True, blank=True)),
            ('question', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['gameTimeApp.Question'], null=True, blank=True)),
            ('best_answer', self.gf('django.db.models.fields.NullBooleanField')(null=True, blank=True)),
            ('picture', self.gf('django.db.models.fields.files.ImageField')(max_length=100, blank=True)),
            ('votes', self.gf('django.db.models.fields.IntegerField')(null=True, blank=True)),
        ))
        db.send_create_signal(u'gameTimeApp', ['Response'])

        # Adding M2M table for field voters on 'Response'
        m2m_table_name = db.shorten_name(u'gameTimeApp_response_voters')
        db.create_table(m2m_table_name, (
            ('id', models.AutoField(verbose_name='ID', primary_key=True, auto_created=True)),
            ('response', models.ForeignKey(orm[u'gameTimeApp.response'], null=False)),
            ('user', models.ForeignKey(orm[u'auth.user'], null=False))
        ))
        db.create_unique(m2m_table_name, ['response_id', 'user_id'])


    def backwards(self, orm):
        # Deleting model 'Venue'
        db.delete_table(u'gameTimeApp_venue')

        # Deleting model 'Team'
        db.delete_table(u'gameTimeApp_team')

        # Deleting model 'Game'
        db.delete_table(u'gameTimeApp_game')

        # Deleting model 'Player'
        db.delete_table(u'gameTimeApp_player')

        # Deleting model 'UserInfo'
        db.delete_table(u'gameTimeApp_userinfo')

        # Removing M2M table for field gamesFollowing on 'UserInfo'
        db.delete_table(db.shorten_name(u'gameTimeApp_userinfo_gamesFollowing'))

        # Deleting model 'Post'
        db.delete_table(u'gameTimeApp_post')

        # Removing M2M table for field likers on 'Post'
        db.delete_table(db.shorten_name(u'gameTimeApp_post_likers'))

        # Deleting model 'Question'
        db.delete_table(u'gameTimeApp_question')

        # Deleting model 'Response'
        db.delete_table(u'gameTimeApp_response')

        # Removing M2M table for field voters on 'Response'
        db.delete_table(db.shorten_name(u'gameTimeApp_response_voters'))


    models = {
        u'auth.group': {
            'Meta': {'object_name': 'Group'},
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '80'}),
            'permissions': ('django.db.models.fields.related.ManyToManyField', [], {'to': u"orm['auth.Permission']", 'symmetrical': 'False', 'blank': 'True'})
        },
        u'auth.permission': {
            'Meta': {'ordering': "(u'content_type__app_label', u'content_type__model', u'codename')", 'unique_together': "((u'content_type', u'codename'),)", 'object_name': 'Permission'},
            'codename': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'content_type': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['contenttypes.ContentType']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'})
        },
        u'auth.user': {
            'Meta': {'object_name': 'User'},
            'date_joined': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime.now'}),
            'email': ('django.db.models.fields.EmailField', [], {'max_length': '75', 'blank': 'True'}),
            'first_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'groups': ('django.db.models.fields.related.ManyToManyField', [], {'symmetrical': 'False', 'related_name': "u'user_set'", 'blank': 'True', 'to': u"orm['auth.Group']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'is_active': ('django.db.models.fields.BooleanField', [], {'default': 'True'}),
            'is_staff': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'is_superuser': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'last_login': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime.now'}),
            'last_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'password': ('django.db.models.fields.CharField', [], {'max_length': '128'}),
            'user_permissions': ('django.db.models.fields.related.ManyToManyField', [], {'symmetrical': 'False', 'related_name': "u'user_set'", 'blank': 'True', 'to': u"orm['auth.Permission']"}),
            'username': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '30'})
        },
        u'contenttypes.contenttype': {
            'Meta': {'ordering': "('name',)", 'unique_together': "(('app_label', 'model'),)", 'object_name': 'ContentType', 'db_table': "'django_content_type'"},
            'app_label': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'model': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'})
        },
        u'gameTimeApp.game': {
            'Meta': {'object_name': 'Game'},
            'away_team': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'away_team'", 'to': u"orm['gameTimeApp.Team']"}),
            'game_id': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'}),
            'home_team': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'home_team'", 'to': u"orm['gameTimeApp.Team']"}),
            'league': ('django.db.models.fields.CharField', [], {'max_length': '20'}),
            'start_time': ('django.db.models.fields.DateTimeField', [], {}),
            'venue': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['gameTimeApp.Venue']"})
        },
        u'gameTimeApp.player': {
            'Meta': {'object_name': 'Player'},
            'birth_city': ('django.db.models.fields.CharField', [], {'max_length': '30', 'null': 'True', 'blank': 'True'}),
            'birth_country': ('django.db.models.fields.CharField', [], {'max_length': '30', 'null': 'True', 'blank': 'True'}),
            'birth_date': ('django.db.models.fields.DateField', [], {'null': 'True', 'blank': 'True'}),
            'birth_state': ('django.db.models.fields.CharField', [], {'max_length': '2', 'null': 'True', 'blank': 'True'}),
            'college': ('django.db.models.fields.CharField', [], {'max_length': '50', 'null': 'True', 'blank': 'True'}),
            'first_name': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
            'height': ('django.db.models.fields.CharField', [], {'max_length': '1', 'null': 'True', 'blank': 'True'}),
            'jersey': ('django.db.models.fields.CharField', [], {'max_length': '3', 'null': 'True', 'blank': 'True'}),
            'last_name': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
            'player_id': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'}),
            'position': ('django.db.models.fields.CharField', [], {'max_length': '10'}),
            'team': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['gameTimeApp.Team']"}),
            'weight': ('django.db.models.fields.CharField', [], {'max_length': '5', 'null': 'True', 'blank': 'True'})
        },
        u'gameTimeApp.post': {
            'Meta': {'object_name': 'Post'},
            'date': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'null': 'True', 'blank': 'True'}),
            'game': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['gameTimeApp.Game']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'likers': ('django.db.models.fields.related.ManyToManyField', [], {'related_name': "'like_posts'", 'symmetrical': 'False', 'to': u"orm['auth.User']"}),
            'picture': ('django.db.models.fields.files.ImageField', [], {'max_length': '100', 'blank': 'True'}),
            'text': ('django.db.models.fields.CharField', [], {'max_length': '500'}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['auth.User']"})
        },
        u'gameTimeApp.question': {
            'Meta': {'object_name': 'Question'},
            'bounty': ('django.db.models.fields.IntegerField', [], {}),
            'date': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'null': 'True', 'blank': 'True'}),
            'game': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['gameTimeApp.Game']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'resolved': ('django.db.models.fields.BooleanField', [], {}),
            'text': ('django.db.models.fields.CharField', [], {'max_length': '500'}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['auth.User']"})
        },
        u'gameTimeApp.response': {
            'Meta': {'object_name': 'Response'},
            'best_answer': ('django.db.models.fields.NullBooleanField', [], {'null': 'True', 'blank': 'True'}),
            'date': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'null': 'True', 'blank': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'picture': ('django.db.models.fields.files.ImageField', [], {'max_length': '100', 'blank': 'True'}),
            'post': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['gameTimeApp.Post']", 'null': 'True', 'blank': 'True'}),
            'question': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['gameTimeApp.Question']", 'null': 'True', 'blank': 'True'}),
            'text': ('django.db.models.fields.CharField', [], {'max_length': '500'}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['auth.User']"}),
            'voters': ('django.db.models.fields.related.ManyToManyField', [], {'related_name': "'voters'", 'symmetrical': 'False', 'to': u"orm['auth.User']"}),
            'votes': ('django.db.models.fields.IntegerField', [], {'null': 'True', 'blank': 'True'})
        },
        u'gameTimeApp.team': {
            'Meta': {'object_name': 'Team'},
            'alias': ('django.db.models.fields.CharField', [], {'max_length': '3', 'null': 'True', 'blank': 'True'}),
            'league': ('django.db.models.fields.CharField', [], {'max_length': '20'}),
            'market': ('django.db.models.fields.CharField', [], {'max_length': '36', 'null': 'True', 'blank': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '36', 'null': 'True', 'blank': 'True'}),
            'team_id': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'}),
            'venue': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['gameTimeApp.Venue']"}),
            'whole_name': ('django.db.models.fields.CharField', [], {'max_length': '36'})
        },
        u'gameTimeApp.userinfo': {
            'Meta': {'object_name': 'UserInfo'},
            'confirmKey': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'gamesFollowing': ('django.db.models.fields.related.ManyToManyField', [], {'to': u"orm['gameTimeApp.Game']", 'symmetrical': 'False'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'reputation': ('django.db.models.fields.IntegerField', [], {}),
            'user': ('django.db.models.fields.related.OneToOneField', [], {'to': u"orm['auth.User']", 'unique': 'True'})
        },
        u'gameTimeApp.venue': {
            'Meta': {'object_name': 'Venue'},
            'address': ('django.db.models.fields.CharField', [], {'max_length': '200'}),
            'capacity': ('django.db.models.fields.IntegerField', [], {'null': 'True', 'blank': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
            'venue_id': ('django.db.models.fields.CharField', [], {'max_length': '36', 'primary_key': 'True'})
        }
    }

    complete_apps = ['gameTimeApp']