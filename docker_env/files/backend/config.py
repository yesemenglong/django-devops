import os
from application.settings import BASE_DIR
# BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# ================================================= #
# ************** mysql数据库 配置  ************** #
# ================================================= #
# 数据库地址
DATABASE_ENGINE = "django.db.backends.mysql"
# 数据库地址
DATABASE_HOST = "172.19.19.30"
# 数据库端口
DATABASE_PORT = 3306
# 数据库用户名
DATABASE_USER = "root"
# 数据库密码
DATABASE_PASSWORD = "123456"
# 数据库名
DATABASE_NAME = "test"
#数据库编码
DATABASE_CHARSET = "utf8mb4"
# 数据库长连接时间（默认为0，单位秒）即每次请求都重新连接,debug模式下该值应该写为0 ，mysql默认长连接超时时间为8小时
DATABASE_CONN_MAX_AGE = 0 #推荐120（2分钟），使用 None 则是无限的持久连接（不推荐）。

# ================================================= #
# ************** 服务器基本 配置  ************** #
# ================================================= #
REDIS_PASSWORD = '123456'
REDIS_HOST = '172.19.19.20'
REDIS_PORT = '6379'
REDIS_URL = f'redis://:{REDIS_PASSWORD or ""}@{REDIS_HOST}:{REDIS_PORT}'

# ================================================= #
# ************** 服务器基本 配置  ************** #
# ================================================= #

IS_DEMO = False #是否演示模式（演示模式只能查看无法保存、编辑、删除、新增）
IS_SINGLE_TOKEN = False #是否只允许单用户单一地点登录(只有一个人在线上)(默认多地点登录),只针对后台用户生效
ALLOW_FRONTEND = True#是否关闭前端API访问
FRONTEND_API_LIST = ['/api/app/','/api/xcx/','/api/h5/']#微服务前端接口前缀
DOMAIN_HOST = "http://127.0.0.1:8000"
EXEC_LOG_PATH =  os.path.join(BASE_DIR, 'logs','lybbnexec.log')
TEMP_EXEC_PATH =  os.path.join(BASE_DIR, 'logs')