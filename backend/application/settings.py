"""
Django settings for application project.

Generated by 'django-admin startproject' using Django 3.2.6.

For more information on this file, see
https://docs.djangoproject.com/en/3.2/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/3.2/ref/settings/
"""
import os
import sys
from pathlib import Path

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent

sys.path.insert(0, os.path.join(BASE_DIR, 'apps'))
sys.path.insert(0, os.path.join(BASE_DIR, 'extra_apps'))

# ================================================= #
# ******************** 动态配置 ******************** #
# ================================================= #

from config import *

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/3.2/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'django-insecure-%8)h%p^$eoqbcp1=o5z)3v^i(@d-8m-z+toc$)4zaz^_yd9ul4'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = ["*"]


# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    #other app
    'django_comment_migrate',
    'rest_framework',
    'django_filters',
    'corsheaders',#允许跨域
    'drf_yasg',#在线接口文档
    'captcha',#验证码
    #myown app
    'mysystem',
    #custom app
    'lymessages',
    'address',
    'oauth',
    'logins',
    'lyusers',
    'platformsettings',
    'mall',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'corsheaders.middleware.CorsMiddleware',#跨域中间件
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'utils.middleware.ApiLoggingMiddleware',#自定义日志中间件
]


ROOT_URLCONF = 'application.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'frontend')]#放置前端页面的地方
        ,
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'application.wsgi.application'


# Database
# https://docs.djangoproject.com/en/3.2/ref/settings/#databases
#sqlite3
# DATABASES = {
#     'default': {
#         'ENGINE': 'django.db.backends.sqlite3',
#         'NAME': BASE_DIR / 'db.sqlite3',
#     }
# }
#mysql
DATABASES = {
    'default': {
        'ENGINE': DATABASE_ENGINE,
        'NAME': DATABASE_NAME,
        'USER': DATABASE_USER,
        'PASSWORD': DATABASE_PASSWORD,
        'HOST': DATABASE_HOST,
        'PORT': DATABASE_PORT,
        'CONN_MAX_AGE':DATABASE_CONN_MAX_AGE,
        'OPTIONS': {
                    'charset':DATABASE_CHARSET,
                    'init_command': 'SET default_storage_engine=INNODB', #innodb才支持事务
                }
    }
}
AUTH_USER_MODEL = 'mysystem.Users'
USERNAME_FIELD = 'username'


# 配置redis缓存
CACHES = {
    'default': {
        'BACKEND': 'django_redis.cache.RedisCache',  # 缓存后端 Redis
        # 连接Redis数据库(服务器地址)
        # 一主带多从(可以配置多个Redis，写走第一台，读走其他的机器)
        'LOCATION': [
            'redis://localhost:6379/0',
        ],
        'KEY_PREFIX': 'lybbn',  # 项目名当做文件前缀
        'OPTIONS': {
            'CLIENT_CLASS': 'django_redis.client.DefaultClient',  # 连接选项(默认，不改)
            'CONNECTION_POOL_KWARGS': {
                'max_connections': 512,  # 连接池的连接(最大连接)
            },
        }
    },
    'session': { #缓存session
            'BACKEND': 'django_redis.cache.RedisCache',  # 缓存后端 Redis
            # 连接Redis数据库(服务器地址)
            # 一主带多从(可以配置多个Redis，写走第一台，读走其他的机器)
            'LOCATION': [
                'redis://localhost:6379/1',
            ],
            'OPTIONS': {
                'CLIENT_CLASS': 'django_redis.client.DefaultClient',  # 连接选项(默认，不改)
            }
        },
    'verify_codes': { #缓存短信验证码
            'BACKEND': 'django_redis.cache.RedisCache',  # 缓存后端 Redis
            # 连接Redis数据库(服务器地址)
            # 一主带多从(可以配置多个Redis，写走第一台，读走其他的机器)
            'LOCATION': [
                'redis://localhost:6379/2',
            ],
            'OPTIONS': {
                'CLIENT_CLASS': 'django_redis.client.DefaultClient',  # 连接选项(默认，不改)
            }
        },
    "carts": { #登陆过的用户购物车的存储
            "BACKEND": "django_redis.cache.RedisCache",
            'LOCATION': [
                'redis://localhost:6379/3',
            ],
            "OPTIONS": {
                "CLIENT_CLASS": "django_redis.client.DefaultClient",
                'CONNECTION_POOL_KWARGS': {'decode_responses': True}, # 添加这一行,防止取出的值带有b'' bytes
            },
    },
    "authapi": {  # 接口安全校验（验证接口重复第二次访问会拒绝）
            'BACKEND': 'django_redis.cache.RedisCache',  # 缓存后端 Redis
            # 连接Redis数据库(服务器地址)
            # 一主带多从(可以配置多个Redis，写走第一台，读走其他的机器)
            'LOCATION': [
                'redis://localhost:6379/4',
            ],
            'OPTIONS': {
                'CLIENT_CLASS': 'django_redis.client.DefaultClient',  # 连接选项(默认，不改)
            }
        },
    "singletoken": {  # jwt单用户登录（确保一个账户只有一个地点登录，后一个会顶掉前一个）
            'BACKEND': 'django_redis.cache.RedisCache',  # 缓存后端 Redis
            # 连接Redis数据库(服务器地址)
            # 一主带多从(可以配置多个Redis，写走第一台，读走其他的机器)
            'LOCATION': [
                'redis://localhost:6379/5',
            ],
            'OPTIONS': {
                'CLIENT_CLASS': 'django_redis.client.DefaultClient',  # 连接选项(默认，不改)
                'CONNECTION_POOL_KWARGS': {'decode_responses': True}, # 添加这一行,防止取出的值带有b'' bytes
            }
        },
}

