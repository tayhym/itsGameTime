"""
Django settings for gameTime project.

For more information on this file, see
https://docs.djangoproject.com/en/1.6/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/1.6/ref/settings/
"""

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
import os
BASE_DIR = os.path.dirname(os.path.dirname(__file__))


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/1.6/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'jcujou=gjj1&g%46#x88t&_6@@k8vy&75sfqi3)6!s(azfl_k)'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = False       # changed 25/4/14

TEMPLATE_DEBUG = True

ALLOWED_HOSTS = []


# Application definition

INSTALLED_APPS = (
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'gameTimeApp',
    # 'south',
    'gunicorn',
    'storages',
)

MIDDLEWARE_CLASSES = (
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
)

ROOT_URLCONF = 'gameTime.urls'

WSGI_APPLICATION = 'gameTime.wsgi.application'


# Database

# instead,only need the engine name, as heroku takes care of the rest
DATABASES = {
    "default": {
       "ENGINE": "django.db.backends.postgresql_psycopg2",
    }
}

# Internationalization
# https://docs.djangoproject.com/en/1.6/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'US/Eastern'

USE_I18N = True

USE_L10N = True

USE_TZ = True

# used for @login_required page
LOGIN_URL = "/gameTime/"
# redirect to after successful login
LOGIN_REDIRECT_URL = "/gameTime/"




# using cmu server to communicate to users via email
EMAIL_HOST = 'smtp.srv.cs.cmu.edu'
EMAIL_USE_TLS = False


# easy maps environment variable
EASY_MAPS_CENTER = (-41.3,32)


# code added: 25/4/14
# # Allow all host hosts/domain names for this site
ALLOWED_HOSTS = ['*']

# Parse database configuration from $DATABASE_URL
import dj_database_url

# DATABASES = { 'default' : dj_database_url.config()}  ### uncomment after debugging
DATABASES['default'] =  dj_database_url.config(default='postgres://cjumxevfhbfvjh:OXc1dwH2S-CH-YgSeB-NcaDqeD@ec2-23-23-80-55.compute-1.amazonaws.com:5432/derb509fpc8ebu')

# Honor the 'X-Forwarded-Proto' header for request.is_secure()
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')

# try to load local_settings.py if it exists
# try: 
#     from local_settings import *
# except Exception as e:
#     print e
#     pass

print DEBUG

################### static files ############################

SITE_ROOT = os.path.dirname(os.path.realpath(__file__))
MEDIA_ROOT = ''
MEDIA_URL = ''
STATIC_ROOT = ''
STATIC_URL = 'https://s3.amazonaws.com/gametimebucket/'
ADMIN_MEDIA_PREFIX = '/static/admin/'

TEMPLATE_CONTEXT_PROCESSORS = (
    'django.contrib.messages.context_processors.messages',
    'django.contrib.auth.context_processors.auth',
    'django.core.context_processors.static',
)

# Additional locations of static files
STATICFILES_DIRS = (
        os.path.join(SITE_ROOT, 'static'),
)

# List of finder classes that know how to find static files in
# various locations.
STATICFILES_FINDERS = (
    'django.contrib.staticfiles.finders.FileSystemFinder',
    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
#    'django.contrib.staticfiles.finders.DefaultStorageFinder',
)

SECRET_KEY = 'NK0KGtsF8FFlJbopDe2IU9Cjxxs1ZEXjQ6hoxu1z'

TEMPLATE_LOADERS = (
    'django.template.loaders.filesystem.Loader',
    'django.template.loaders.app_directories.Loader',
#     'django.template.loaders.eggs.Loader',
)

TEMPLATE_DIRS = (
    # Put strings here, like "/home/html/django_templates" or "C:/www/django/templates".
    # Always use forward slashes, even on Windows.
    # Don't forget to use absolute paths, not relative paths.
    os.path.join(SITE_ROOT, 'templates')
    
)

STATICFILES_STORAGE = 'storages.backends.s3boto.S3BotoStorage'

AWS_ACCESS_KEY_ID = 'AKIAJOULJWFIJFJ4533A'
AWS_SECRET_ACCESS_KEY = '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'
AWS_STORAGE_BUCKET_NAME = 'gametimebucket'

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'handlers': {
        'mail_admins': {
            'level': 'ERROR',
            'class': 'django.utils.log.AdminEmailHandler'
        }
    },
    'loggers': {
        'django.request': {
            'handlers': ['mail_admins'],
            'level': 'ERROR',
            'propagate': True,
        },
    }
}

