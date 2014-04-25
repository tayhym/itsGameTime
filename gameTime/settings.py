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
# https://docs.djangoproject.com/en/1.6/ref/settings/#databases


# (commented out 25/4/14) - heroku does settings
# DATABASES = {                 
#     'default': {
#         'ENGINE': 'django.db.backends.postgresql_psycopg2',
#         'NAME': 'itsgametimedb',
#         'USER': 'xiaohua',
#         'PASSWORD': 'onefish',
#         'HOST': 'localhost',
#         "PORT": "5432",
#     }
# }
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

PROJECT_ROOT = os.path.realpath(os.path.dirname(__file__)) + '/'
MEDIA_ROOT = PROJECT_ROOT + 'media/'
MEDIA_URL = '/media/'


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.6/howto/static-files/

STATIC_URL = '/static/'
STATIC_ROOT = PROJECT_ROOT + 'static'

# future static file directories can be added here too
STATICFILES_DIR = (
    'http://www.google.com',
    # os.path.join(BASE_DIR, 'static'),
)


# Parse database configuration from $DATABASE_URL
# import dj_database_url

# DATABASES = {
#   'default': {
#     'ENGINE': 'django.db.backends.postgresql_psycopg2',
#     'NAME': 'df4u4l7pc675ad',
#     'HOST': 'ec2-54-221-243-6.compute-1.amazonaws.com',
#     'PORT': 5432,
#     'USER': 'lsayyyoufybdsq',
#     'PASSWORD': 'nVoXla4N4g6ks9c4H9HpbQZEZl'
#   }
# }
# # DATABASES['default'] =  dj_database_url.config()


# # Honor the 'X-Forwarded-Proto' header for request.is_secure()
# SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')

# # Allow all host headers
# ALLOWED_HOSTS = ['*']


# # Static asset configuration
# import os
# PROJECT_PATH = os.path.dirname(os.path.abspath(__file__))
# STATIC_ROOT = 'staticfiles'
# STATIC_URL = '/static/'

# STATICFILES_DIRS = (
#     os.path.join(PROJECT_PATH, 'static'),
# )

# easy maps environment variable
EASY_MAPS_CENTER = (-41.3,32)


# code added: 25/4/14
# # Allow all host hosts/domain names for this site
ALLOWED_HOSTS = ['*']

# Parse database configuration from $DATABASE_URL
import dj_database_url

DATABASES = { 'default' : dj_database_url.config()}

# Honor the 'X-Forwarded-Proto' header for request.is_secure()
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')

# try to load local_settings.py if it exists
try: 
    from local_settings import *
except Exception as e:
    print e
    pass

print DEBUG