REDIS_TIMEOUT = 7 * 24 * 60 * 60
CUBES_REDIS_TIMEOUT = 60 * 60
NEVER_REDIS_TIMEOUT = 365 * 24 * 60 * 60

# session使用的存储方式
SESSION_ENGINE = "django.contrib.sessions.backends.cache"
# 指明使用哪一个库保存session数据
SESSION_CACHE_ALIAS = "session"

# Password validation
# https://docs.djangoproject.com/en/3.2/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/3.2/topics/i18n/

LANGUAGE_CODE = 'zh-Hans'

TIME_ZONE = 'Asia/Shanghai'

USE_I18N = True

USE_L10N = True

USE_TZ = False#设置为中国时间


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/3.2/howto/static-files/

STATIC_URL = '/static/'
# 设置django的静态文件目录
# STATICFILES_DIRS = [
#     os.path.join(BASE_DIR, "static"),
# ]
FRONTEND_ROOT = os.path.join(BASE_DIR, "frontend")
STATICFILES_DIRS = [
    os.path.join(FRONTEND_ROOT,"static"),
    os.path.join(FRONTEND_ROOT,"download-app","static"),
]
# 收集静态文件，必须将 MEDIA_ROOT,STATICFILES_DIRS先注释
# python manage.py collectstatic
STATIC_ROOT=os.path.join(BASE_DIR,'static')

# 访问上传文件的url地址前缀
if not os.path.exists(os.path.join(BASE_DIR, 'media')):
    os.makedirs(os.path.join(BASE_DIR, 'media'))

MEDIA_URL = "/media/"
# 项目中存储上传文件的根目录
MEDIA_ROOT = os.path.join(BASE_DIR, "media")

# ================================================= #
# ******************* 跨域的配置 ******************* #
# ================================================= #
# 如果为True，则将不使用白名单，并且将接受所有来源。默认为False
#允许跨域
CORS_ORIGIN_ALLOW_ALL = True
# 允许cookie
CORS_ALLOW_CREDENTIALS = True  # 指明在跨域访问中，后端是否支持对cookie的操作
# ================================================= #
# ********************* 日志配置 ******************* #
# ================================================= #
# log 配置部分BEGIN #
SERVER_LOGS_FILE = os.path.join(BASE_DIR, 'logs', 'server.log')
ERROR_LOGS_FILE = os.path.join(BASE_DIR, 'logs', 'error.log')
if not os.path.exists(os.path.join(BASE_DIR, 'logs')):
    os.makedirs(os.path.join(BASE_DIR, 'logs'))

