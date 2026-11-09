# django-devops · 游戏服运维发布平台

基于 [django-vue-lyadmin](https://gitee.com/lybbn/django-vue-lyadmin) 3.2.8 二次开发的运维管理平台，通过 SaltStack 管理游戏区服：主机与证书管控、开服与批量部署、合服与迁移、WebSSH 终端、实时日志、系统监控与计划任务。

> **上线前必读**：本仓库是归档快照，包含明文口令、硬编码 `SECRET_KEY`、默认账号，且部分运维接口默认匿名可访问。**禁止直接暴露公网**，请先完成文末「安全加固清单」。

---

## 功能地图

| 分组 | 模块 | 说明 |
| --- | --- | --- |
| 运维定制 | `apps/salt_dev` | minion 列表、SaltKey 证书审批、命令采集与执行（salt-api） |
| | `apps/zones` | 区服列表、创区、批量部署、合服、移区、版本管理（读写 pillar / server_list） |
| | `apps/tailf` | WebSocket 推送批量部署日志 |
| | `apps/dashboard` | minion 状态 / 证书 / 本机 CPU、内存、磁盘图表 |
| | `apps/lywebsocket` | paramiko + xterm 的 WebSSH 终端 |
| 平台能力 | `mysystem` | 用户 / 部门 / 角色 / 菜单 / 按钮 / 字典 / 操作日志（RBAC + 部门数据域） |
| | `apps/lycrontab` | django-celery-beat 计划任务 |
| | `apps/lymonitor` | 本机系统指标采集 |
| | `apps/platformsettings` | 系统配置与图片上传 |
| 停用 / 示例 | `apps/logins`、`apps/lymessages` | 已在 settings 中注释停用 |
| | `views/mallManage` 等 | 上游框架示例页面，与本业务无关 |

## 技术栈

| 层 | 选型 |
| --- | --- |
| 后端 | Python ≥3.9、Django 4.0.8、DRF 3.14、SimpleJWT 5.2.1、Channels 3 + Daphne 3（WebSocket）、Celery 5.2 + django-celery-beat、Gunicorn |
| 前端 | Vue 3.2、vue-cli 5 (webpack 5)、Element Plus 2.3、Pinia、vue-router 4、axios、xterm 4、echarts 5、tinymce 5 |
| 存储 | MySQL/MariaDB 8（utf8mb4 + InnoDB，建议 READ-COMMITTED）、Redis 7（缓存 / 会话 / WS / Celery Broker 分库） |
| 部署 | Docker Compose、Nginx、supervisord |

## 目录结构

```
django-devops/
├── backend/                 # Django 源码（主副本）
│   ├── application/         # settings / urls / celery / asgi / wsgi + admin_conf.ini
│   ├── mysystem/            # RBAC 核心模型、登录、初始化命令
│   ├── apps/                # 11 个业务模块
│   ├── utils/               # ViewSet / 权限 / 中间件 / 响应 / 分页基类
│   ├── config.py            # 旧配置（已停用，见「配置」）
│   └── requirements_now*.txt
├── frontend/                # Vue 3 源码
│   └── src/{api,router,store,utils,views,components,config,locales}
├── docker_env/              # 部署栈（唯一真部署）
│   ├── docker-compose.yml   # web + redis + mysql，固定网段 172.19.19.0/24
│   ├── .env                 # 容器环境变量
│   ├── django/              # Dockerfile、entrypoint、supervisord、nginx、预构建 dist
│   └── files/backend/       # compose 实际挂载的后端副本
└── docker-compose.yml       # 开发用单服务脚手架（构建上下文错配，见「已知限制」）
```

## 快速开始

### 1. 本地开发

前置：MySQL 8（库 `test`、utf8mb4、InnoDB）、Redis、Python ≥3.9、Node.js。

```bash
# 后端：仓库没有 requirements.txt，用 requirements_now.txt
cd backend
pip install -r requirements_now.txt -i https://mirrors.aliyun.com/pypi/simple/
python manage.py makemigrations && python manage.py migrate
python manage.py init                 # 初始化菜单与权限；当前会 ImportError，见「已知限制」
python manage.py runserver 127.0.0.1:8000
```

```bash
# 前端（默认 http://127.0.0.1:8088）
cd frontend
npm install
npm start
npm run build                        # 产物 frontend/dist
```

```bash
# 终端 / 日志 WebSocket 需要 ASGI 服务（与 runserver 二选一，不能同端口）
daphne -b 0.0.0.0 -p 8000 --proxy-headers application.asgi:application
# 计划任务
celery -A application worker -B -l info
```

初始账号 `superadmin` / `123456`（**首次登录必须修改**）。接口文档：`/lyapi/`、`/lyredoc/`；业务接口统一前缀 `/api/`。

### 2. Docker 部署

真部署是 `docker_env/docker-compose.yml`（3 服务）；根目录的单服务 compose 仅供本地调试。

```bash
cd docker_env
docker compose up -d
```