# 格式:[2020-04-22 23:33:01][micoservice.apps.ready():16] [INFO] 这是一条日志:
# 格式:[日期][模块.函数名称():行号] [级别] 信息
STANDARD_LOG_FORMAT = '[%(asctime)s][%(name)s.%(funcName)s():%(lineno)d] [%(levelname)s] %(message)s'
CONSOLE_LOG_FORMAT = '[%(asctime)s][%(name)s.%(funcName)s():%(lineno)d] [%(levelname)s] %(message)s'

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'standard': {
            'format': STANDARD_LOG_FORMAT
        },
        'console': {
            'format': CONSOLE_LOG_FORMAT,
            'datefmt': '%Y-%m-%d %H:%M:%S',
        },
        'file': {
            'format': CONSOLE_LOG_FORMAT,
            'datefmt': '%Y-%m-%d %H:%M:%S',
        },
    },
    'handlers': {
        'file': {
            'level': 'INFO',
            'class': 'logging.handlers.RotatingFileHandler',
            'filename': SERVER_LOGS_FILE,
            'maxBytes': 1024 * 1024 * 100,  # 100 MB
            'backupCount': 5,  # 最多备份5个
            'formatter': 'standard',
            'encoding': 'utf-8',
        },
        'error': {
            'level': 'ERROR',
            'class': 'logging.handlers.RotatingFileHandler',
            'filename': ERROR_LOGS_FILE,
            'maxBytes': 1024 * 1024 * 100,  # 100 MB
            'backupCount': 3,  # 最多备份3个
            'formatter': 'standard',
            'encoding': 'utf-8',
        },
        'console': {
            'level': 'INFO',
            'class': 'logging.StreamHandler',
            'formatter': 'console',
        }
    },
    'loggers': {
        # default日志
        '': {
            'handlers': ['console', 'error', 'file'],
            'level': 'INFO',
        },
        'django': {
            'handlers': ['console', 'error', 'file'],
            'level': 'INFO',
        },
        'scripts': {
            'handlers': ['console', 'error', 'file'],
            'level': 'INFO',
        },
        # 数据库相关日志
        'django.db.backends': {
            'handlers': [],
            'propagate': True,
            'level': 'INFO',
        },
    }
}
# ================================================= #
# *************** REST_FRAMEWORK配置 *************** #
# ================================================= #

REST_FRAMEWORK = {
    'DATETIME_FORMAT': "%Y-%m-%d %H:%M:%S",  # 日期时间格式配置
    'DATE_FORMAT': "%Y-%m-%d",
    'DEFAULT_FILTER_BACKENDS': (
        'django_filters.rest_framework.DjangoFilterBackend',
        'rest_framework.filters.SearchFilter',
        'rest_framework.filters.OrderingFilter',

    ),
    'DEFAULT_PAGINATION_CLASS': 'utils.pagination.CustomPagination',  # 自定义分页
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework_simplejwt.authentication.JWTAuthentication',
        # 'rest_framework_simplejwt.authentication.JWTTokenUserAuthentication',
        'rest_framework.authentication.SessionAuthentication',
    ),
    #限速设置
    # 'DEFAULT_THROTTLE_CLASSES': (
    #         'rest_framework.throttling.AnonRateThrottle',   #未登陆用户
    #         'rest_framework.throttling.UserRateThrottle'    #登陆用户
    # ),
    # 'DEFAULT_THROTTLE_RATES': {
    #     'anon': '30/minute',                   #未登录用户每分钟可以请求30次，还可以设置'100/day',天数
    #     'user': '60/minute'                    #已登录用户每分钟可以请求60次
    # },
    'EXCEPTION_HANDLER': 'utils.exception.CustomExceptionHandler',  # 自定义的异常处理
    # #线上部署正式环境，关闭web接口测试页面
            # 'DEFAULT_RENDERER_CLASSES':(
            #     'rest_framework.renderers.JSONRenderer',
            # ),
}
# ================================================= #
# ****************** simplejwt配置 ***************** #
# ================================================= #
from datetime import timedelta

SIMPLE_JWT = {
    # token有效时长
    'ACCESS_TOKEN_LIFETIME': timedelta(days=7),
    # token刷新后的有效时间
    'REFRESH_TOKEN_LIFETIME': timedelta(days=15),
    # 设置header字段Authorization的值得前缀： JWT accesstoken字符串
    'AUTH_HEADER_TYPES': ('JWT',),
    'ROTATE_REFRESH_TOKENS': True
}

# ====================================#
# ****************swagger************#
#====================================#
SWAGGER_SETTINGS = {
    # 基础样式
    'SECURITY_DEFINITIONS': {
        "basic":{#用户名密码cookie验证
            'type': 'basic'
            },
        'JWT': {#通过jwt验证
                'type': 'apiKey',
                'name': 'Authorization',
                'in': 'header'
            },
        'Query': {#通过query中auth变量验证
                'type': 'apiKey',
                'name': 'auth',
                'in': 'query'
            }
    },
    # 如果需要登录才能够查看接口文档, 登录的链接使用restframework自带的.
    'LOGIN_URL': 'rest_framework:login',
    'LOGOUT_URL': 'rest_framework:logout',
    # 'DOC_EXPANSION': None,
    # 'SHOW_REQUEST_HEADERS':True,
    # 'USE_SESSION_AUTH': True,
    # 'DOC_EXPANSION': 'list',
    # 接口文档中方法列表以首字母升序排列
    'APIS_SORTER': 'alpha',
    # 如果支持json提交, 则接口文档中包含json输入框
    'JSON_EDITOR': True,
    # 方法列表字母排序
    'OPERATIONS_SORTER': 'alpha',
    'VALIDATOR_URL': None,
    'AUTO_SCHEMA_TYPE': 1, # 分组根据url层级分，0、1 或 2 层
    'DEFAULT_AUTO_SCHEMA_CLASS': 'utils.swagger.CustomSwaggerAutoSchema',
    # 'DEFAULT_PARSER_CLASSES': (
    #           'rest_framework.parsers.FormParser',
    #           'rest_framework.parsers.MultiPartParser',
    #           'rest_framework.parsers.JSONParser',
    #    ),
}
# ================================================= #
# **************** 验证码配置  ******************* #
# ================================================= #
CAPTCHA_STATE = True
CAPTCHA_IMAGE_SIZE = (160, 60)  # 设置 captcha 图片大小
CAPTCHA_LENGTH = 4  # 字符个数
CAPTCHA_TIMEOUT = 1  # 超时(minutes)
CAPTCHA_OUTPUT_FORMAT = '%(image)s %(text_field)s %(hidden_field)s '
CAPTCHA_FONT_SIZE = 40  # 字体大小
CAPTCHA_FOREGROUND_COLOR = '#0033FF'  # 前景色
CAPTCHA_BACKGROUND_COLOR = '#F5F7F4'  # 背景色
CAPTCHA_NOISE_FUNCTIONS = (
    'captcha.helpers.noise_arcs', # 线
    'captcha.helpers.noise_dots', # 点
)
# CAPTCHA_CHALLENGE_FUNCT = 'captcha.helpers.random_char_challenge' #字母验证码
CAPTCHA_CHALLENGE_FUNCT = 'captcha.helpers.math_challenge' # 加减乘除验证码
# ================================================= #
# ******************** celery配置 ******************** #
# ================================================= #
DJANGO_CELERY_BEAT_TZ_AWARE = False
CELERY_TIMEZONE = 'Asia/Shanghai'  # celery 时区问题
CELERY_BROKER_URL = 'redis://127.0.0.1:6379/10' # Broker配置，使用Redis作为消息中间件
CELERY_RESULT_BACKEND = 'redis://127.0.0.1:6379/11' # 把任务结果存在了Redis
CELERY_FORCE_EXECV = True    # 非常重要,有些情况下可以防止死锁
CELERY_RESULT_SERIALIZER = 'json' # 结果序列化方案
CELERY_TASK_RESULT_EXPIRES = 60 * 60 * 24 #任务过期时间
#CELERY_CONCURRENCY = 1 #并发worker数（worker个数）
#CELERY_MAX_TASKS_PER_CHILD = 1#每个worker最多执行任务数（每个worker最多执行完1个任务就会被销毁，可防止内存泄露）
# 指定导入的任务模块，可以指定多个
#CELERY_IMPORTS = (
#    'other_dir.tasks',
#)
# ================================================= #
# ******************** 其他配置 ******************** #
# ================================================= #
# DEFAULT_AUTO_FIELD = 'django.db.models.AutoField'
API_LOG_ENABLE = True#全局控制日志记录
API_LOG_METHODS = ['POST', 'UPDATE', 'DELETE', 'PUT']  # ['POST', 'DELETE']
#日志记录显示的请求模块中文名映射
API_MODEL_MAP = {
    "/token/": "登录模块",
    "/api/token/": "登录模块",
    "/api/super/operate/":"前端API关闭开启",
}
# 表前缀
TABLE_PREFIX = "lyadmin_"

# Default primary key field type
# https://docs.djangoproject.com/en/3.2/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

