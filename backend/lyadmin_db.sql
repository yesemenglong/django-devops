# Host: localhost  (Version: 5.7.26)
# Date: 2022-12-26 14:48:54
# Generator: MySQL-Front 5.3  (Build 4.234)

/*!40101 SET NAMES utf8 */;

#
# Structure for table "auth_group"
#

-- CREATE TABLE `auth_group` (
--   `id` int(11) NOT NULL AUTO_INCREMENT,
--   `name` varchar(150) NOT NULL,
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `name` (`name`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='group';

#
# Data for table "auth_group"
#


#
# Structure for table "captcha_captchastore"
#

-- CREATE TABLE `captcha_captchastore` (
--   `id` int(11) NOT NULL AUTO_INCREMENT,
--   `challenge` varchar(32) NOT NULL,
--   `response` varchar(32) NOT NULL,
--   `hashkey` varchar(40) NOT NULL,
--   `expiration` datetime(6) NOT NULL,
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `hashkey` (`hashkey`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COMMENT='captcha store';

#
# Data for table "captcha_captchastore"
#

REPLACE INTO `captcha_captchastore` VALUES (2,'1+9=','10','b30a8d21f0d1d95c53b69b994c154e8189cc7c80','2022-07-04 21:33:33.914140'),(6,'3-2=','1','f3dfa2a7cbf3bda32a53298be602874fffaf6c68','2022-07-09 12:12:33.322567'),(8,'8*9=','72','2c7d94480f0c98db4137380db0e194acc258e9a6','2022-07-16 15:01:48.225074'),(9,'5*5=','25','ffd0b6d67099501f4bcdf5240553a22f84669d30','2022-07-17 09:44:46.330850'),(11,'1*6=','6','8150b2d7af32cc9cf1ef2e7f32f47c18079e32ae','2022-07-17 23:58:02.858469'),(13,'5+7=','12','84015e072e7fe570ba8d34deb9f8fc120d115cc4','2022-07-18 09:10:43.608250'),(14,'7+9=','16','37a0cc3cc181ff52f1e993278e883be76b51d9d7','2022-07-18 09:11:06.525042'),(23,'5*2=','10','af73bce2f14be6416917dd639b2fe4690d7352df','2022-07-18 09:26:25.032743'),(24,'3+8=','11','a9d26b51f99fe104a65733bc3be041ed40008d6a','2022-08-02 09:08:52.197430'),(27,'10-9=','1','50102a7a749b50b079b5ac170ebe7020d0934dcb','2022-10-24 21:06:05.242609'),(28,'10*6=','60','ed25bd111e161e961df851693df3a4d62a5ab178','2022-10-24 21:20:03.404962'),(33,'7-6=','1','78d30e6707926c9751f542d20b09479f855ce76c','2022-11-02 14:29:28.754027'),(36,'9-7=','2','a2eef771015339e663df72784be8e641410d1d44','2022-11-02 14:31:15.190850'),(40,'10-5=','5','3f7d16ef76fdda29328e4305c1c90b45f111288b','2022-11-02 14:34:02.344599'),(41,'10-2=','8','ce5074e3c1ee497ca310c59f1ab8bf43cd4ea93e','2022-12-26 14:13:12.877874'),(42,'5+1=','6','6359f47ae2d4d982ff779f1a63de88438cc5e140','2022-12-26 14:13:55.823052'),(43,'7-5=','2','6cf15e55625812ecbd79424b2aeda469a9faf419','2022-12-26 14:14:06.581484'),(44,'6+2=','8','7dda24d6b87263176b2a69fc1114a55432204c10','2022-12-26 14:14:13.046301');

#
# Structure for table "django_celery_beat_clockedschedule"
#

-- CREATE TABLE `django_celery_beat_clockedschedule` (
--   `id` int(11) NOT NULL AUTO_INCREMENT,
--   `clocked_time` datetime(6) NOT NULL COMMENT 'Run the task at clocked time',
--   PRIMARY KEY (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='clocked';

#
# Data for table "django_celery_beat_clockedschedule"
#


#
# Structure for table "django_celery_beat_crontabschedule"
#

-- CREATE TABLE `django_celery_beat_crontabschedule` (
--   `id` int(11) NOT NULL AUTO_INCREMENT,
--   `minute` varchar(240) NOT NULL COMMENT 'Cron Minutes to Run. Use "*" for "all". (Example: "0,30")',
--   `hour` varchar(96) NOT NULL COMMENT 'Cron Hours to Run. Use "*" for "all". (Example: "8,20")',
--   `day_of_week` varchar(64) NOT NULL COMMENT 'Cron Days Of The Week to Run. Use "*" for "all". (Example: "0,5")',
--   `day_of_month` varchar(124) NOT NULL COMMENT 'Cron Days Of The Month to Run. Use "*" for "all". (Example: "1,15")',
--   `month_of_year` varchar(64) NOT NULL COMMENT 'Cron Months Of The Year to Run. Use "*" for "all". (Example: "0,6")',
--   `timezone` varchar(63) NOT NULL COMMENT 'Timezone to Run the Cron Schedule on. Default is UTC.',
--   PRIMARY KEY (`id`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COMMENT='crontab';

#
# Data for table "django_celery_beat_crontabschedule"
#

-- REPLACE INTO `django_celery_beat_crontabschedule` VALUES (6,'*/2','*','*','*','*','Asia/Shanghai'),(7,'0','4','*','*','*','Asia/Shanghai');

#
# Structure for table "django_celery_beat_intervalschedule"
#

-- CREATE TABLE `django_celery_beat_intervalschedule` (
--   `id` int(11) NOT NULL AUTO_INCREMENT,
--   `every` int(11) NOT NULL COMMENT 'Number of interval periods to wait before running the task again',
--   `period` varchar(24) NOT NULL COMMENT 'The type of period between task runs (Example: days)',
--   PRIMARY KEY (`id`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='interval';

#
# Data for table "django_celery_beat_intervalschedule"
#

-- REPLACE INTO `django_celery_beat_intervalschedule` VALUES (1,20,'seconds');

#
# Structure for table "django_celery_beat_periodictasks"
#

-- CREATE TABLE `django_celery_beat_periodictasks` (
--   `ident` smallint(6) NOT NULL,
--   `last_update` datetime(6) NOT NULL,
--   PRIMARY KEY (`ident`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='periodic tasks';

#
# Data for table "django_celery_beat_periodictasks"
#

REPLACE INTO `django_celery_beat_periodictasks` VALUES (1,'2022-11-04 11:03:11.437798');

#
# Structure for table "django_celery_beat_solarschedule"
#

-- CREATE TABLE `django_celery_beat_solarschedule` (
--   `id` int(11) NOT NULL AUTO_INCREMENT,
--   `event` varchar(24) NOT NULL COMMENT 'The type of solar event when the job should run',
--   `latitude` decimal(9,6) NOT NULL COMMENT 'Run the task when the event happens at this latitude',
--   `longitude` decimal(9,6) NOT NULL COMMENT 'Run the task when the event happens at this longitude',
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `django_celery_beat_solar_event_latitude_longitude_ba64999a_uniq` (`event`,`latitude`,`longitude`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='solar event';

#
# Data for table "django_celery_beat_solarschedule"
#


#
# Structure for table "django_celery_beat_periodictask"
#

-- CREATE TABLE `django_celery_beat_periodictask` (
--   `id` int(11) NOT NULL AUTO_INCREMENT,
--   `name` varchar(200) NOT NULL COMMENT 'Short Description For This Task',
--   `task` varchar(200) NOT NULL COMMENT 'The Name of the Celery Task that Should be Run.  (Example: "proj.tasks.import_contacts")',
--   `args` longtext NOT NULL COMMENT 'JSON encoded positional arguments (Example: ["arg1", "arg2"])',
--   `kwargs` longtext NOT NULL COMMENT 'JSON encoded keyword arguments (Example: {"argument": "value"})',
--   `queue` varchar(200) DEFAULT NULL COMMENT 'Queue defined in CELERY_TASK_QUEUES. Leave None for default queuing.',
--   `exchange` varchar(200) DEFAULT NULL COMMENT 'Override Exchange for low-level AMQP routing',
--   `routing_key` varchar(200) DEFAULT NULL COMMENT 'Override Routing Key for low-level AMQP routing',
--   `expires` datetime(6) DEFAULT NULL COMMENT 'Datetime after which the schedule will no longer trigger the task to run',
--   `enabled` tinyint(1) NOT NULL COMMENT 'Set to False to disable the schedule',
--   `last_run_at` datetime(6) DEFAULT NULL COMMENT 'Datetime that the schedule last triggered the task to run. Reset to None if enabled is set to False.',
--   `total_run_count` int(10) unsigned NOT NULL COMMENT 'Running count of how many times the schedule has triggered the task',
--   `date_changed` datetime(6) NOT NULL COMMENT 'Datetime that this PeriodicTask was last modified',
--   `description` longtext NOT NULL COMMENT 'Detailed description about the details of this Periodic Task',
--   `crontab_id` int(11) DEFAULT NULL COMMENT 'Crontab Schedule to run the task on.  Set only one schedule type, leave the others null.',
--   `interval_id` int(11) DEFAULT NULL COMMENT 'Interval Schedule to run the task on.  Set only one schedule type, leave the others null.',
--   `solar_id` int(11) DEFAULT NULL COMMENT 'Solar Schedule to run the task on.  Set only one schedule type, leave the others null.',
--   `one_off` tinyint(1) NOT NULL COMMENT 'If True, the schedule will only run the task a single time',
--   `start_time` datetime(6) DEFAULT NULL COMMENT 'Datetime when the schedule should begin triggering the task to run',
--   `priority` int(10) unsigned DEFAULT NULL COMMENT 'Priority Number between 0 and 255. Supported by: RabbitMQ, Redis (priority reversed, 0 is highest).',
--   `headers` longtext NOT NULL COMMENT 'JSON encoded message headers for the AMQP message.',
--   `clocked_id` int(11) DEFAULT NULL COMMENT 'Clocked Schedule to run the task on.  Set only one schedule type, leave the others null.',
--   `expire_seconds` int(10) unsigned DEFAULT NULL COMMENT 'Timedelta with seconds which the schedule will no longer trigger the task to run',
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `name` (`name`),
--   KEY `django_celery_beat_p_crontab_id_d3cba168_fk_django_ce` (`crontab_id`),
--   KEY `django_celery_beat_p_interval_id_a8ca27da_fk_django_ce` (`interval_id`),
--   KEY `django_celery_beat_p_solar_id_a87ce72c_fk_django_ce` (`solar_id`),
--   KEY `django_celery_beat_p_clocked_id_47a69f82_fk_django_ce` (`clocked_id`),
--   CONSTRAINT `django_celery_beat_p_clocked_id_47a69f82_fk_django_ce` FOREIGN KEY (`clocked_id`) REFERENCES `django_celery_beat_clockedschedule` (`id`),
--   CONSTRAINT `django_celery_beat_p_crontab_id_d3cba168_fk_django_ce` FOREIGN KEY (`crontab_id`) REFERENCES `django_celery_beat_crontabschedule` (`id`),
--   CONSTRAINT `django_celery_beat_p_interval_id_a8ca27da_fk_django_ce` FOREIGN KEY (`interval_id`) REFERENCES `django_celery_beat_intervalschedule` (`id`),
--   CONSTRAINT `django_celery_beat_p_solar_id_a87ce72c_fk_django_ce` FOREIGN KEY (`solar_id`) REFERENCES `django_celery_beat_solarschedule` (`id`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='periodic task';

#
# Data for table "django_celery_beat_periodictask"
#

REPLACE INTO `django_celery_beat_periodictask` VALUES (1,'测试任务','apps.lycrontab.tasks.lytask_test','[]','{}',NULL,NULL,NULL,NULL,0,NULL,182,'2022-11-04 11:02:33.348969','测试任务',6,NULL,NULL,0,NULL,1,'{\"periodic_task_name\": \"\\u6d4b\\u8bd5\\u4efb\\u52a1\", \"task_name\": \"apps.lycrontab.tasks.lytask_test\"}',NULL,NULL),(2,'celery.backend_cleanup','celery.backend_cleanup','[]','{}',NULL,NULL,NULL,NULL,1,NULL,0,'2022-11-04 11:03:11.442926','',7,NULL,NULL,0,NULL,NULL,'{}',NULL,43200),(3,'测试间隔任务','apps.lycrontab.tasks.lytask_test','[]','{}',NULL,NULL,NULL,NULL,1,'2022-11-04 03:04:31.458403',4,'2022-11-04 11:04:33.285246','测试间隔任务',NULL,1,NULL,0,NULL,NULL,'{}',NULL,NULL);

#
# Structure for table "django_celery_results_chordcounter"
#

-- CREATE TABLE `django_celery_results_chordcounter` (
--   `id` int(11) NOT NULL AUTO_INCREMENT,
--   `group_id` varchar(255) NOT NULL COMMENT 'Celery ID for the Chord header group',
--   `sub_tasks` longtext NOT NULL COMMENT 'JSON serialized list of task result tuples. use .group_result() to decode',
--   `count` int(10) unsigned NOT NULL COMMENT 'Starts at len(chord header) and decrements after each task is finished',
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `group_id` (`group_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='chord counter';

#
# Data for table "django_celery_results_chordcounter"
#


#
# Structure for table "django_celery_results_groupresult"
#

-- CREATE TABLE `django_celery_results_groupresult` (
--   `id` int(11) NOT NULL AUTO_INCREMENT,
--   `group_id` varchar(255) NOT NULL COMMENT 'Celery ID for the Group that was run',
--   `date_created` datetime(6) NOT NULL COMMENT 'Datetime field when the group result was created in UTC',
--   `date_done` datetime(6) NOT NULL COMMENT 'Datetime field when the group was completed in UTC',
--   `content_type` varchar(128) NOT NULL COMMENT 'Content type of the result data',
--   `content_encoding` varchar(64) NOT NULL COMMENT 'The encoding used to save the task result data',
--   `result` longtext COMMENT 'The data returned by the task.  Use content_encoding and content_type fields to read.',
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `group_id` (`group_id`),
--   KEY `django_cele_date_cr_bd6c1d_idx` (`date_created`),
--   KEY `django_cele_date_do_caae0e_idx` (`date_done`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='group result';

#
# Data for table "django_celery_results_groupresult"
#


#
# Structure for table "django_celery_results_taskresult"
#

-- CREATE TABLE `django_celery_results_taskresult` (
--   `id` int(11) NOT NULL AUTO_INCREMENT,
--   `task_id` varchar(255) NOT NULL COMMENT 'Celery ID for the Task that was run',
--   `status` varchar(50) NOT NULL COMMENT 'Current state of the task being run',
--   `content_type` varchar(128) NOT NULL COMMENT 'Content type of the result data',
--   `content_encoding` varchar(64) NOT NULL COMMENT 'The encoding used to save the task result data',
--   `result` longtext COMMENT 'The data returned by the task.  Use content_encoding and content_type fields to read.',
--   `date_done` datetime(6) NOT NULL COMMENT 'Datetime field when the task was completed in UTC',
--   `traceback` longtext COMMENT 'Text of the traceback if the task generated one',
--   `meta` longtext COMMENT 'JSON meta information about the task, such as information on child tasks',
--   `task_args` longtext COMMENT 'JSON representation of the positional arguments used with the task',
--   `task_kwargs` longtext COMMENT 'JSON representation of the named arguments used with the task',
--   `task_name` varchar(255) DEFAULT NULL COMMENT 'Name of the Task which was run',
--   `worker` varchar(100) DEFAULT NULL COMMENT 'Worker that executes the task',
--   `date_created` datetime(6) NOT NULL COMMENT 'Datetime field when the task result was created in UTC',
--   `periodic_task_name` varchar(255) DEFAULT NULL COMMENT 'Name of the Periodic Task which was run',
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `task_id` (`task_id`),
--   KEY `django_cele_task_na_08aec9_idx` (`task_name`),
--   KEY `django_cele_status_9b6201_idx` (`status`),
--   KEY `django_cele_worker_d54dd8_idx` (`worker`),
--   KEY `django_cele_date_cr_f04a50_idx` (`date_created`),
--   KEY `django_cele_date_do_f59aad_idx` (`date_done`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8mb4 COMMENT='task result';

#
# Data for table "django_celery_results_taskresult"
#

REPLACE INTO `django_celery_results_taskresult` VALUES (175,'e5763b89-7ffd-4e83-bf0e-03dd58d52ff4','SUCCESS','application/json','utf-8','\"django-vue-lyadmin lycrontab running\"','2022-10-25 23:00:00.038914',NULL,'{\"children\": []}','\"()\"','\"{}\"','apps.lycrontab.tasks.lytask_test','celery@lybbn','2022-10-25 23:00:00.038914','测试任务'),(176,'f599fc36-6f0e-45ef-840a-28c637347a45','SUCCESS','application/json','utf-8','\"django-vue-lyadmin lycrontab running\"','2022-10-25 23:02:00.032690',NULL,'{\"children\": []}','\"()\"','\"{}\"','apps.lycrontab.tasks.lytask_test','celery@lybbn','2022-10-25 23:02:00.032690','测试任务'),(177,'fd2cb51a-d717-4103-a1dd-235efad01259','SUCCESS','application/json','utf-8','\"django-vue-lyadmin lycrontab running\"','2022-10-25 23:04:00.024369',NULL,'{\"children\": []}','\"()\"','\"{}\"','apps.lycrontab.tasks.lytask_test','celery@lybbn','2022-10-25 23:04:00.024369','测试任务'),(178,'2cb746cd-5bd5-4253-bfa7-51220177ad7d','SUCCESS','application/json','utf-8','\"django-vue-lyadmin lycrontab running\"','2022-10-25 23:06:00.022733',NULL,'{\"children\": []}','\"()\"','\"{}\"','apps.lycrontab.tasks.lytask_test','celery@lybbn','2022-10-25 23:06:00.022733','测试任务'),(179,'35dbfa39-b419-4480-a176-99adf5e313df','SUCCESS','application/json','utf-8','\"django-vue-lyadmin lycrontab running\"','2022-10-25 23:08:00.024386',NULL,'{\"children\": []}','\"()\"','\"{}\"','apps.lycrontab.tasks.lytask_test','celery@lybbn','2022-10-25 23:08:00.024386','测试任务'),(180,'e90764b6-0617-4ba1-bd82-cceeeeab4c13','SUCCESS','application/json','utf-8','\"django-vue-lyadmin lycrontab running\"','2022-11-04 11:03:31.477433',NULL,'{\"children\": []}','\"()\"','\"{}\"','apps.lycrontab.tasks.lytask_test','celery@lybbn','2022-11-04 11:03:31.477433','测试间隔任务'),(181,'121329e3-0668-46e8-9edf-bbfb79377395','SUCCESS','application/json','utf-8','\"django-vue-lyadmin lycrontab running\"','2022-11-04 11:03:51.457615',NULL,'{\"children\": []}','\"()\"','\"{}\"','apps.lycrontab.tasks.lytask_test','celery@lybbn','2022-11-04 11:03:51.457615','测试间隔任务'),(182,'29981133-a9e4-4e4f-a683-f5842bcf4a49','SUCCESS','application/json','utf-8','\"django-vue-lyadmin lycrontab running\"','2022-11-04 11:04:11.461721',NULL,'{\"children\": []}','\"()\"','\"{}\"','apps.lycrontab.tasks.lytask_test','celery@lybbn','2022-11-04 11:04:11.461721','测试间隔任务'),(183,'4273ab03-fa31-424e-8b35-bdfc92308259','SUCCESS','application/json','utf-8','\"django-vue-lyadmin lycrontab running\"','2022-11-04 11:04:31.472743',NULL,'{\"children\": []}','\"()\"','\"{}\"','apps.lycrontab.tasks.lytask_test','celery@lybbn','2022-11-04 11:04:31.472743','测试间隔任务');

#
# Structure for table "django_content_type"
#

-- CREATE TABLE `django_content_type` (
--   `id` int(11) NOT NULL AUTO_INCREMENT,
--   `app_label` varchar(100) NOT NULL,
--   `model` varchar(100) NOT NULL,
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COMMENT='content type';

#
# Data for table "django_content_type"
#

-- REPLACE INTO `django_content_type` VALUES (1,'admin','logentry'),(2,'auth','permission'),(3,'auth','group'),(4,'contenttypes','contenttype'),(5,'sessions','session'),(6,'captcha','captchastore'),(7,'mysystem','users'),(8,'mysystem','dept'),(9,'mysystem','dictionary'),(10,'mysystem','menu'),(11,'mysystem','menubutton'),(12,'mysystem','sysdictionarylist'),(13,'mysystem','role'),(14,'mysystem','post'),(15,'mysystem','operationlog'),(16,'mysystem','loginlog'),(17,'mysystem','button'),(18,'lymessages','mymessage'),(19,'lymessages','mymessagetemplate'),(20,'lymessages','mymessageuser'),(25,'lymonitor','monitormanage'),(26,'lywebsocket','terminalserver'),(43,'django_celery_results','taskresult'),(44,'django_celery_results','chordcounter'),(45,'django_celery_results','groupresult'),(46,'django_celery_beat','crontabschedule'),(47,'django_celery_beat','intervalschedule'),(48,'django_celery_beat','periodictask'),(49,'django_celery_beat','periodictasks'),(50,'django_celery_beat','solarschedule'),(51,'django_celery_beat','clockedschedule'),(52,'platformsettings','systemconfig');

#
# Structure for table "auth_permission"
#

-- CREATE TABLE `auth_permission` (
--   `id` int(11) NOT NULL AUTO_INCREMENT,
--   `name` varchar(255) NOT NULL,
--   `content_type_id` int(11) NOT NULL,
--   `codename` varchar(100) NOT NULL,
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
--   CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=utf8mb4 COMMENT='permission';

#
# Data for table "auth_permission"
#

-- REPLACE INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry'),(2, 'Can change log entry', 1, 'change_logentry'),(3, 'Can delete log entry', 1, 'delete_logentry'),(4, 'Can view log entry', 1, 'view_logentry'),(5, 'Can add permission', 2, 'add_permission'),(6, 'Can change permission', 2, 'change_permission'),(7, 'Can delete permission', 2, 'delete_permission'),(8, 'Can view permission', 2, 'view_permission'),(9, 'Can add group', 3, 'add_group'),(10, 'Can change group', 3, 'change_group'),(11, 'Can delete group', 3, 'delete_group'),(12, 'Can view group', 3, 'view_group'),(13, 'Can add content type', 4, 'add_contenttype'),(14, 'Can change content type', 4, 'change_contenttype'),(15, 'Can delete content type', 4, 'delete_contenttype'),(16, 'Can view content type', 4, 'view_contenttype'),(17, 'Can add session', 5, 'add_session'),(18, 'Can change session', 5, 'change_session'),(19, 'Can delete session', 5, 'delete_session'),(20, 'Can view session', 5, 'view_session'),(21, 'Can add captcha store', 6, 'add_captchastore'),(22, 'Can change captcha store', 6, 'change_captchastore'),(23, 'Can delete captcha store', 6, 'delete_captchastore'),(24, 'Can view captcha store', 6, 'view_captchastore'),(25, 'Can add task result', 7, 'add_taskresult'),(26, 'Can change task result', 7, 'change_taskresult'),(27, 'Can delete task result', 7, 'delete_taskresult'),(28, 'Can view task result', 7, 'view_taskresult'),(29, 'Can add chord counter', 8, 'add_chordcounter'),(30, 'Can change chord counter', 8, 'change_chordcounter'),(31, 'Can delete chord counter', 8, 'delete_chordcounter'),(32, 'Can view chord counter', 8, 'view_chordcounter'),(33, 'Can add group result', 9, 'add_groupresult'),(34, 'Can change group result', 9, 'change_groupresult'),(35, 'Can delete group result', 9, 'delete_groupresult'),(36, 'Can view group result', 9, 'view_groupresult'),(37, 'Can add crontab', 10, 'add_crontabschedule'),(38, 'Can change crontab', 10, 'change_crontabschedule'),(39, 'Can delete crontab', 10, 'delete_crontabschedule'),(40, 'Can view crontab', 10, 'view_crontabschedule'),(41, 'Can add interval', 11, 'add_intervalschedule'),(42, 'Can change interval', 11, 'change_intervalschedule'),(43, 'Can delete interval', 11, 'delete_intervalschedule'),(44, 'Can view interval', 11, 'view_intervalschedule'),(45, 'Can add periodic task', 12, 'add_periodictask'),(46, 'Can change periodic task', 12, 'change_periodictask'),(47, 'Can delete periodic task', 12, 'delete_periodictask'),(48, 'Can view periodic task', 12, 'view_periodictask'),(49, 'Can add periodic tasks', 13, 'add_periodictasks'),(50, 'Can change periodic tasks', 13, 'change_periodictasks'),(51, 'Can delete periodic tasks', 13, 'delete_periodictasks'),(52, 'Can view periodic tasks', 13, 'view_periodictasks'),(53, 'Can add solar event', 14, 'add_solarschedule'),(54, 'Can change solar event', 14, 'change_solarschedule'),(55, 'Can delete solar event', 14, 'delete_solarschedule'),(56, 'Can view solar event', 14, 'view_solarschedule'),(57, 'Can add clocked', 15, 'add_clockedschedule'),(58, 'Can change clocked', 15, 'change_clockedschedule'),(59, 'Can delete clocked', 15, 'delete_clockedschedule'),(60, 'Can view clocked', 15, 'view_clockedschedule'),(61, 'Can add 用户表', 16, 'add_users'),(62, 'Can change 用户表', 16, 'change_users'),(63, 'Can delete 用户表', 16, 'delete_users'),(64, 'Can view 用户表', 16, 'view_users'),(65, 'Can add 部门表', 17, 'add_dept'),(66, 'Can change 部门表', 17, 'change_dept'),(67, 'Can delete 部门表', 17, 'delete_dept'),(68, 'Can view 部门表', 17, 'view_dept'),(69, 'Can add 字典表', 18, 'add_dictionary'),(70, 'Can change 字典表', 18, 'change_dictionary'),(71, 'Can delete 字典表', 18, 'delete_dictionary'),(72, 'Can view 字典表', 18, 'view_dictionary'),(73, 'Can add 菜单表', 19, 'add_menu'),(74, 'Can change 菜单表', 19, 'change_menu'),(75, 'Can delete 菜单表', 19, 'delete_menu'),(76, 'Can view 菜单表', 19, 'view_menu'),(77, 'Can add 菜单权限表', 20, 'add_menubutton'),(78, 'Can change 菜单权限表', 20, 'change_menubutton'),(79, 'Can delete 菜单权限表', 20, 'delete_menubutton'),(80, 'Can view 菜单权限表', 20, 'view_menubutton'),(81, 'Can add 字典详细表', 21, 'add_sysdictionarylist'),(82, 'Can change 字典详细表', 21, 'change_sysdictionarylist'),(83, 'Can delete 字典详细表', 21, 'delete_sysdictionarylist'),(84, 'Can view 字典详细表', 21, 'view_sysdictionarylist'),(85, 'Can add 角色表', 22, 'add_role'),(86, 'Can change 角色表', 22, 'change_role'),(87, 'Can delete 角色表', 22, 'delete_role'),(89, 'Can add 岗位表', 23, 'add_post'),(90, 'Can change 岗位表', 23, 'change_post'),(91, 'Can delete 岗位表', 23, 'delete_post'),(92, 'Can view 岗位表', 23, 'view_post'),(93, 'Can add 操作日志', 24, 'add_operationlog'),(94, 'Can change 操作日志', 24, 'change_operationlog'),(95, 'Can delete 操作日志', 24, 'delete_operationlog'),(96, 'Can view 操作日志', 24, 'view_operationlog'),(97, 'Can add 登录日志', 25, 'add_loginlog'),(98, 'Can change 登录日志', 25, 'change_loginlog'),(99, 'Can delete 登录日志', 25, 'delete_loginlog'),(100, 'Can view 登录日志', 25, 'view_loginlog'),(101, 'Can add 权限标识表', 26, 'add_button'),(102, 'Can change 权限标识表', 26, 'change_button'),(103, 'Can delete 权限标识表', 26, 'delete_button'),(104, 'Can view 权限标识表', 26, 'view_button'),(105, 'Can add 系统配置表', 27, 'add_systemconfig'),(106, 'Can change 系统配置表', 27, 'change_systemconfig'),(107, 'Can delete 系统配置表', 27, 'delete_systemconfig'),(108, 'Can view 系统配置表', 27, 'view_systemconfig'),(109, 'Can add zone merge list', 28, 'add_zonemergelist'),(110, 'Can change zone merge list', 28, 'change_zonemergelist'),(111, 'Can delete zone merge list', 28, 'delete_zonemergelist'),(112, 'Can view zone merge list', 28, 'view_zonemergelist'),(113, 'Can add Zone列表', 29, 'add_zonelist')(114, 'Can change Zone列表', 29, 'change_zonelist'),(115, 'Can delete Zone列表', 29, 'delete_zonelist'),(116, 'Can view Zone列表', 29, 'view_zonelist'),(117, 'Can add Minion列表', 30, 'add_minionlist'),(118, 'Can change Minion列表', 30, 'change_minionlist'),(119, 'Can delete Minion列表', 30, 'delete_minionlist'),(120, 'Can view Minion列表', 30, 'view_minionlist'),(121, 'Can add Salt-key信息表', 31, 'add_saltkeylist'),(122, 'Can change Salt-key信息表', 31, 'change_saltkeylist'),(123, 'Can delete Salt-key信息表', 31, 'delete_saltkeylist'),(124, 'Can view Salt-key信息表', 31, 'view_saltkeylist'),(125, 'Can add salt命令集表', 32, 'add_saltcmdinfo'),(126, 'Can change salt命令集表', 32, 'change_saltcmdinfo'),(127, 'Can delete salt命令集表', 32, 'delete_saltcmdinfo'),(128, 'Can view salt命令集表', 32, 'view_saltcmdinfo'),(129, 'Can add 服务监控', 33, 'add_monitormanage'),(130, 'Can change 服务监控', 33, 'change_monitormanage'),(131, 'Can delete 服务监控', 33, 'delete_monitormanage'),(132, 'Can view 服务监控', 33, 'view_monitormanage'),(133, 'Can add 终端服务器列表', 34, 'add_terminalserver'),(134, 'Can change 终端服务器列表', 34, 'change_terminalserver'),(135, 'Can delete 终端服务器列表', 34, 'delete_terminalserver'),(136, 'Can view 终端服务器列表', 34, 'view_terminalserver'),(137, 'Can add 系统参数表', 35, 'add_systemconf'),(138, 'Can change 系统参数表', 35, 'change_systemconf'),(139, 'Can delete 系统参数表', 35, 'delete_systemconf'),(140, 'Can view 系统参数表', 35, 'view_systemconf');

#
# Structure for table "auth_group_permissions"
#

-- CREATE TABLE `auth_group_permissions` (
--   `id` bigint(20) NOT NULL AUTO_INCREMENT,
--   `group_id` int(11) NOT NULL,
--   `permission_id` int(11) NOT NULL,
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
--   KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
--   CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
--   CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

#
# Data for table "auth_group_permissions"
#


-- #
-- # Structure for table "django_migrations"
-- #

-- CREATE TABLE `django_migrations` (
--   `id` bigint(20) NOT NULL AUTO_INCREMENT,
--   `app` varchar(255) NOT NULL,
--   `name` varchar(255) NOT NULL,
--   `applied` datetime(6) NOT NULL,
--   PRIMARY KEY (`id`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4;

-- #
-- # Data for table "django_migrations"
-- #

-- REPLACE INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2022-06-27 13:55:53.748972'),(2,'contenttypes','0002_remove_content_type_name','2022-06-27 13:55:53.787329'),(3,'auth','0001_initial','2022-06-27 13:55:53.890403'),(4,'auth','0002_alter_permission_name_max_length','2022-06-27 13:55:53.913113'),(5,'auth','0003_alter_user_email_max_length','2022-06-27 13:55:53.918102'),(6,'auth','0004_alter_user_username_opts','2022-06-27 13:55:53.922090'),(7,'auth','0005_alter_user_last_login_null','2022-06-27 13:55:53.928074'),(8,'auth','0006_require_contenttypes_0002','2022-06-27 13:55:53.929641'),(9,'auth','0007_alter_validators_add_error_messages','2022-06-27 13:55:53.934220'),(10,'auth','0008_alter_user_username_max_length','2022-06-27 13:55:53.938209'),(11,'auth','0009_alter_user_last_name_max_length','2022-06-27 13:55:53.942192'),(12,'auth','0010_alter_group_name_max_length','2022-06-27 13:55:53.953329'),(13,'auth','0011_update_proxy_permissions','2022-06-27 13:55:53.958316'),(14,'auth','0012_alter_user_first_name_max_length','2022-06-27 13:55:53.963303'),(15,'mysystem','0001_initial','2022-06-27 13:55:54.513606'),(16,'address','0001_initial','2022-06-27 13:55:54.526244'),(17,'address','0002_initial','2022-06-27 13:55:54.593635'),(18,'admin','0001_initial','2022-06-27 13:55:54.654455'),(19,'admin','0002_logentry_remove_auto_add','2022-06-27 13:55:54.673376'),(20,'admin','0003_logentry_add_action_flag_choices','2022-06-27 13:55:54.725238'),(21,'captcha','0001_initial','2022-06-27 13:55:54.737297'),(22,'captcha','0002_alter_captchastore_id','2022-06-27 13:55:54.741287'),(23,'lymessages','0001_initial','2022-06-27 13:55:54.790558'),(24,'lymessages','0002_initial','2022-06-27 13:55:54.966977'),(25,'oauth','0001_initial','2022-06-27 13:55:55.027418'),(26,'platformsettings','0001_initial','2022-06-27 13:55:55.094296'),(27,'sessions','0001_initial','2022-06-27 13:55:55.113233'),(28,'lymonitor','0001_initial','2022-07-09 12:09:04.885260'),(29,'lywebsocket','0001_initial','2022-07-17 17:05:46.479597'),(30,'lywebsocket','0002_terminalserver_port','2022-07-17 17:47:03.222975'),(31,'address','0003_address','2022-07-28 23:11:24.792968'),(32,'platformsettings','0002_lunbotumanage_link_type_alter_lunbotumanage_link_and_more','2022-07-28 23:11:27.979944'),(33,'mall','0001_initial','2022-07-28 23:18:16.290271'),(34,'mall','0002_alter_sku_options_alter_skuspecification_options_and_more','2022-07-31 22:47:25.341862'),(35,'django_celery_beat','0001_initial','2022-10-23 09:55:18.293036'),(36,'django_celery_beat','0002_auto_20161118_0346','2022-10-23 09:55:18.402212'),(37,'django_celery_beat','0003_auto_20161209_0049','2022-10-23 09:55:18.433176'),(38,'django_celery_beat','0004_auto_20170221_0000','2022-10-23 09:55:18.441921'),(39,'django_celery_beat','0005_add_solarschedule_events_choices','2022-10-23 09:55:18.450929'),(40,'django_celery_beat','0006_auto_20180322_0932','2022-10-23 09:55:18.535599'),(41,'django_celery_beat','0007_auto_20180521_0826','2022-10-23 09:55:18.652596'),(42,'django_celery_beat','0008_auto_20180914_1922','2022-10-23 09:55:18.670194'),(43,'django_celery_beat','0006_auto_20180210_1226','2022-10-23 09:55:18.683140'),(44,'django_celery_beat','0006_periodictask_priority','2022-10-23 09:55:18.746533'),(45,'django_celery_beat','0009_periodictask_headers','2022-10-23 09:55:18.803436'),(46,'django_celery_beat','0010_auto_20190429_0326','2022-10-23 09:55:18.883826'),(47,'django_celery_beat','0011_auto_20190508_0153','2022-10-23 09:55:18.988147'),(48,'django_celery_beat','0012_periodictask_expire_seconds','2022-10-23 09:55:19.049062'),(49,'django_celery_beat','0013_auto_20200609_0727','2022-10-23 09:55:19.058651'),(50,'django_celery_beat','0014_remove_clockedschedule_enabled','2022-10-23 09:55:19.105641'),(51,'django_celery_beat','0015_edit_solarschedule_events_choices','2022-10-23 09:55:19.115018'),(52,'django_celery_beat','0016_alter_crontabschedule_timezone','2022-10-23 09:55:19.124035'),(53,'django_celery_results','0001_initial','2022-10-23 09:55:19.178461'),(54,'django_celery_results','0002_add_task_name_args_kwargs','2022-10-23 09:55:19.336008'),(55,'django_celery_results','0003_auto_20181106_1101','2022-10-23 09:55:19.349672'),(56,'django_celery_results','0004_auto_20190516_0412','2022-10-23 09:55:19.440410'),(57,'django_celery_results','0005_taskresult_worker','2022-10-23 09:55:19.533985'),(58,'django_celery_results','0006_taskresult_date_created','2022-10-23 09:55:19.647751'),(59,'django_celery_results','0007_remove_taskresult_hidden','2022-10-23 09:55:19.714334'),(60,'django_celery_results','0008_chordcounter','2022-10-23 09:55:19.744689'),(61,'django_celery_results','0009_groupresult','2022-10-23 09:55:20.581146'),(62,'django_celery_results','0010_remove_duplicate_indices','2022-10-23 09:55:20.594296'),(63,'django_celery_results','0011_taskresult_periodic_task_name','2022-10-23 09:55:20.660684'),(64,'mysystem','0002_alter_users_identity_alter_users_mobile','2022-10-23 09:55:20.718751'),(65,'oauth','0002_alter_oauthwxuser_mobilephonenumber','2022-10-23 09:55:20.797735'),(66,'platformsettings','0003_alter_othermanage_type','2022-10-23 09:55:20.826744'),(67,'platformsettings','0004_alter_othermanage_options','2022-10-30 11:02:23.618825'),(68,'platformsettings','0005_systemconfig','2022-11-13 16:53:19.885194'),(69,'platformsettings','0006_alter_systemconfig_form_item_type','2022-12-26 14:08:54.441693'),(70,'platformsettings','0007_alter_systemconfig_data_options_and_more','2022-12-26 14:08:54.700890'),(71,'platformsettings','0008_alter_systemconfig_form_item_type','2022-12-26 14:24:25.238443');

#
# Structure for table "django_session"
#

-- CREATE TABLE `django_session` (
--   `session_key` varchar(40) NOT NULL,
--   `session_data` longtext NOT NULL,
--   `expire_date` datetime(6) NOT NULL,
--   PRIMARY KEY (`session_key`),
--   KEY `django_session_expire_date_a5c62663` (`expire_date`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='session';

#
# Data for table "django_session"
#


#
# Structure for table "lyadmin_button"
#

-- CREATE TABLE `lyadmin_button` (
--   `id` varchar(100) NOT NULL COMMENT 'Id',
--   `description` varchar(100) DEFAULT NULL COMMENT '描述',
--   `modifier` varchar(100) DEFAULT NULL COMMENT '修改人',
--   `dept_belong_id` varchar(100) DEFAULT NULL COMMENT '数据归属部门',
--   `update_datetime` datetime(6) DEFAULT NULL COMMENT '修改时间',
--   `create_datetime` datetime(6) DEFAULT NULL COMMENT '创建时间',
--   `name` varchar(64) NOT NULL COMMENT '权限名称',
--   `value` varchar(64) NOT NULL COMMENT '权限值',
--   `creator_id` varchar(100) DEFAULT NULL COMMENT '创建人',
--   PRIMARY KEY (`id`),
--   KEY `lyadmin_button_creator_id_8ed6f8c5` (`creator_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='权限标识表';

#
# Data for table "lyadmin_button"
#

REPLACE INTO `lyadmin_button` VALUES ('09134d7643504804a6c7cc3d16e06684',NULL,'456b688c-8ad5-46de-bc2e-d41d8047bd42',NULL,'2022-10-25 23:09:53.863898','2022-10-25 23:09:53.863898','日志','Logs','456b688c-8ad5-46de-bc2e-d41d8047bd42'),('2d763a6d6dcf409d87056efd06aace0a',NULL,NULL,NULL,'2022-06-27 13:56:06.159513','2022-06-27 13:56:06.159513','修改密码','Changepassword',NULL),('43d89c33967545a387a3ac27c02460b6',NULL,'456b688c-8ad5-46de-bc2e-d41d8047bd42',NULL,'2022-08-01 23:16:24.046679','2022-08-01 23:16:24.046679','统计','Statistics','456b688c-8ad5-46de-bc2e-d41d8047bd42'),('4547b93a-36b9-410d-987c-3c52a9b51156',NULL,NULL,NULL,'2022-06-27 13:56:06.149563','2022-06-27 13:56:06.149563','编辑','Update',NULL),('4a410769-6b0a-4ed3-90f0-b5d89a6f802c',NULL,NULL,NULL,'2022-06-27 13:56:06.151529','2022-06-27 13:56:06.151529','删除','Delete',NULL),('5bf695439e9d4c4d9601bf4fb558b3a2',NULL,'456b688c-8ad5-46de-bc2e-d41d8047bd42',NULL,'2022-10-26 00:05:18.024132','2022-10-26 00:05:18.024132','任务列表','Tasklist','456b688c-8ad5-46de-bc2e-d41d8047bd42'),('644e9c34-e3d6-4518-b795-a603a6e9a137',NULL,NULL,NULL,'2022-06-27 13:56:06.153525','2022-06-27 13:56:06.153525','单例','Retrieve',NULL),('6e0a41e5308c44a8b0d2785e05b2c07a',NULL,NULL,NULL,'2022-06-27 13:56:06.161507','2022-06-27 13:56:06.161507','禁用','Disable',NULL),('80cb145b-5035-4517-a28a-7d59426f73f8',NULL,NULL,NULL,'2022-06-27 13:56:06.154522','2022-06-27 13:56:06.154522','新增','Create',NULL),('83a9b774-4669-4d2f-b61d-8ee4944c2316',NULL,NULL,NULL,'2022-06-27 13:56:06.158517','2022-06-27 13:56:06.158517','保存','Save',NULL),('c66a0ab23a6044189ae0beb530ac68cf',NULL,'456b688c-8ad5-46de-bc2e-d41d8047bd42',NULL,'2022-08-01 23:16:11.387119','2022-08-01 23:16:11.387119','发货','Deliver','456b688c-8ad5-46de-bc2e-d41d8047bd42'),('ccc3f35f-c80c-4929-b8cc-67531698f397',NULL,NULL,NULL,'2022-06-27 13:56:06.156517','2022-06-27 13:56:06.156517','查询','Search',NULL),('f3f365e9bfab44f587cbd91e3691ef0f',NULL,'456b688c-8ad5-46de-bc2e-d41d8047bd42',NULL,'2022-07-18 10:33:33.017933','2022-07-18 10:33:33.017933','终端','Terminal','456b688c-8ad5-46de-bc2e-d41d8047bd42');

#
# Structure for table "lyadmin_dept"
#

-- CREATE TABLE `lyadmin_dept` (
--   `id` varchar(100) NOT NULL COMMENT 'Id',
--   `description` varchar(100) DEFAULT NULL COMMENT '描述',
--   `modifier` varchar(100) DEFAULT NULL COMMENT '修改人',
--   `dept_belong_id` varchar(100) DEFAULT NULL COMMENT '数据归属部门',
--   `update_datetime` datetime(6) DEFAULT NULL COMMENT '修改时间',
--   `create_datetime` datetime(6) DEFAULT NULL COMMENT '创建时间',
--   `name` varchar(64) NOT NULL COMMENT '部门名称',
--   `sort` int(11) NOT NULL COMMENT '显示排序',
--   `owner` varchar(32) DEFAULT NULL COMMENT '负责人',
--   `phone` varchar(32) DEFAULT NULL COMMENT '联系电话',
--   `email` varchar(32) DEFAULT NULL COMMENT '邮箱',
--   `status` smallint(6) DEFAULT NULL COMMENT '部门状态',
--   `creator_id` varchar(100) DEFAULT NULL COMMENT '创建人',
--   `parent_id` varchar(100) DEFAULT NULL COMMENT '上级部门',
--   PRIMARY KEY (`id`),
--   KEY `lyadmin_dept_creator_id_bb4dafb6` (`creator_id`),
--   KEY `lyadmin_dept_parent_id_c856ab90` (`parent_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='部门表';

#
# Data for table "lyadmin_dept"
#

REPLACE INTO `lyadmin_dept` VALUES ('cae96ade-7483-4827-bb0d-d2bd63ec1cc4',NULL,NULL,NULL,'2022-06-27 13:56:06.141286','2022-06-27 13:56:06.141286','财务部门',1,NULL,NULL,NULL,1,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3'),('d2c03bd9-dad0-4262-88ca-c3681d224fc3',NULL,NULL,NULL,'2022-06-27 13:56:06.144084','2022-06-27 13:56:06.144084','lyadmin团队',1,NULL,NULL,NULL,1,NULL,NULL),('fd8230ca-67bd-4347-8a9b-57eb19be5d9e',NULL,NULL,NULL,'2022-06-27 13:56:06.146078','2022-06-27 13:56:06.146078','研发部门',2,NULL,NULL,NULL,1,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3');

#
# Structure for table "lyadmin_dictionary"
#

-- CREATE TABLE `lyadmin_dictionary` (
--   `id` varchar(100) NOT NULL COMMENT 'Id',
--   `description` varchar(100) DEFAULT NULL COMMENT '描述',
--   `modifier` varchar(100) DEFAULT NULL COMMENT '修改人',
--   `dept_belong_id` varchar(100) DEFAULT NULL COMMENT '数据归属部门',
--   `update_datetime` datetime(6) DEFAULT NULL COMMENT '修改时间',
--   `create_datetime` datetime(6) DEFAULT NULL COMMENT '创建时间',
--   `code` varchar(100) DEFAULT NULL COMMENT '编码',
--   `name` varchar(100) DEFAULT NULL COMMENT '名称',
--   `status` smallint(6) NOT NULL COMMENT '状态',
--   `sort` int(11) DEFAULT NULL COMMENT '显示排序',
--   `remark` varchar(255) DEFAULT NULL COMMENT '备注',
--   `creator_id` varchar(100) DEFAULT NULL COMMENT '创建人',
--   `parent_id` varchar(100) DEFAULT NULL COMMENT '父级',
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `code` (`code`),
--   KEY `lyadmin_dictionary_creator_id_f75d1c0b` (`creator_id`),
--   KEY `lyadmin_dictionary_parent_id_9d47f813` (`parent_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='字典表';

#
# Data for table "lyadmin_dictionary"
#


#
# Structure for table "lyadmin_dictionary_detail"
#

-- CREATE TABLE `lyadmin_dictionary_detail` (
--   `id` varchar(100) NOT NULL COMMENT 'Id',
--   `description` varchar(100) DEFAULT NULL COMMENT '描述',
--   `modifier` varchar(100) DEFAULT NULL COMMENT '修改人',
--   `dept_belong_id` varchar(100) DEFAULT NULL COMMENT '数据归属部门',
--   `update_datetime` datetime(6) DEFAULT NULL COMMENT '修改时间',
--   `create_datetime` datetime(6) DEFAULT NULL COMMENT '创建时间',
--   `code` varchar(100) DEFAULT NULL COMMENT '编码',
--   `label` varchar(100) DEFAULT NULL COMMENT '显示名称',
--   `value` varchar(100) DEFAULT NULL COMMENT '实际值',
--   `status` smallint(6) NOT NULL COMMENT '状态',
--   `remark` varchar(255) DEFAULT NULL COMMENT '备注',
--   `creator_id` varchar(100) DEFAULT NULL COMMENT '创建人',
--   `dict_id` varchar(100) DEFAULT NULL COMMENT '关联主表',
--   PRIMARY KEY (`id`),
--   KEY `lyadmin_dictionary_detail_creator_id_6422260d` (`creator_id`),
--   KEY `lyadmin_dictionary_detail_dict_id_418a11f9` (`dict_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='字典详细表';

#
# Data for table "lyadmin_dictionary_detail"
#


-- #
-- # Structure for table "lyadmin_login_log"
-- #

-- CREATE TABLE `lyadmin_login_log` (
--   `id` varchar(100) NOT NULL COMMENT 'Id',
--   `description` varchar(100) DEFAULT NULL COMMENT '描述',
--   `modifier` varchar(100) DEFAULT NULL COMMENT '修改人',
--   `dept_belong_id` varchar(100) DEFAULT NULL COMMENT '数据归属部门',
--   `update_datetime` datetime(6) DEFAULT NULL COMMENT '修改时间',
--   `create_datetime` datetime(6) DEFAULT NULL COMMENT '创建时间',
--   `username` varchar(32) DEFAULT NULL COMMENT '登录用户名',
--   `ip` varchar(32) DEFAULT NULL COMMENT '登录ip',
--   `agent` varchar(1500) DEFAULT NULL COMMENT 'agent信息',
--   `browser` varchar(200) DEFAULT NULL COMMENT '浏览器名',
--   `os` varchar(150) DEFAULT NULL COMMENT '操作系统',
--   `login_type` int(11) NOT NULL COMMENT '登录类型',
--   `creator_id` varchar(100) DEFAULT NULL COMMENT '创建人',
--   PRIMARY KEY (`id`),
--   KEY `lyadmin_login_log_creator_id_2aae8b60` (`creator_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='登录日志';

-- #
-- # Data for table "lyadmin_login_log"
-- #

-- REPLACE INTO `lyadmin_login_log` VALUES ('01dac32a5f604181b2f70bb9c22f873f',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-11-02 14:38:57.045124','2022-11-02 14:38:57.045124','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('02bab9a287084803851835f574e1f157',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-11-02 14:59:37.265700','2022-11-02 14:59:37.265700','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('044afb25297e465398b4c2af1adfc430',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-11-02 14:32:15.783705','2022-11-02 14:32:15.783705','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('277174d7a6a145a5b2bac1b111cba012',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-10-22 20:41:58.336842','2022-10-22 20:41:58.336842','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('2dcf5dd4538f41c39b15ac150ff7515e',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-11-02 14:32:28.820114','2022-11-02 14:32:28.820114','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('36c92cb7876f4097b4e5280e4e946330',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-11-02 14:28:17.818701','2022-11-02 14:28:17.818701','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('3d0ad55e518d4751a5b8ebf7a57160d6',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-11-02 14:33:02.131471','2022-11-02 14:33:02.131471','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('3d24543b50984bb4a3823cc8b354fc8d',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-10-29 11:04:38.236059','2022-10-29 11:04:38.236059','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('41334fd06cb344dbb71e1962b3db7747',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-10-24 21:19:16.635721','2022-10-24 21:19:16.635721','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('48b7ac4753194681be03bea2a365d006',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-11-02 14:11:14.266591','2022-11-02 14:11:14.266591','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('58db56729b02424fab6e6f1055e30b17',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-10-24 17:28:21.946728','2022-10-24 17:28:21.946728','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('593f5858843d4ab69378b68b01919fe3',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-10-25 23:32:02.749615','2022-10-25 23:32:02.749615','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('5a539edb45dd49d097862963c1fee28a',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-11-02 14:28:28.513047','2022-11-02 14:28:28.513047','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('5b83c20e8186452cbec43cd1e4541c3b',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-11-13 19:29:29.939438','2022-11-13 19:29:29.939438','superadmin','127.0.0.1','PC / Windows 10 / Chrome 107.0.0','Chrome 107.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('634ed476fe6847cca27c53039c9f8262',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-10-23 10:58:12.433010','2022-10-23 10:58:12.433010','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('69e7ee8faae74ce09e8e4173dda1414e',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-11-02 14:45:18.137031','2022-11-02 14:45:18.137031','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('6d67b2f1bb7a4561af7b3906134d66d3',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-11-02 14:34:13.464796','2022-11-02 14:34:13.464796','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('77d0a61e37e446e4ac2aacc3caec8845',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-11-02 14:58:39.275180','2022-11-02 14:58:39.275180','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('7b3e2857f810483781ec72f41d29ec36',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-11-03 08:57:44.522814','2022-11-03 08:57:44.522814','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('7b98eae7ad7c4f3fbbc8a8f91fc885a3',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-11-13 15:57:08.239500','2022-11-13 15:57:08.239500','superadmin','127.0.0.1','PC / Windows 10 / Chrome 107.0.0','Chrome 107.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('8367ea7e2f004a4f9fcd762af21102bc',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-11-02 14:47:14.609703','2022-11-02 14:47:14.609703','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('8a318122ede6468b90b04cbd14d0ad06',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-11-02 14:59:16.894020','2022-11-02 14:59:16.894020','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('9ba456c13f0440028066eb20629d0ebf',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-11-02 14:30:14.937349','2022-11-02 14:30:14.937349','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('9bb260326b494028ac893c2ddae52b2a',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-11-13 15:49:16.392279','2022-11-13 15:49:16.392279','superadmin','127.0.0.1','PC / Windows 10 / Chrome 107.0.0','Chrome 107.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('a41b56519dbe430eab305cc76748fc7e',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-11-02 14:34:22.074300','2022-11-02 14:34:22.074300','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('b0a5db4c6c344505afa73b5bc357a83b',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-11-02 14:26:23.336676','2022-11-02 14:26:23.336676','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('bbc948f0ff8a44f69738c8cc3c30d222',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-12-26 14:13:35.739354','2022-12-26 14:13:35.739354','superadmin','127.0.0.1','PC / Windows 10 / Chrome 107.0.0','Chrome 107.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('bfa2d22a86354772af64096a246ab5c4',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-10-25 11:36:16.288896','2022-10-25 11:36:16.288896','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('eb1aebd83bec44f2a8e9d21560d0b1ac',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-11-02 14:28:44.078017','2022-11-02 14:28:44.078017','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('eb5dd52660734e8aadb15bc309ef5689',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-10-24 20:05:01.526327','2022-10-24 20:05:01.526327','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42'),('f89c3129a60b45e0a0c8009f5167e30c',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-10-30 10:56:33.162753','2022-10-30 10:56:33.162753','superadmin','127.0.0.1','PC / Windows 10 / Chrome 106.0.0','Chrome 106.0.0','Windows 10',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42');

#
# Structure for table "lyadmin_menu"
#

-- CREATE TABLE `lyadmin_menu` (
--   `id` varchar(100) NOT NULL COMMENT 'Id',
--   `description` varchar(100) DEFAULT NULL COMMENT '描述',
--   `modifier` varchar(100) DEFAULT NULL COMMENT '修改人',
--   `dept_belong_id` varchar(100) DEFAULT NULL COMMENT '数据归属部门',
--   `update_datetime` datetime(6) DEFAULT NULL COMMENT '修改时间',
--   `create_datetime` datetime(6) DEFAULT NULL COMMENT '创建时间',
--   `icon` varchar(64) DEFAULT NULL COMMENT '菜单图标',
--   `name` varchar(64) NOT NULL COMMENT '菜单名称',
--   `sort` int(11) DEFAULT NULL COMMENT '显示排序',
--   `is_link` smallint(6) NOT NULL COMMENT '是否外链',
--   `web_path` varchar(128) DEFAULT NULL COMMENT '路由地址',
--   `component` varchar(128) DEFAULT NULL COMMENT '组件地址',
--   `component_name` varchar(50) DEFAULT NULL COMMENT '组件名称',
--   `status` smallint(6) NOT NULL COMMENT '菜单状态',
--   `isautopm` smallint(6) NOT NULL COMMENT '自动创建按钮权限',
--   `cache` smallint(6) NOT NULL COMMENT '是否页面缓存',
--   `visible` smallint(6) NOT NULL COMMENT '侧边栏中是否显示',
--   `creator_id` varchar(100) DEFAULT NULL COMMENT '创建人',
--   `parent_id` varchar(100) DEFAULT NULL COMMENT '上级菜单',
--   PRIMARY KEY (`id`),
--   KEY `lyadmin_menu_creator_id_39b95522` (`creator_id`),
--   KEY `lyadmin_menu_parent_id_4a6f3129` (`parent_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='菜单表';

#
# Data for table "lyadmin_menu"
#

REPLACE INTO `lyadmin_menu` VALUES ('09a42810d4dd4b2eb939f8eb0b01d9d1', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL, '2022-07-04 21:53:54.572593', '2022-07-04 20:52:44.855447', '', '计划任务', 20, 0, 'crontab', NULL, NULL, 1, 1, 0, 1, '456b688c-8ad5-46de-bc2e-d41d8047bd42', '77edf447326b4e0dbc6f9719c1de8a12'),('0a4c1fb43ce84d5290eede4bc1ff5c7b', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', 'd2c03bd9-dad0-4262-88ca-c3681d224fc3', '2023-02-14 18:21:32.025044', '2023-02-08 17:05:40.097490', '', 'Minion管理', 1, 0, 'minionTable', NULL, NULL, 1, 1, 0, 1, '456b688c-8ad5-46de-bc2e-d41d8047bd42', '94a6b360dfa9416ca57c1a24069d3e17'),('151035da-77a3-4a62-b474-fce6824571fb', NULL, 'd1431450-5068-4461-b57e-7862c005a547', NULL, '2023-02-08 13:59:32.351504', '2022-06-27 13:56:06.189196', '', '按钮管理', 6, 0, 'buttonManage', 'system/button', 'buttonManage', 1, 0, 0, 0, NULL, '54f769b0-3dff-416c-8102-e55ec44827cc'),('15c9ebc5-d12f-470a-a560-938a7dc57570', NULL, NULL, NULL, '2022-06-27 13:56:06.185699', '2022-06-27 13:56:06.185699', '', '角色管理', 3, 0, 'roleManage', 'system/role', 'role', 1, 0, 0, 1, NULL, '54f769b0-3dff-416c-8102-e55ec44827cc'),('244b28685cd14a39a383189981510d4a', NULL, NULL, NULL, '2022-06-27 13:56:06.167116', '2022-06-27 13:56:06.167116', 'user-filled', '用户管理', 5, 0, 'userManage', NULL, NULL, 1, 0, 0, 1, NULL, NULL),('25735adb-d051-4b7b-bbb7-1154526f3e4c', NULL, 'superadmin', NULL, '2022-07-30 21:34:32.844919', '2022-06-27 13:56:06.192188', 'user', '个人中心', 866, 0, 'personalCenter', NULL, NULL, 1, 0, 0, 1, NULL, NULL),('2e3438c8-3ddc-43ff-b8d8-cca328e4856e', NULL, 'superadmin', NULL, '2022-07-03 15:19:35.715872', '2022-06-27 13:56:06.165122', 'avatar', '管理员管理', 3, 0, 'adminManage', NULL, NULL, 1, 0, 0, 1, NULL, NULL),('2fe0ea32b3f447899f415c63ca27fdba', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', 'd2c03bd9-dad0-4262-88ca-c3681d224fc3', '2023-04-14 16:07:42.115232', '2023-04-14 16:07:29.737036', '', '合服信息', 6, 0, 'zoneMerge', NULL, NULL, 1, 1, 0, 1, '456b688c-8ad5-46de-bc2e-d41d8047bd42', '97877ebe22ef4eb9bf99782afd641e36'),('3e9b3f7c8775457a9a8c9807315a3ba5', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', 'd2c03bd9-dad0-4262-88ca-c3681d224fc3', '2023-02-15 17:32:29.781005', '2023-02-15 17:32:29.781029', '', 'Salt命令采集', 3, 0, 'saltCmdTable', NULL, NULL, 1, 1, 0, 1, '456b688c-8ad5-46de-bc2e-d41d8047bd42', '94a6b360dfa9416ca57c1a24069d3e17'),('4236eb70-1558-43a0-9cf2-037230c547f9', NULL, NULL, NULL, '2022-06-27 13:56:06.177090', '2022-06-27 13:56:06.177090', '', '部门管理', 1, 0, 'departmentManage', 'system/dept', 'dept', 1, 0, 0, 1, NULL, '54f769b0-3dff-416c-8102-e55ec44827cc'),('4ba07859-8b73-4524-a1a6-bbff36d98337', NULL, NULL, NULL, '2022-06-27 13:56:06.179629', '2022-06-27 13:56:06.179629', '', '操作日志', 1, 0, 'journalManage', 'system/log/operationLog', 'operationLog', 1, 0, 0, 1, NULL, 'c236fb6b-ddaa-4deb-b79b-16e42d9f347f'),('5037622249b64f0f8d334de9fea36d5a', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', 'd2c03bd9-dad0-4262-88ca-c3681d224fc3', '2023-02-19 18:25:20.964488', '2023-02-19 18:25:20.964515', '', 'Salt命令执行', 4, 0, 'saltExe', NULL, NULL, 1, 1, 0, 1, '456b688c-8ad5-46de-bc2e-d41d8047bd42', '94a6b360dfa9416ca57c1a24069d3e17'),('54f769b0-3dff-416c-8102-e55ec44827cc', NULL, 'superadmin', NULL, '2022-07-29 23:08:25.510853', '2022-06-27 13:56:06.190193', 'tools', '系统管理', 990, 0, '', NULL, NULL, 1, 0, 0, 1, NULL, NULL),('56c3f341-4f46-4b04-9cfc-c8a14701707e', NULL, NULL, NULL, '2022-06-27 13:56:06.181311', '2022-06-27 13:56:06.181311', '', '菜单管理', 2, 0, 'menuManage', 'system/menu', 'menu', 1, 0, 0, 1, NULL, '54f769b0-3dff-416c-8102-e55ec44827cc'),('718daec1b94b456c96d773889648173e', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL, '2022-07-13 21:07:49.624609', '2022-07-13 21:07:49.624609', '', '终端服务', 30, 0, 'terminal', NULL, NULL, 1, 1, 0, 1, '456b688c-8ad5-46de-bc2e-d41d8047bd42', '77edf447326b4e0dbc6f9719c1de8a12'),('77edf447326b4e0dbc6f9719c1de8a12', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL, '2022-07-29 23:09:12.270076', '2022-07-04 21:53:39.904375', 'TrendCharts', '系统监控', 888, 0, '', NULL, NULL, 1, 0, 0, 1, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL),('9065cb5445ac42ef93eb9e75e6287792', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL, '2022-07-03 15:21:19.325170', '2022-07-03 15:21:19.325170', 'DataLine', 'DashBoard', 1, 0, 'analysis', NULL, NULL, 1, 1, 0, 1, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL),('94a6b360dfa9416ca57c1a24069d3e17', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', 'd2c03bd9-dad0-4262-88ca-c3681d224fc3', '2023-02-08 17:01:11.390144', '2023-02-08 17:01:11.390171', '', 'SlatStack', 900, 0, '', NULL, NULL, 1, 0, 0, 1, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL),('97877ebe22ef4eb9bf99782afd641e36', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', 'd2c03bd9-dad0-4262-88ca-c3681d224fc3', '2023-02-22 17:52:18.587314', '2023-02-22 17:52:18.587334', '', '区服管理', 910, 0, '', NULL, NULL, 1, 1, 0, 1, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL),('a27b0ab29a3947eba29fe6bac63f6445', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', 'd2c03bd9-dad0-4262-88ca-c3681d224fc3', '2023-02-13 14:25:06.330754', '2023-02-13 14:25:06.330776', '', 'SaltKey', 2, 0, 'saltKey', NULL, NULL, 1, 1, 0, 1, '456b688c-8ad5-46de-bc2e-d41d8047bd42', '94a6b360dfa9416ca57c1a24069d3e17'),('a607e820-36e5-45c0-aabf-85a8e4e2c7ac', NULL, NULL, NULL, '2022-06-27 13:56:06.187402', '2022-06-27 13:56:06.187402', '', '权限管理', 4, 0, 'authorityManage', 'system/rolePermission', 'rolePermission', 1, 0, 0, 1, NULL, '54f769b0-3dff-416c-8102-e55ec44827cc'),('bcbeeee5c91a4e2ea2c2a31237e33616', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL, '2022-07-04 21:55:07.612049', '2022-07-04 21:54:47.113335', '', '服务监控', 10, 0, 'server', NULL, NULL, 1, 1, 0, 1, '456b688c-8ad5-46de-bc2e-d41d8047bd42', '77edf447326b4e0dbc6f9719c1de8a12'),('c236fb6b-ddaa-4deb-b79b-16e42d9f347f', NULL, NULL, NULL, '2022-06-27 13:56:06.194704', '2022-06-27 13:56:06.194704', 'info-filled', '日志管理', 999, 0, 'journalManage', NULL, NULL, 1, 0, 0, 1, NULL, NULL),('cdc20dc44a784c25a9b2a5281ae3ea88', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', 'd2c03bd9-dad0-4262-88ca-c3681d224fc3', '2023-04-12 10:25:07.569526', '2023-03-22 10:10:40.062028', '', '区服创建', 2, 0, 'createZone', NULL, NULL, 1, 1, 0, 1, '456b688c-8ad5-46de-bc2e-d41d8047bd42', '97877ebe22ef4eb9bf99782afd641e36'),('d4b2e512fcc14a24813b38ea03810fb9', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', 'd2c03bd9-dad0-4262-88ca-c3681d224fc3', '2023-03-08 10:09:58.439350', '2023-02-22 17:52:59.416332', '', '区服列表信息', 1, 0, 'zoneList', NULL, NULL, 1, 1, 0, 1, '456b688c-8ad5-46de-bc2e-d41d8047bd42', '97877ebe22ef4eb9bf99782afd641e36'),('d73f73a399af48cea6a8490ac508d7a0', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL, '2022-06-28 21:24:17.622516', '2022-06-28 21:23:46.339354', 'user-filled', '用户管理CRUD', 7, 0, 'userManageCrud', NULL, NULL, 1, 1, 0, 1, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL),('e0f53902-e901-490c-83f3-331e60b97fcf', NULL, NULL, NULL, '2022-06-27 13:56:06.183705', '2022-06-27 13:56:06.183705', '', '按钮配置', 2, 0, 'buttonConfig/:id/:name', 'system/ menuButton', NULL, 1, 0, 0, 0, NULL, '54f769b0-3dff-416c-8102-e55ec44827cc'),('f658596b969142148cd62905a9902f3f', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', 'd2c03bd9-dad0-4262-88ca-c3681d224fc3', '2023-04-12 10:25:58.539460', '2023-04-10 11:31:33.089475', '', '区服批量创建', 5, 0, 'batchCreateZones', NULL, NULL, 1, 1, 0, 1, '456b688c-8ad5-46de-bc2e-d41d8047bd42', '97877ebe22ef4eb9bf99782afd641e36');

#
# Structure for table "lyadmin_menu_button"
#

-- CREATE TABLE `lyadmin_menu_button` (
--   `id` varchar(100) NOT NULL COMMENT 'Id',
--   `description` varchar(100) DEFAULT NULL COMMENT '描述',
--   `modifier` varchar(100) DEFAULT NULL COMMENT '修改人',
--   `dept_belong_id` varchar(100) DEFAULT NULL COMMENT '数据归属部门',
--   `update_datetime` datetime(6) DEFAULT NULL COMMENT '修改时间',
--   `create_datetime` datetime(6) DEFAULT NULL COMMENT '创建时间',
--   `name` varchar(64) NOT NULL COMMENT '名称',
--   `value` varchar(64) NOT NULL COMMENT '权限值',
--   `api` varchar(64) NOT NULL COMMENT '接口地址',
--   `method` smallint(6) DEFAULT NULL COMMENT '接口请求方法',
--   `creator_id` varchar(100) DEFAULT NULL COMMENT '创建人',
--   `menu_id` varchar(100) NOT NULL COMMENT '关联菜单',
--   PRIMARY KEY (`id`),
--   KEY `lyadmin_menu_button_creator_id_e2b5a076` (`creator_id`),
--   KEY `lyadmin_menu_button_menu_id_74205633` (`menu_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='菜单权限表';

#
# Data for table "lyadmin_menu_button"
#

REPLACE INTO `lyadmin_menu_button` VALUES ('0209de89-6b9f-4d8a-84d3-ccfc3cc8b4da', NULL, NULL, NULL, '2022-06-27 13:56:06.201693', '2022-06-27 13:56:06.201693', '编辑', 'Update', '/api/system/button/{id}/', 2, NULL, '151035da-77a3-4a62-b474-fce6824571fb'),('0479d1d7996846bcb99dc3c1d8bbd248', NULL, NULL, NULL, '2023-02-15 17:32:29.852086', '2023-02-15 17:32:29.852092', '新增', 'Create', '', 0, NULL, '3e9b3f7c8775457a9a8c9807315a3ba5'),('04896a47-0f3a-4e2f-a111-bfe15f9e31c5', NULL, NULL, NULL, '2022-06-27 13:56:06.203687', '2022-06-27 13:56:06.203687', '编辑', 'Update', '/api/system/menu/{id}/', 2, NULL, '56c3f341-4f46-4b04-9cfc-c8a14701707e'),('05eef13f3a774ae28c915672e1ca4db4', NULL, NULL, NULL, '2023-02-15 17:32:29.852058', '2023-02-15 17:32:29.852064', '查询', 'Search', '', 0, NULL, '3e9b3f7c8775457a9a8c9807315a3ba5'),('0622ffa9cbd6441bbd1441977ce15ef1', NULL, NULL, NULL, '2023-04-10 11:31:33.387569', '2023-04-10 11:31:33.387584', '删除', 'Delete', '', 0, NULL, 'f658596b969142148cd62905a9902f3f'),('065da1fd170342dca040205359cdeca2', NULL, NULL, NULL, '2023-02-22 17:52:18.616104', '2023-02-22 17:52:18.616109', '新增', 'Create', '', 0, NULL, '97877ebe22ef4eb9bf99782afd641e36'),('09a0908dfb0c433c90037851da126e9b', NULL, NULL, NULL, '2022-06-28 21:23:46.377456', '2022-06-28 21:23:46.377456', '编辑', 'Update', '', 0, NULL, 'd73f73a399af48cea6a8490ac508d7a0'),('0b5bf0f1caac45beabf54fb5d930187b', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL, '2022-10-25 23:31:40.412955', '2022-10-25 23:31:40.412955', '日志', 'Logs', '/api/crontab/taskresult/', 0, '456b688c-8ad5-46de-bc2e-d41d8047bd42', '09a42810d4dd4b2eb939f8eb0b01d9d1'),('0ce04d99cbd249a9af88fe1496591a89', NULL, NULL, NULL, '2022-10-26 00:04:28.355226', '2022-07-04 20:52:44.985788', '禁用', 'Disable', '/api/crontab/periodictask/enabled/{id}/', 2, NULL, '09a42810d4dd4b2eb939f8eb0b01d9d1'),('0d931efc-2f80-418f-b4a0-5251f0a88f69', NULL, NULL, NULL, '2022-06-27 13:56:06.252411', '2022-06-27 13:56:06.252411', '新增', 'Create', '/api/system/operation_log/', 1, NULL, '4ba07859-8b73-4524-a1a6-bbff36d98337'),('10610c56-cec2-4774-9468-e1c763e59e70', NULL, NULL, NULL, '2022-06-27 13:56:06.253408', '2022-06-27 13:56:06.253408', '新增', 'Create', '/api/system/dept/', 1, NULL, '4236eb70-1558-43a0-9cf2-037230c547f9'),('140166e2-471e-455e-9dcd-05cebbbab95d', NULL, NULL, NULL, '2022-06-27 13:56:06.225629', '2022-06-27 13:56:06.225629', '查询', 'Search', '/api/system/role/', 0, NULL, '15c9ebc5-d12f-470a-a560-938a7dc57570'),('14e7088f-a39b-47ae-bd67-b9bbcabae96b', NULL, NULL, NULL, '2022-06-27 13:56:06.270827', '2022-06-27 13:56:06.270827', '单例', 'Retrieve', '/api/users/users/{id}/', 0, NULL, '244b28685cd14a39a383189981510d4a'),('19d01a929bc9414cac1a8defd48597c9', NULL, NULL, NULL, '2022-10-26 00:03:55.514029', '2022-07-04 20:52:45.061625', '新增', 'Create', '/api/crontab/periodictask/', 1, NULL, '09a42810d4dd4b2eb939f8eb0b01d9d1'),('1a0c96cf-09a6-43b4-b08a-0c5b6e2f7bb8', NULL, NULL, NULL, '2022-06-27 13:56:06.306497', '2022-06-27 13:56:06.306497', '保存', 'Save', '/api/system/permission/{id}/', 2, NULL, 'a607e820-36e5-45c0-aabf-85a8e4e2c7ac'),('1a16836d2cec4d14a1307b3228e3cfdd', NULL, NULL, NULL, '2022-10-26 00:03:39.767412', '2022-07-04 20:52:44.940088', '编辑', 'Update', '/api/crontab/periodictask/{id}/', 2, NULL, '09a42810d4dd4b2eb939f8eb0b01d9d1'),('1b4f27a7-8ab8-4388-ae57-46e29976cf0e', NULL, NULL, NULL, '2022-06-27 13:56:06.255493', '2022-06-27 13:56:06.255493', '新增', 'Create', '/api/system/button/', 1, NULL, '151035da-77a3-4a62-b474-fce6824571fb'),('1f4fa280f98944b99e6247688e76296c', NULL, NULL, NULL, '2023-04-14 16:07:29.985690', '2023-04-14 16:07:29.985713', '编辑', 'Update', '', 0, NULL, '2fe0ea32b3f447899f415c63ca27fdba'),('24d23db20ceb469bb634518a052c8e90', NULL, NULL, NULL, '2023-02-13 14:25:06.391765', '2023-02-13 14:25:06.391782', '删除', 'Delete', '', 0, NULL, 'a27b0ab29a3947eba29fe6bac63f6445'),('281ad1aad421441a965f7bc6b397eb30', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL, '2022-07-18 10:34:57.549325', '2022-07-18 10:34:57.549325', '删除', 'Delete', '/api/terminal/terminal/{id}/', 3, '456b688c-8ad5-46de-bc2e-d41d8047bd42', '718daec1b94b456c96d773889648173e'),('29b78499b1d7424e848e38a0d71ced0a', NULL, NULL, NULL, '2023-02-13 14:25:06.391634', '2023-02-13 14:25:06.391640', '新增', 'Create', '', 0, NULL, 'a27b0ab29a3947eba29fe6bac63f6445'),('2a3d4756-4d51-4129-b3c4-b2c7a00dbb8a', NULL, NULL, NULL, '2022-06-27 13:56:06.256490', '2022-06-27 13:56:06.257488', '新增', 'Create', '/api/system/role/', 1, NULL, '15c9ebc5-d12f-470a-a560-938a7dc57570'),('2c53efc8-e6a4-4192-8688-03baed0874a4', NULL, NULL, NULL, '2022-06-27 13:56:06.291460', '2022-06-27 13:56:06.291460', '删除', 'Delete', '/api/system/user/{id}/', 3, NULL, '2e3438c8-3ddc-43ff-b8d8-cca328e4856e'),('2ffdec251a614aa6b14bd89bb8f189e1', NULL, NULL, NULL, '2023-02-22 17:52:59.420404', '2023-02-22 17:52:59.420410', '单例', 'Retrieve', '', 0, NULL, 'd4b2e512fcc14a24813b38ea03810fb9'),
('308ecc71b04e47299ab2b8bd06e79b66', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL, '2023-05-17 10:49:31.035950', '2023-02-08 17:05:40.101711', '删除', 'Delete', '/api/saltstack/salt-key-opt/delete/', 1, NULL, '0a4c1fb43ce84d5290eede4bc1ff5c7b'),
('30b1e4ec1a02451799807ca6ae04c272', NULL, NULL, NULL, '2023-02-19 18:25:20.983287', '2023-02-19 18:25:20.983292', '单例', 'Retrieve', '', 0, NULL, '5037622249b64f0f8d334de9fea36d5a'),
('314020b785d945d6a46bdb132fd4fda2', NULL, NULL, NULL, '2023-02-19 18:25:20.983121', '2023-02-19 18:25:20.983145', '编辑', 'Update', '', 0, NULL, '5037622249b64f0f8d334de9fea36d5a'),
('324776a3-48ec-4bca-bdd9-1838e2b6f7cc', NULL, NULL, NULL, '2022-06-27 13:56:06.228619', '2022-06-27 13:56:06.228619', '查询', 'Search', '/api/system/user/', 0, NULL, '2e3438c8-3ddc-43ff-b8d8-cca328e4856e'),
('35336e0b7cf54addbb76d18d0e28d1ba', NULL, NULL, NULL, '2023-04-14 16:07:29.985742', '2023-04-14 16:07:29.985749', '查询', 'Search', '', 0, NULL, '2fe0ea32b3f447899f415c63ca27fdba'),
('353595a28cb1463b830cfbf79fea60b5', NULL, NULL, NULL, '2022-06-27 13:56:06.308464', '2022-06-27 13:56:06.308464', '禁用', 'Disable', '/api/users/users/disableuser/{id}/', 2, NULL, '244b28685cd14a39a383189981510d4a'),
('3688b715-4689-468f-bf3e-6f910259f837', NULL, NULL, NULL, '2022-06-27 13:56:06.230614', '2022-06-27 13:56:06.230614', '查询', 'Search', '/api/system/user/user_info/', 0, NULL, '25735adb-d051-4b7b-bbb7-1154526f3e4c'),
('372d75b2b1034a94b5ed561ca91b9d8c', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL, '2023-05-17 11:03:14.009110', '2023-02-08 17:05:40.101678', '更新minion', 'updateMinion', '/api/saltstack/salt-minion-opt/update/', 1, NULL, '0a4c1fb43ce84d5290eede4bc1ff5c7b'),
('37462e31-3cdf-4576-af10-5958f53b1bef', NULL, NULL, NULL, '2022-06-27 13:56:06.232609', '2022-06-27 13:56:06.232609', '查询', 'Search', '/api/system/operation_log/', 0, NULL, '4ba07859-8b73-4524-a1a6-bbff36d98337'),
('3b59a93455e24793a436a0f0a122c930', NULL, NULL, NULL, '2023-04-10 11:31:33.387350', '2023-04-10 11:31:33.387366', '查询', 'Search', '', 0, NULL, 'f658596b969142148cd62905a9902f3f'),
('3e11db64-b8e8-4558-963b-71d063a7db16', NULL, NULL, NULL, '2022-06-27 13:56:06.205682', '2022-06-27 13:56:06.205682', '编辑', 'Update', '/api/system/dept/{id}/', 2, NULL, '4236eb70-1558-43a0-9cf2-037230c547f9'),
('3fd6ae6c-fd76-4465-b2b6-db672f4bd79e', NULL, NULL, NULL, '2022-06-27 13:56:06.293448', '2022-06-27 13:56:06.293448', '删除', 'Delete', '/api/system/role/{id}/', 3, NULL, '15c9ebc5-d12f-470a-a560-938a7dc57570'),
('424d55c9e6794c75964107d38e5b5f01', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL, '2023-05-17 10:40:45.736306', '2023-02-08 17:05:40.101612', '查询', 'Search', '/api/saltstack/salt-minion', 0, NULL, '0a4c1fb43ce84d5290eede4bc1ff5c7b'),
('42ad6e05-7c84-444f-bcae-09de84f4988b', NULL, NULL, NULL, '2022-06-27 13:56:06.234604', '2022-06-27 13:56:06.234604', '查询', 'Search', '/api/system/menu/', 0, NULL, '56c3f341-4f46-4b04-9cfc-c8a14701707e'),
('43696212-ecba-4e66-8678-33c9bc935c76', NULL, NULL, NULL, '2022-06-27 13:56:06.236599', '2022-06-27 13:56:06.236599', '查询', 'Search', '/api/users/users/', 0, NULL, '244b28685cd14a39a383189981510d4a'),
('4450d80871eb44a1aaa4fbb5429885f0', NULL, NULL, NULL, '2022-10-26 00:03:48.087557', '2022-07-04 20:52:45.023288', '查询', 'Search', '/api/crontab/periodictask/', 0, NULL, '09a42810d4dd4b2eb939f8eb0b01d9d1'),
('44e11e66f8b44e2a818855f9c1d50eb5', NULL, NULL, NULL, '2023-04-14 16:07:29.985772', '2023-04-14 16:07:29.985778', '新增', 'Create', '', 0, NULL, '2fe0ea32b3f447899f415c63ca27fdba'),
('4fe4b7f5-0bc8-4375-9f39-747e06ec285a', NULL, NULL, NULL, '2022-06-27 13:56:06.294445', '2022-06-27 13:56:06.294445', '删除', 'Delete', '/api/system/menu_button/{id}/', 3, NULL, 'e0f53902-e901-490c-83f3-331e60b97fcf'),
('51085c21-2279-490f-8878-594f059f7616', NULL, NULL, NULL, '2022-06-27 13:56:06.296440', '2022-06-27 13:56:06.296440', '删除', 'Delete', '/api/system/button/{id}/', 3, NULL, '151035da-77a3-4a62-b474-fce6824571fb'),
('54aaf9074b28490a81b1a8cd7f5845a1', NULL, NULL, NULL, '2023-04-14 16:07:29.985801', '2023-04-14 16:07:29.985807', '单例', 'Retrieve', '', 0, NULL, '2fe0ea32b3f447899f415c63ca27fdba'),
('576008b6046f4afcb88d8139ff34e228', NULL, NULL, NULL, '2022-10-26 00:04:05.356416', '2022-07-04 20:52:45.137118', '删除', 'Delete', '/api/crontab/periodictask/{id}/', 3, NULL, '09a42810d4dd4b2eb939f8eb0b01d9d1'),
('58194fc4b80341f4bdc7233829523053', NULL, NULL, NULL, '2023-02-22 17:52:18.615989', '2023-02-22 17:52:18.616037', '编辑', 'Update', '', 0, NULL, '97877ebe22ef4eb9bf99782afd641e36'),
('5aac29b0-5a32-45fb-81c5-437b48f4a5df', NULL, NULL, NULL, '2022-06-27 13:56:06.239397', '2022-06-27 13:56:06.239397', '查询', 'Search', '/api/system/menu_button/', 0, NULL, 'e0f53902-e901-490c-83f3-331e60b97fcf'),
('5d48df3de9894d91ac1a6b2d19c538f2', NULL, NULL, NULL, '2023-02-19 18:25:20.983314', '2023-02-19 18:25:20.983319', '删除', 'Delete', '', 0, NULL, '5037622249b64f0f8d334de9fea36d5a'),
('5d77d14e-b199-481f-a97d-6e4c0e84fe71', NULL, NULL, NULL, '2022-06-27 13:56:06.207676', '2022-06-27 13:56:06.207676', '修改密码', 'Changepassword', '/api/system/user/change_password/{id}/', 2, NULL, '25735adb-d051-4b7b-bbb7-1154526f3e4c'),
('5fe5f73b5a1a493d856100bf71b47aa3', NULL, NULL, NULL, '2023-02-19 18:25:20.983227', '2023-02-19 18:25:20.983237', '查询', 'Search', '', 0, NULL, '5037622249b64f0f8d334de9fea36d5a'),
('6208f412-6bca-4d7b-a5a0-0103b7ba6091', NULL, NULL, NULL, '2022-06-27 13:56:06.272856', '2022-06-27 13:56:06.272856', '单例', 'Retrieve', '/api/system/button/{id}/', 0, NULL, '151035da-77a3-4a62-b474-fce6824571fb'),
('62e89e16b7cf460fbbbb949771156946', NULL, NULL, NULL, '2022-06-28 21:23:46.499751', '2022-06-28 21:23:46.499751', '单例', 'Retrieve', '', 0, NULL, 'd73f73a399af48cea6a8490ac508d7a0'),
('6300774a-d19c-43ad-8102-d7bf341eff33', NULL, NULL, NULL, '2022-06-27 13:56:06.274561', '2022-06-27 13:56:06.274561', '单例', 'Retrieve', '/api/system/dept/{id}/', 0, NULL, '4236eb70-1558-43a0-9cf2-037230c547f9'),
('646e9790-24f5-4606-abc4-0b5eede12f66', NULL, NULL, NULL, '2022-06-27 13:56:06.241497', '2022-06-27 13:56:06.241497', '查询', 'Search', '/api/system/dept/', 0, NULL, '4236eb70-1558-43a0-9cf2-037230c547f9'),
('699dfbe44de94f81a55580208b91240e', NULL, NULL, NULL, '2023-04-10 11:31:33.387224', '2023-04-10 11:31:33.387274', '编辑', 'Update', '', 0, NULL, 'f658596b969142148cd62905a9902f3f'),
('6af0929440a345238c28ee9b1fe341ba', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL, '2022-07-18 10:33:53.037646', '2022-07-16 21:41:09.432762', '终端', 'Terminal', '/ws/webssh/', 5, '456b688c-8ad5-46de-bc2e-d41d8047bd42', '718daec1b94b456c96d773889648173e'),
('6d6b6689d1224900b09c8101b3344f42', NULL, NULL, NULL, '2022-06-27 13:56:06.285840', '2022-06-27 13:56:06.285840', '单例', 'Retrieve', '/api/system/role_id_to_menu/{id}/', 0, NULL, 'a607e820-36e5-45c0-aabf-85a8e4e2c7ac'),
('6e27757847c64e228934b60ae81baedf', NULL, NULL, NULL, '2022-10-26 00:04:00.698622', '2022-07-04 20:52:45.097918', '单例', 'Retrieve', '/api/crontab/periodictask/{id}/', 0, NULL, '09a42810d4dd4b2eb939f8eb0b01d9d1'),
('6fa2dd66599745408afffae694793a3b', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL, '2023-05-17 10:56:05.362608', '2023-02-08 17:05:40.101646', '更新minion列表', 'updateMinionList', '/api/saltstack/salt-minion/', 1, NULL, '0a4c1fb43ce84d5290eede4bc1ff5c7b'),
('78fa92ce55d74432bd85182430776c2c', NULL, NULL, NULL, '2023-03-22 10:10:40.193735', '2023-03-22 10:10:40.193742', '删除', 'Delete', '', 0, NULL, 'cdc20dc44a784c25a9b2a5281ae3ea88'),
('7a86f718071947549c95fd5632bd9757', NULL, NULL, NULL, '2023-02-13 14:25:06.391605', '2023-02-13 14:25:06.391611', '查询', 'Search', '', 0, NULL, 'a27b0ab29a3947eba29fe6bac63f6445'),
('7e4b574dab234cecab982cf7c04597c7', NULL, NULL, NULL, '2023-02-22 17:52:59.420376', '2023-02-22 17:52:59.420382', '新增', 'Create', '', 0, NULL, 'd4b2e512fcc14a24813b38ea03810fb9'),
('80c8eb6939a245e9890dede241b5d1d6', NULL, NULL, NULL, '2022-06-28 21:23:46.410518', '2022-06-28 21:23:46.410518', '禁用', 'Disable', '', 0, NULL, 'd73f73a399af48cea6a8490ac508d7a0'),
('873138b279274536bc93c2774b1be815', NULL, NULL, NULL, '2022-06-28 21:23:46.440593', '2022-06-28 21:23:46.440593', '查询', 'Search', '', 0, NULL, 'd73f73a399af48cea6a8490ac508d7a0'),
('875bdfeb-0c34-441d-8ee3-bb93c21e17dd', NULL, NULL, NULL, '2022-06-27 13:56:06.209670', '2022-06-27 13:56:06.209670', '编辑', 'Update', '/api/users/users/{id}/', 2, NULL, '244b28685cd14a39a383189981510d4a'),
('88cf3a3ab1a440208e7fbd24cc20d3f5', NULL, NULL, NULL, '2023-02-13 14:25:06.391716', '2023-02-13 14:25:06.391726', '单例', 'Retrieve', '', 0, NULL, 'a27b0ab29a3947eba29fe6bac63f6445'),
('8ae924bd-576c-4ae1-92eb-b0a98148baae', NULL, NULL, NULL, '2022-06-27 13:56:06.297757', '2022-06-27 13:56:06.298756', '删除', 'Delete', '/api/system/menu/{id}/', 3, NULL, '56c3f341-4f46-4b04-9cfc-c8a14701707e'),
('8b7a0e79-a6ef-4946-87c6-8c042b887e1c', NULL, NULL, NULL, '2022-06-27 13:56:06.275558', '2022-06-27 13:56:06.275558', '单例', 'Retrieve', '/api/system/operation_log/{id}/', 0, NULL, '4ba07859-8b73-4524-a1a6-bbff36d98337'),
('8d65733d401c40f8b27cc6bcfed78bc3', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL, '2022-07-18 10:34:34.257924', '2022-07-18 10:34:34.257924', '新增', 'Create', '/api/terminal/terminal/', 1, '456b688c-8ad5-46de-bc2e-d41d8047bd42', '718daec1b94b456c96d773889648173e'),
('9221171bb2174bf1b273407c899e5f24', NULL, NULL, NULL, '2023-04-14 16:07:29.985830', '2023-04-14 16:07:29.985836', '删除', 'Delete', '', 0, NULL, '2fe0ea32b3f447899f415c63ca27fdba'),
('9410978e41b94c85953f377d6573eee5', NULL, NULL, NULL, '2023-02-22 17:52:59.420298', '2023-02-22 17:52:59.420320', '编辑', 'Update', '', 0, NULL, 'd4b2e512fcc14a24813b38ea03810fb9'),
('96022ae5-6425-47b9-8f89-01edc33eb2b7', NULL, NULL, NULL, '2022-06-27 13:56:06.277792', '2022-06-27 13:56:06.277792', '单例', 'Retrieve', '/api/system/role/{id}/', 0, NULL, '15c9ebc5-d12f-470a-a560-938a7dc57570'),
('9c02433b23e54ded987ad5f443bb75dd', NULL, NULL, NULL, '2023-02-15 17:32:29.852002', '2023-02-15 17:32:29.852029', '编辑', 'Update', '', 0, NULL, '3e9b3f7c8775457a9a8c9807315a3ba5'),
('9e6b2376-1ab0-4966-8d5d-4ad4f911d13c', NULL, NULL, NULL, '2022-06-27 13:56:06.258457', '2022-06-27 13:56:06.258457', '新增', 'Create', '/api/system/user/', 1, NULL, '2e3438c8-3ddc-43ff-b8d8-cca328e4856e'),
('9fc8436a-1996-478f-a155-5de7939a54dc', NULL, NULL, NULL, '2022-06-27 13:56:06.260903', '2022-06-27 13:56:06.260903', '新增', 'Create', '/api/users/users/', 1, NULL, '244b28685cd14a39a383189981510d4a'),
('a02b00e7cb4b4950bac7290ac2f9a24c', NULL, NULL, NULL, '2023-02-22 17:52:59.420347', '2023-02-22 17:52:59.420353', '查询', 'Search', '', 0, NULL, 'd4b2e512fcc14a24813b38ea03810fb9'),
('a0bdd1b1475448dcbe613d6a5e78659a', NULL, NULL, NULL, '2023-03-22 10:10:40.193387', '2023-03-22 10:10:40.193392', '新增', 'Create', '', 0, NULL, 'cdc20dc44a784c25a9b2a5281ae3ea88'),
('a2df144069a44af8afbd5863740e2228', NULL, NULL, NULL, '2022-06-28 21:23:46.469675', '2022-06-28 21:23:46.469675', '新增', 'Create', '', 0, NULL, 'd73f73a399af48cea6a8490ac508d7a0'),
('a69fb746c0aa4bd0b31b1480c9e4dcc0', NULL, 'superadmin', NULL, '2022-07-10 11:36:13.663585', '2022-07-04 21:54:47.257805', '查询', 'Search', '/api/monitor/getsysteminfo/', 0, NULL, 'bcbeeee5c91a4e2ea2c2a31237e33616'),
('a8b803934ae345e4816cdf4d55077b48', NULL, NULL, NULL, '2023-02-13 14:25:06.391546', '2023-02-13 14:25:06.391576', '编辑', 'Update', '', 0, NULL, 'a27b0ab29a3947eba29fe6bac63f6445'),
('abe5c07f-0cab-4053-ac24-e782792e9d7f', NULL, NULL, NULL, '2022-06-27 13:56:06.262849', '2022-06-27 13:56:06.262849', '新增', 'Create', '/api/system/menu/', 1, NULL, '56c3f341-4f46-4b04-9cfc-c8a14701707e'),
('acfde861-1872-47e2-a1f1-abeda5175b7f', NULL, NULL, NULL, '2022-06-27 13:56:06.299753', '2022-06-27 13:56:06.299753', '删除', 'Delete', '/api/system/operation_log/{id}/', 3, NULL, '4ba07859-8b73-4524-a1a6-bbff36d98337'),
('ad50bbdcebac48419f49455b9404f15c', NULL, NULL, NULL, '2023-04-10 11:31:33.387425', '2023-04-10 11:31:33.387439', '新增', 'Create', '', 0, NULL, 'f658596b969142148cd62905a9902f3f'),
('add14c5bb1bd4f7db7a86a44d3338595', NULL, NULL, NULL, '2023-03-22 10:10:40.193356', '2023-03-22 10:10:40.193363', '查询', 'Search', '', 0, NULL, 'cdc20dc44a784c25a9b2a5281ae3ea88'),
('af4fb9fcb28a45ad96e2345df65403c8', NULL, NULL, NULL, '2023-02-15 17:32:29.852140', '2023-02-15 17:32:29.852146', '删除', 'Delete', '', 0, NULL, '3e9b3f7c8775457a9a8c9807315a3ba5'),
('af587108b73244e3b2bf9e81d29ddc78', NULL, NULL, NULL, '2023-02-22 17:52:59.420431', '2023-02-22 17:52:59.420437', '删除', 'Delete', '', 0, NULL, 'd4b2e512fcc14a24813b38ea03810fb9'),
('af60d628-73b1-4c5d-b34e-7c70ab9bd87e', NULL, NULL, NULL, '2022-06-27 13:56:06.243491', '2022-06-27 13:56:06.243491', '查询', 'Search', '/api/system/button/', 0, NULL, '151035da-77a3-4a62-b474-fce6824571fb'),
('b10f7d08-2592-4b54-8557-b5ca864a029a', NULL, NULL, NULL, '2022-06-27 13:56:06.301748', '2022-06-27 13:56:06.301748', '删除', 'Delete', '/api/system/dept/{id}/', 3, NULL, '4236eb70-1558-43a0-9cf2-037230c547f9'),
('b4cbe8ed35a04155b14c7809fad6b2ef', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL, '2022-07-18 10:35:09.558179', '2022-07-18 10:35:09.558179', '编辑', 'Update', '/api/terminal/terminal/{id}/', 2, '456b688c-8ad5-46de-bc2e-d41d8047bd42', '718daec1b94b456c96d773889648173e'),
('b5f3086590354666acb8127a0fa9ae02', NULL, NULL, NULL, '2023-02-19 18:25:20.983261', '2023-02-19 18:25:20.983266', '新增', 'Create', '', 0, NULL, '5037622249b64f0f8d334de9fea36d5a'),
('bb7de9ee-5fd1-46f5-9849-088c522f49c7', NULL, NULL, NULL, '2022-06-27 13:56:06.303743', '2022-06-27 13:56:06.303743', '删除', 'Delete', '/api/users/users/{id}/', 3, NULL, '244b28685cd14a39a383189981510d4a'),
('bc114580-e62d-4e08-b707-843759817344', NULL, NULL, NULL, '2022-06-27 13:56:06.211665', '2022-06-27 13:56:06.211665', '编辑', 'Update', '/api/system/user/{id}/', 2, NULL, '2e3438c8-3ddc-43ff-b8d8-cca328e4856e'),
('bc6104a0-f487-4dfd-a368-fb587d6d57d8', NULL, NULL, NULL, '2022-06-27 13:56:06.213660', '2022-06-27 13:56:06.213660', '编辑', 'Update', '/api/system/menu_button/{id}/', 2, NULL, 'e0f53902-e901-490c-83f3-331e60b97fcf'),
('be860f07c5be4114a6ea0ceefb97a22a', NULL, NULL, NULL, '2022-06-28 21:23:46.527856', '2022-06-28 21:23:46.527856', '删除', 'Delete', '', 0, NULL, 'd73f73a399af48cea6a8490ac508d7a0'),
('c2490dfba1644cae8f8ff85e2d6f1d3d', NULL, NULL, NULL, '2022-07-03 15:21:19.444049', '2022-07-03 15:21:19.444049', '查询', 'Search', '', 0, NULL, '9065cb5445ac42ef93eb9e75e6287792'),
('c56fde9542334fa6aa2d060ceea9c056', NULL, NULL, NULL, '2023-02-22 17:52:18.616132', '2023-02-22 17:52:18.616138', '单例', 'Retrieve', '', 0, NULL, '97877ebe22ef4eb9bf99782afd641e36'),
('ca51e4aa2405440f88202d3b06ad490d', NULL, NULL, NULL, '2023-03-22 10:10:40.193251', '2023-03-22 10:10:40.193320', '编辑', 'Update', '', 0, NULL, 'cdc20dc44a784c25a9b2a5281ae3ea88'),
('d22c0176-96e0-48b3-b81e-13443f306af5', NULL, NULL, NULL, '2022-06-27 13:56:06.214657', '2022-06-27 13:56:06.214657', '编辑', 'Update', '/api/system/role/{id}/', 2, NULL, '15c9ebc5-d12f-470a-a560-938a7dc57570'),
('d4c0a2f22ac74fba99151e60de00e40d', NULL, NULL, NULL, '2023-02-15 17:32:29.852113', '2023-02-15 17:32:29.852119', '单例', 'Retrieve', '', 0, NULL, '3e9b3f7c8775457a9a8c9807315a3ba5'),
('dcc58831-08d1-4469-8b01-fca71e0f497f', NULL, NULL, NULL, '2022-06-27 13:56:06.216652', '2022-06-27 13:56:06.216652', '编辑', 'Update', '/api/system/user/user_info/', 2, NULL, '25735adb-d051-4b7b-bbb7-1154526f3e4c'),
('e040c9277a3c492f9f128ce440f2353e', NULL, NULL, NULL, '2023-02-22 17:52:18.616160', '2023-02-22 17:52:18.616166', '删除', 'Delete', '', 0, NULL, '97877ebe22ef4eb9bf99782afd641e36'),
('e1ddf86666364a39be76c963c277b009', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL, '2022-07-18 10:34:25.828153', '2022-07-18 10:34:25.828153', '查询', 'Search', '/api/terminal/terminal/', 0, '456b688c-8ad5-46de-bc2e-d41d8047bd42', '718daec1b94b456c96d773889648173e'),
('e621259de309449cbaff5b8426271739', NULL, NULL, NULL, '2023-02-22 17:52:18.616073', '2023-02-22 17:52:18.616080', '查询', 'Search', '', 0, NULL, '97877ebe22ef4eb9bf99782afd641e36'),
('e6b93920-2236-46ec-841b-cff6f63ce788', NULL, NULL, NULL, '2022-06-27 13:56:06.218647', '2022-06-27 13:56:06.218647', '编辑', 'Update', '/api/system/operation_log/{id}/', 2, NULL, '4ba07859-8b73-4524-a1a6-bbff36d98337'),
('ea18bb51400b482a8aad5dc18357bcab', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL, '2022-07-18 10:34:48.832019', '2022-07-18 10:34:48.832019', '单例', 'Retrieve', '/api/terminal/terminal/{id}/', 0, '456b688c-8ad5-46de-bc2e-d41d8047bd42', '718daec1b94b456c96d773889648173e'),
('ea846604f61d45cfbf91f3bf337b43db', NULL, NULL, NULL, '2023-04-10 11:31:33.387497', '2023-04-10 11:31:33.387511', '单例', 'Retrieve', '', 0, NULL, 'f658596b969142148cd62905a9902f3f'),
('ed0d2d6949b24aa490f06c1f044605f5', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL, '2023-05-17 11:03:48.891402', '2023-02-08 17:05:40.101573', '更新minion状态', 'updateMinionStatus', '/api/saltstack/salt-minion-opt/status-update/', 1, NULL, '0a4c1fb43ce84d5290eede4bc1ff5c7b'),
('ee289cc5793c44b899f357e2dc3124f2', NULL, NULL, NULL, '2023-03-22 10:10:40.193415', '2023-03-22 10:10:40.193688', '单例', 'Retrieve', '', 0, NULL, 'cdc20dc44a784c25a9b2a5281ae3ea88'),
('f0e080c0-275d-4085-b56c-735b49510eff', NULL, NULL, NULL, '2022-06-27 13:56:06.279787', '2022-06-27 13:56:06.279787', '单例', 'Retrieve', '/api/system/user/{id}/', 0, NULL, '2e3438c8-3ddc-43ff-b8d8-cca328e4856e'),
('f19826f7df9842089cee94a795681b2e', NULL, NULL, NULL, '2022-07-03 15:21:19.526449', '2022-07-03 15:21:19.526449', '单例', 'Retrieve', '', 0, NULL, '9065cb5445ac42ef93eb9e75e6287792'),
('fa8d945124b74379aba32bcf34ea5383', NULL, '456b688c-8ad5-46de-bc2e-d41d8047bd42', NULL, '2022-10-26 00:06:00.943849', '2022-10-26 00:06:00.943849', '任务列表', 'Tasklist', '/api/crontab/periodictask/tasklist/', 0, '456b688c-8ad5-46de-bc2e-d41d8047bd42', '09a42810d4dd4b2eb939f8eb0b01d9d1'),
('fc71b446-fde1-439f-ab41-c38f30230caa', NULL, NULL, NULL, '2022-06-27 13:56:06.263846', '2022-06-27 13:56:06.263846', '新增', 'Create', '/api/system/menu_button/', 1, NULL, 'e0f53902-e901-490c-83f3-331e60b97fcf'),
('fcbe4cec-cc2d-436d-92ba-023f8c9ad31c', NULL, NULL, NULL, '2022-06-27 13:56:06.280734', '2022-06-27 13:56:06.280734', '单例', 'Retrieve', '/api/system/menu/{id}/', 0, NULL, '56c3f341-4f46-4b04-9cfc-c8a14701707e'),
('fe96f32c-6124-4b24-b809-4964186f5163', NULL, NULL, NULL, '2022-06-27 13:56:06.283356', '2022-06-27 13:56:06.283356', '单例', 'Retrieve', '/api/system/menu_button/{id}/', 0, NULL, 'e0f53902-e901-490c-83f3-331e60b97fcf');

#
# Structure for table "lyadmin_operation_log"
#

-- CREATE TABLE `lyadmin_operation_log` (
--   `id` varchar(100) NOT NULL COMMENT 'Id',
--   `description` varchar(100) DEFAULT NULL COMMENT '描述',
--   `modifier` varchar(100) DEFAULT NULL COMMENT '修改人',
--   `dept_belong_id` varchar(100) DEFAULT NULL COMMENT '数据归属部门',
--   `update_datetime` datetime(6) DEFAULT NULL COMMENT '修改时间',
--   `create_datetime` datetime(6) DEFAULT NULL COMMENT '创建时间',
--   `request_modular` varchar(64) DEFAULT NULL COMMENT '请求模块',
--   `request_path` longtext COMMENT '请求地址',
--   `request_body` longtext COMMENT '请求参数',
--   `request_method` varchar(8) DEFAULT NULL COMMENT '请求方式',
--   `request_msg` longtext COMMENT '操作说明',
--   `request_ip` varchar(32) DEFAULT NULL COMMENT '请求ip地址',
--   `request_browser` varchar(64) DEFAULT NULL COMMENT '请求浏览器',
--   `response_code` varchar(32) DEFAULT NULL COMMENT '响应状态码',
--   `request_os` varchar(64) DEFAULT NULL COMMENT '操作系统',
--   `json_result` longtext COMMENT '返回信息',
--   `status` tinyint(1) NOT NULL COMMENT '响应状态',
--   `creator_id` varchar(100) DEFAULT NULL COMMENT '创建人',
--   PRIMARY KEY (`id`),
--   KEY `lyadmin_operation_log_creator_id_7b08f4e1` (`creator_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='操作日志';

#
# Data for table "lyadmin_operation_log"
#

REPLACE INTO `lyadmin_operation_log` VALUES ('3287a6052fb84ce3b8eeb8ef578c9a1a',NULL,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-12-26 14:48:02.996024','2022-12-26 14:48:02.996024','操作日志','/api/system/operation_log/deletealllogs/','{}','DELETE',NULL,'127.0.0.1','Chrome 107.0.0','2000','Windows 10','{\'code\': 2000, \'msg\': \'清空成功\'}',1,'456b688c-8ad5-46de-bc2e-d41d8047bd42');

#
# Structure for table "lyadmin_post"
#

-- CREATE TABLE `lyadmin_post` (
--   `id` varchar(100) NOT NULL COMMENT 'Id',
--   `description` varchar(100) DEFAULT NULL COMMENT '描述',
--   `modifier` varchar(100) DEFAULT NULL COMMENT '修改人',
--   `dept_belong_id` varchar(100) DEFAULT NULL COMMENT '数据归属部门',
--   `update_datetime` datetime(6) DEFAULT NULL COMMENT '修改时间',
--   `create_datetime` datetime(6) DEFAULT NULL COMMENT '创建时间',
--   `name` varchar(64) NOT NULL COMMENT '岗位名称',
--   `code` varchar(32) NOT NULL COMMENT '岗位编码',
--   `sort` int(11) NOT NULL COMMENT '岗位顺序',
--   `status` int(11) NOT NULL COMMENT '岗位状态',
--   `creator_id` varchar(100) DEFAULT NULL COMMENT '创建人',
--   PRIMARY KEY (`id`),
--   KEY `lyadmin_post_creator_id_15f90961` (`creator_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='岗位表';

#
# Data for table "lyadmin_post"
#


#
# Structure for table "lyadmin_role"
#

-- CREATE TABLE `lyadmin_role` (
--   `id` varchar(100) NOT NULL COMMENT 'Id',
--   `description` varchar(100) DEFAULT NULL COMMENT '描述',
--   `modifier` varchar(100) DEFAULT NULL COMMENT '修改人',
--   `dept_belong_id` varchar(100) DEFAULT NULL COMMENT '数据归属部门',
--   `update_datetime` datetime(6) DEFAULT NULL COMMENT '修改时间',
--   `create_datetime` datetime(6) DEFAULT NULL COMMENT '创建时间',
--   `name` varchar(64) NOT NULL COMMENT '角色名称',
--   `key` varchar(64) NOT NULL COMMENT '权限字符',
--   `sort` int(11) NOT NULL COMMENT '角色顺序',
--   `status` smallint(6) NOT NULL COMMENT '角色状态',
--   `admin` smallint(6) NOT NULL COMMENT '是否为admin',
--   `data_range` smallint(6) NOT NULL COMMENT '数据权限范围',
--   `remark` longtext COMMENT '备注',
--   `creator_id` varchar(100) DEFAULT NULL COMMENT '创建人',
--   PRIMARY KEY (`id`),
--   KEY `lyadmin_role_creator_id_858b8a61` (`creator_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色表';

#
# Data for table "lyadmin_role"
#

REPLACE INTO `lyadmin_role` VALUES ('35b58d98-b506-4f93-be79-ed1e109da071',NULL,NULL,NULL,'2022-06-27 13:56:06.322600','2022-06-27 13:56:06.322600','普通用户','public',2,1,0,4,NULL,NULL),('36001d1a-1b3e-4413-bdfe-b3bc04375f46',NULL,'456b688c-8ad5-46de-bc2e-d41d8047bd42',NULL,'2022-11-16 10:54:57.379692','2022-06-27 13:56:06.311456','管理员','admin',1,1,1,3,NULL,NULL);

#
# Structure for table "lyadmin_role_dept"
#

-- CREATE TABLE `lyadmin_role_dept` (
--   `id` bigint(20) NOT NULL AUTO_INCREMENT,
--   `role_id` varchar(100) NOT NULL,
--   `dept_id` varchar(100) NOT NULL,
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `lyadmin_role_dept_role_id_dept_id_75a8409d_uniq` (`role_id`,`dept_id`),
--   KEY `lyadmin_role_dept_role_id_bf2e0106` (`role_id`),
--   KEY `lyadmin_role_dept_dept_id_4efa5a2b` (`dept_id`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

#
# Data for table "lyadmin_role_dept"
#

REPLACE INTO `lyadmin_role_dept` VALUES (1,'35b58d98-b506-4f93-be79-ed1e109da071','fd8230ca-67bd-4347-8a9b-57eb19be5d9e'),(2,'35b58d98-b506-4f93-be79-ed1e109da071','d2c03bd9-dad0-4262-88ca-c3681d224fc3');

#
# Structure for table "lyadmin_role_menu"
#

-- CREATE TABLE `lyadmin_role_menu` (
--   `id` bigint(20) NOT NULL AUTO_INCREMENT,
--   `role_id` varchar(100) NOT NULL,
--   `menu_id` varchar(100) NOT NULL,
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `lyadmin_role_menu_role_id_menu_id_ee3d26d9_uniq` (`role_id`,`menu_id`),
--   KEY `lyadmin_role_menu_role_id_68ec079a` (`role_id`),
--   KEY `lyadmin_role_menu_menu_id_27af6f62` (`menu_id`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4;

#
# Data for table "lyadmin_role_menu"
#

REPLACE INTO `lyadmin_role_menu` VALUES (1,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','2e3438c8-3ddc-43ff-b8d8-cca328e4856e'),(2,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','c236fb6b-ddaa-4deb-b79b-16e42d9f347f'),(3,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','4ba07859-8b73-4524-a1a6-bbff36d98337'),(4,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','3171db16eda048ae92b16536fc1241b6'),(5,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','80a340eae92b430abe17635468c2df1d'),(6,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','15c9ebc5-d12f-470a-a560-938a7dc57570'),(7,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','ae5629946df4497cbec10419e8375dd9'),(8,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','25735adb-d051-4b7b-bbb7-1154526f3e4c'),(9,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','151035da-77a3-4a62-b474-fce6824571fb'),(10,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','e0f53902-e901-490c-83f3-331e60b97fcf'),(11,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','56c3f341-4f46-4b04-9cfc-c8a14701707e'),(12,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','a607e820-36e5-45c0-aabf-85a8e4e2c7ac'),(13,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','54f769b0-3dff-416c-8102-e55ec44827cc'),(14,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','d4e2fe169a8b40f3846421ac04e4fccb'),(15,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','4236eb70-1558-43a0-9cf2-037230c547f9'),(16,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','244b28685cd14a39a383189981510d4a'),(17,'35b58d98-b506-4f93-be79-ed1e109da071','15c9ebc5-d12f-470a-a560-938a7dc57570'),(18,'35b58d98-b506-4f93-be79-ed1e109da071','56c3f341-4f46-4b04-9cfc-c8a14701707e'),(19,'35b58d98-b506-4f93-be79-ed1e109da071','54f769b0-3dff-416c-8102-e55ec44827cc'),(20,'35b58d98-b506-4f93-be79-ed1e109da071','4236eb70-1558-43a0-9cf2-037230c547f9'),(21,'35b58d98-b506-4f93-be79-ed1e109da071','244b28685cd14a39a383189981510d4a'),(22,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','d73f73a399af48cea6a8490ac508d7a0'),(23,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','9065cb5445ac42ef93eb9e75e6287792'),(24,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','bcbeeee5c91a4e2ea2c2a31237e33616'),(25,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','77edf447326b4e0dbc6f9719c1de8a12'),(26,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','718daec1b94b456c96d773889648173e'),(27,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','02c24003527546359b5a77ae07adc7d5'),(28,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','b999c50996864465b851575e378c5aea'),(29,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','2e07b715d5e24e2ca45997527430e9d3'),(30,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','dc8c173b425048e7a8c9b59513596c7f'),(31,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','d470ab18859a4472b525e605ae96c325'),(32,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','3c13161f70f1469a913d539e7616c577'),(33,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','a28f8ca682d04c8fb2953fdeb3d9e2e6'),(34,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','2a7c0142f7514dacb7999383e4e67aca'),(35,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','a524f17e9ac74be3baf9d113f014184c'),(36,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','09a42810d4dd4b2eb939f8eb0b01d9d1'),(37,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','49160b589f004e44b3920c82583c2581');

#
# Structure for table "lyadmin_role_permission"
#

-- CREATE TABLE `lyadmin_role_permission` (
--   `id` bigint(20) NOT NULL AUTO_INCREMENT,
--   `role_id` varchar(100) NOT NULL,
--   `menubutton_id` varchar(100) NOT NULL,
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `lyadmin_role_permission_role_id_menubutton_id_dfd195d1_uniq` (`role_id`,`menubutton_id`),
--   KEY `lyadmin_role_permission_role_id_610a95e1` (`role_id`),
--   KEY `lyadmin_role_permission_menubutton_id_539eb394` (`menubutton_id`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4;

#
# Data for table "lyadmin_role_permission"
#

REPLACE INTO `lyadmin_role_permission` VALUES (1,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','646e9790-24f5-4606-abc4-0b5eede12f66'),(2,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','51085c21-2279-490f-8878-594f059f7616'),(3,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','1b4f27a7-8ab8-4388-ae57-46e29976cf0e'),(4,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','f0e080c0-275d-4085-b56c-735b49510eff'),(5,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','bc6104a0-f487-4dfd-a368-fb587d6d57d8'),(6,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','14e7088f-a39b-47ae-bd67-b9bbcabae96b'),(7,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','2c53efc8-e6a4-4192-8688-03baed0874a4'),(8,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','8ae924bd-576c-4ae1-92eb-b0a98148baae'),(9,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','324776a3-48ec-4bca-bdd9-1838e2b6f7cc'),(10,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','353595a28cb1463b830cfbf79fea60b5'),(11,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','d1b3c15f0c664857aeca1d9065d9c499'),(12,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','e6b93920-2236-46ec-841b-cff6f63ce788'),(13,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','bb7de9ee-5fd1-46f5-9849-088c522f49c7'),(14,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','e7fa30290d37447585ea7583d9d01f1b'),(15,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','04896a47-0f3a-4e2f-a111-bfe15f9e31c5'),(16,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','77096cd56a6441699345e6e4f22d0ec3'),(17,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','43696212-ecba-4e66-8678-33c9bc935c76'),(18,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','80efc041695a42e4a9a04c010c6c7004'),(19,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','59db5099a03f44c8adb883faa340c15a'),(20,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','5d77d14e-b199-481f-a97d-6e4c0e84fe71'),(21,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','d22c0176-96e0-48b3-b81e-13443f306af5'),(22,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','3688b715-4689-468f-bf3e-6f910259f837'),(23,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','fcbe4cec-cc2d-436d-92ba-023f8c9ad31c'),(24,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','4fe4b7f5-0bc8-4375-9f39-747e06ec285a'),(25,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','dcc58831-08d1-4469-8b01-fca71e0f497f'),(26,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','0d931efc-2f80-418f-b4a0-5251f0a88f69'),(27,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','6d6b6689d1224900b09c8101b3344f42'),(28,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','6208f412-6bca-4d7b-a5a0-0103b7ba6091'),(29,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','7aef1da4647844e3944a2745cef1bc6d'),(30,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','6300774a-d19c-43ad-8102-d7bf341eff33'),(31,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','6e4251a948f348ccaa419a777a118048'),(32,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','fc71b446-fde1-439f-ab41-c38f30230caa'),(33,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','b10f7d08-2592-4b54-8557-b5ca864a029a'),(34,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','abe5c07f-0cab-4053-ac24-e782792e9d7f'),(35,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','2a3d4756-4d51-4129-b3c4-b2c7a00dbb8a'),(36,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','fe96f32c-6124-4b24-b809-4964186f5163'),(37,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','1d4441fdc418499f856c23aa4e1be2c0'),(38,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','ca69833045ed4cf78c8586f7e55ba6db'),(39,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','5aac29b0-5a32-45fb-81c5-437b48f4a5df'),(40,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','bc114580-e62d-4e08-b707-843759817344'),(41,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','9fc8436a-1996-478f-a155-5de7939a54dc'),(42,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','0088e172566f4ee388092ec2be3584ee'),(43,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','c8eee7f68c1845169b8d2af946502077'),(44,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','af60d628-73b1-4c5d-b34e-7c70ab9bd87e'),(45,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','140166e2-471e-455e-9dcd-05cebbbab95d'),(46,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','37462e31-3cdf-4576-af10-5958f53b1bef'),(47,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','42ad6e05-7c84-444f-bcae-09de84f4988b'),(48,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','d2e0608b5b4941ef8c3ff834977caeef'),(49,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','3fd6ae6c-fd76-4465-b2b6-db672f4bd79e'),(50,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','96022ae5-6425-47b9-8f89-01edc33eb2b7'),(51,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','6b88361b326a4e55a8a5135c08ba66f1'),(52,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','0209de89-6b9f-4d8a-84d3-ccfc3cc8b4da'),(54,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','10610c56-cec2-4774-9468-e1c763e59e70'),(55,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','a3088120763d49ad93498eb515c7c244'),(56,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','875bdfeb-0c34-441d-8ee3-bb93c21e17dd'),(57,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','3e11db64-b8e8-4558-963b-71d063a7db16'),(58,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','acfde861-1872-47e2-a1f1-abeda5175b7f'),(59,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','8b7a0e79-a6ef-4946-87c6-8c042b887e1c'),(60,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','264cc3d69f7a46d5a117997e9c78506c'),(61,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','9e6b2376-1ab0-4966-8d5d-4ad4f911d13c'),(62,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','62e89e16b7cf460fbbbb949771156946'),(63,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','a2df144069a44af8afbd5863740e2228'),(64,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','873138b279274536bc93c2774b1be815'),(65,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','80c8eb6939a245e9890dede241b5d1d6'),(66,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','f19826f7df9842089cee94a795681b2e'),(67,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','a69fb746c0aa4bd0b31b1480c9e4dcc0'),(68,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','c2490dfba1644cae8f8ff85e2d6f1d3d'),(70,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','6af0929440a345238c28ee9b1fe341ba'),(71,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','8d65733d401c40f8b27cc6bcfed78bc3'),(72,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','e1ddf86666364a39be76c963c277b009'),(73,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','b4cbe8ed35a04155b14c7809fad6b2ef'),(74,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','ea18bb51400b482a8aad5dc18357bcab'),(75,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','281ad1aad421441a965f7bc6b397eb30'),(76,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','be860f07c5be4114a6ea0ceefb97a22a'),(77,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','43a779c3e1634e84bb1a32c675b5f744'),(79,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','09a0908dfb0c433c90037851da126e9b'),(80,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','118ce77cc07140a08d9a92ab8800f2cf'),(81,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','989ad685ce654dd1b367f41dedfdd0b9'),(82,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','676e32850165441cad01782e453de925'),(83,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','6e9d454742f74437928959c02be42456'),(84,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','4b73b1669e49495f93de36d63cc2c0d8'),(85,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','ac302c9907b94ab59ac3c40975add57b'),(86,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','716480cd8ac645239405763834326f7e'),(87,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','3737d4afa1e2437b93e8cdcd7116180a'),(88,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','4281eaced4e943ababeefb66a6a7f13d'),(89,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','3cadf44d739b45d4a94ad23939e19716'),(90,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','05932c39ad444ac5aaf880d281620611'),(92,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','efcbf104971a4266a26d9469e58c1327'),(93,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','8228955d67bc4dc89638b523f58108ee'),(94,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','2235160bd56c423880572f5450b94f16'),(95,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','cf50028007164569a136fbdeaff7619c'),(97,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','8f465aa674744313890cc8c59d3d0fd2'),(98,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','6a21329f0dcd4781a64fc4f62324e4c0'),(99,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','220fa39fd56e47e1ab9558c6bd10106e'),(100,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','f5818e4cd46947daabe046c511dfbd63'),(101,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','a20a200c721c489b9925cdd5b5e6708c'),(102,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','2c5b748c5dce4f34bd24b1201faf09c2'),(103,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','98c953b2d74d4d9d83d18433a7fc85ba'),(104,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','11d334fcadf1490e85e6a045126dea78'),(107,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','c2cac9993f9142cca5f531565a14f840'),(108,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','c28461a142d7464f8865752c969d82de'),(109,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','4450d80871eb44a1aaa4fbb5429885f0'),(110,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','576008b6046f4afcb88d8139ff34e228'),(111,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','a45559c4cc6f48e2b7194c2dc577af3a'),(112,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','19d01a929bc9414cac1a8defd48597c9'),(113,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','0b5bf0f1caac45beabf54fb5d930187b'),(114,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','0ce04d99cbd249a9af88fe1496591a89'),(115,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','bec59f93068a4d7aaaf5b4ccfbc12265'),(116,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','fa8d945124b74379aba32bcf34ea5383'),(117,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','1a16836d2cec4d14a1307b3228e3cfdd'),(118,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','53e6d5a4192c4f0f8bdd7f5647124147'),(119,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','6e27757847c64e228934b60ae81baedf'),(120,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','14514da3c11441c2b63f2331e3f897d0'),(121,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','9565c5888bd4414c84ecede7af7d1554'),(122,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','d419393d77e34f8e9c1eda5893f3bc87'),(123,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','fa7c32c9397c46b8821b62aae5512af0'),(124,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','103d4310b98e4ff1ba71336af8d4c6c2'),(125,'36001d1a-1b3e-4413-bdfe-b3bc04375f46','f4e0b4aa230b4afba10a7ba58af3c454');

#
# Structure for table "lyadmin_system_config"
#

-- CREATE TABLE `lyadmin_system_config` (
--   `id` varchar(100) NOT NULL COMMENT 'Id',
--   `description` varchar(100) DEFAULT NULL COMMENT '描述',
--   `modifier` varchar(100) DEFAULT NULL COMMENT '修改人',
--   `dept_belong_id` varchar(100) DEFAULT NULL COMMENT '数据归属部门',
--   `update_datetime` datetime(6) DEFAULT NULL COMMENT '修改时间',
--   `create_datetime` datetime(6) DEFAULT NULL COMMENT '创建时间',
--   `title` varchar(50) NOT NULL COMMENT '标题',
--   `key` varchar(20) NOT NULL COMMENT '键名',
--   `value` longtext,
--   `sort` int(11) NOT NULL COMMENT '排序',
--   `status` tinyint(1) NOT NULL COMMENT '启用状态',
--   `data_options` longtext,
--   `form_item_type` smallint(6) NOT NULL COMMENT '表单类型',
--   `rule` longtext,
--   `placeholder` varchar(50) DEFAULT NULL COMMENT '提示信息',
--   `setting` longtext,
--   `creator_id` varchar(100) DEFAULT NULL COMMENT '创建人',
--   `parent_id` varchar(100) DEFAULT NULL COMMENT '父级',
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `lyadmin_system_config_key_parent_id_97f056cc_uniq` (`key`,`parent_id`),
--   KEY `lyadmin_system_config_key_7aeced64` (`key`),
--   KEY `lyadmin_system_config_creator_id_bd4f327e` (`creator_id`),
--   KEY `lyadmin_system_config_parent_id_2c3a27d0` (`parent_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统配置表';

#
# Data for table "lyadmin_system_config"
#

REPLACE INTO `lyadmin_system_config` VALUES ('7fda473ac29a453a800a798337bf5676',NULL,'456b688c-8ad5-46de-bc2e-d41d8047bd42','d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-12-26 14:44:59.127715','2022-12-26 14:40:00.382208','隐私协议','privatexy','<p>隐私协议内容</p>',2,1,NULL,14,'[]','请输入内容',NULL,'456b688c-8ad5-46de-bc2e-d41d8047bd42','d5a88a3f46494d6586f0d90e3919b864'),('cd46ae145c5c422983f11572cfb3e8f6',NULL,'456b688c-8ad5-46de-bc2e-d41d8047bd42','d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-12-26 14:44:59.124218','2022-12-26 14:31:03.506750','客服电话','phone','1888888888x',1,1,NULL,0,'[]','请输入电话号码',NULL,'456b688c-8ad5-46de-bc2e-d41d8047bd42','d5a88a3f46494d6586f0d90e3919b864'),('d5a88a3f46494d6586f0d90e3919b864',NULL,'456b688c-8ad5-46de-bc2e-d41d8047bd42','d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-12-26 14:15:18.223194','2022-12-26 14:15:18.224191','基础配置','base',NULL,0,1,NULL,0,NULL,NULL,NULL,'456b688c-8ad5-46de-bc2e-d41d8047bd42',NULL),('e67248a9318d424ea027fc0aae3ecb5a',NULL,'456b688c-8ad5-46de-bc2e-d41d8047bd42','d2c03bd9-dad0-4262-88ca-c3681d224fc3','2022-12-26 14:47:50.727322','2022-12-26 14:45:54.661733','logo','logo','http://127.0.0.1:8000/media/platform/2022-04-07/20220407120605_298.png',3,1,NULL,7,'[]','',NULL,'456b688c-8ad5-46de-bc2e-d41d8047bd42','d5a88a3f46494d6586f0d90e3919b864');

#
# Structure for table "lyadmin_users"
#

-- CREATE TABLE `lyadmin_users` (
--   `password` varchar(128) NOT NULL,
--   `last_login` datetime(6) DEFAULT NULL,
--   `is_superuser` tinyint(1) NOT NULL COMMENT 'Designates that this user has all permissions without explicitly assigning them.',
--   `first_name` varchar(150) NOT NULL,
--   `last_name` varchar(150) NOT NULL,
--   `is_staff` tinyint(1) NOT NULL COMMENT 'Designates whether the user can log into this admin site.',
--   `is_active` tinyint(1) NOT NULL COMMENT 'Designates whether this user should be treated as active. Unselect this instead of deleting accounts.',
--   `date_joined` datetime(6) NOT NULL,
--   `id` varchar(100) NOT NULL COMMENT 'Id',
--   `description` varchar(100) DEFAULT NULL COMMENT '描述',
--   `modifier` varchar(100) DEFAULT NULL COMMENT '修改人',
--   `dept_belong_id` varchar(100) DEFAULT NULL COMMENT '数据归属部门',
--   `update_datetime` datetime(6) DEFAULT NULL COMMENT '修改时间',
--   `create_datetime` datetime(6) DEFAULT NULL COMMENT '创建时间',
--   `username` varchar(50) NOT NULL COMMENT '用户账号',
--   `email` varchar(60) DEFAULT NULL COMMENT '邮箱',
--   `mobile` varchar(30) DEFAULT NULL COMMENT '电话',
--   `avatar` varchar(200) DEFAULT NULL COMMENT '头像',
--   `name` varchar(40) NOT NULL COMMENT '姓名',
--   `nickname` varchar(100) NOT NULL COMMENT '用户昵称',
--   `gender` smallint(6) DEFAULT NULL COMMENT '性别',
--   `identity` smallint(6) DEFAULT NULL COMMENT '身份标识',
--   `balance` decimal(10,2) NOT NULL,
--   `is_delete` tinyint(1) NOT NULL COMMENT '是否逻辑删除',
--   `creator_id` varchar(100) DEFAULT NULL COMMENT '创建人',
--   `dept_id` varchar(100) DEFAULT NULL COMMENT '关联部门',
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `username` (`username`),
--   KEY `lyadmin_users_creator_id_92824513` (`creator_id`),
--   KEY `lyadmin_users_dept_id_ba5fbf41` (`dept_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

#
# Data for table "lyadmin_users"
#

REPLACE INTO `lyadmin_users` VALUES ('pbkdf2_sha256$260000$oivECWOjB0GJyMjPsrqb3t$9FvnYtXtsNWDva2P3A/eIg6cRMLOp7kiIOuwfLKyDAY=',NULL,0,'','',0,1,'2022-06-27 13:56:06.339555','244b28685cd14a39a383189981510d4a',NULL,NULL,NULL,'2022-11-02 16:44:12.072254','2022-06-27 13:56:06.339555','test',NULL,'18888888888',NULL,'测试用户','测试用户',NULL,2,0.00,0,NULL,''),('pbkdf2_sha256$390000$waSuE7tR0sxyeiLELJYh4h$tiaQGmUEEDZ/i1mY9+YY++rhXbbmiJSpIr41pEDF2q0=',NULL,1,'','',1,1,'2022-06-27 13:56:06.331576','456b688c-8ad5-46de-bc2e-d41d8047bd42',NULL,NULL,NULL,'2022-06-27 13:56:06.331576','2022-06-27 13:56:06.331576','superadmin',NULL,NULL,NULL,'超级管理员','',NULL,0,0.00,0,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3'),('pbkdf2_sha256$320000$fNyAAOrrZNjACpme8Qgv4T$CkpJIXe3XJcm/dyAR7b9G55AZVLcJOPQOBY/9GA5LI0=',NULL,0,'','',1,1,'2022-06-27 13:56:06.334568','d1431450-5068-4461-b57e-7862c005a547',NULL,NULL,NULL,'2022-06-27 13:56:06.334568','2022-06-27 13:56:06.334568','admin',NULL,NULL,NULL,'管理员','',NULL,1,0.00,0,NULL,'d2c03bd9-dad0-4262-88ca-c3681d224fc3');

#
# Structure for table "django_admin_log"
#

-- CREATE TABLE `django_admin_log` (
--   `id` int(11) NOT NULL AUTO_INCREMENT,
--   `action_time` datetime(6) NOT NULL,
--   `object_id` longtext,
--   `object_repr` varchar(200) NOT NULL,
--   `action_flag` smallint(5) unsigned NOT NULL,
--   `change_message` longtext NOT NULL,
--   `content_type_id` int(11) DEFAULT NULL,
--   `user_id` varchar(100) NOT NULL,
--   PRIMARY KEY (`id`),
--   KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
--   KEY `django_admin_log_user_id_c564eba6_fk_lyadmin_users_id` (`user_id`),
--   CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
--   CONSTRAINT `django_admin_log_user_id_c564eba6_fk_lyadmin_users_id` FOREIGN KEY (`user_id`) REFERENCES `lyadmin_users` (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='log entry';

#
# Data for table "django_admin_log"
#


#
# Structure for table "lyadmin_users_groups"
#

-- CREATE TABLE `lyadmin_users_groups` (
--   `id` bigint(20) NOT NULL AUTO_INCREMENT,
--   `users_id` varchar(100) NOT NULL,
--   `group_id` int(11) NOT NULL,
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `lyadmin_users_groups_users_id_group_id_a79dc867_uniq` (`users_id`,`group_id`),
--   KEY `lyadmin_users_groups_group_id_c57fd8d6_fk_auth_group_id` (`group_id`),
--   CONSTRAINT `lyadmin_users_groups_group_id_c57fd8d6_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
--   CONSTRAINT `lyadmin_users_groups_users_id_8bf861d7_fk_lyadmin_users_id` FOREIGN KEY (`users_id`) REFERENCES `lyadmin_users` (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

#
# Data for table "lyadmin_users_groups"
#


#
# Structure for table "lyadmin_users_post"
#

-- CREATE TABLE `lyadmin_users_post` (
--   `id` bigint(20) NOT NULL AUTO_INCREMENT,
--   `users_id` varchar(100) NOT NULL,
--   `post_id` varchar(100) NOT NULL,
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `lyadmin_users_post_users_id_post_id_b358d223_uniq` (`users_id`,`post_id`),
--   KEY `lyadmin_users_post_users_id_f3295aea` (`users_id`),
--   KEY `lyadmin_users_post_post_id_67f9ae2a` (`post_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

#
# Data for table "lyadmin_users_post"
#


#
# Structure for table "lyadmin_users_role"
#

-- CREATE TABLE `lyadmin_users_role` (
--   `id` bigint(20) NOT NULL AUTO_INCREMENT,
--   `users_id` varchar(100) NOT NULL,
--   `role_id` varchar(100) NOT NULL,
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `lyadmin_users_role_users_id_role_id_475ae0d5_uniq` (`users_id`,`role_id`),
--   KEY `lyadmin_users_role_users_id_25f578a0` (`users_id`),
--   KEY `lyadmin_users_role_role_id_0f927f87` (`role_id`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

#
# Data for table "lyadmin_users_role"
#

REPLACE INTO `lyadmin_users_role` VALUES (1,'d1431450-5068-4461-b57e-7862c005a547','36001d1a-1b3e-4413-bdfe-b3bc04375f46');

#
# Structure for table "lyadmin_users_user_permissions"
#

-- CREATE TABLE `lyadmin_users_user_permissions` (
--   `id` bigint(20) NOT NULL AUTO_INCREMENT,
--   `users_id` varchar(100) NOT NULL,
--   `permission_id` int(11) NOT NULL,
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `lyadmin_users_user_permi_users_id_permission_id_b174f27e_uniq` (`users_id`,`permission_id`),
--   KEY `lyadmin_users_user_p_permission_id_0555113f_fk_auth_perm` (`permission_id`),
--   CONSTRAINT `lyadmin_users_user_p_permission_id_0555113f_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
--   CONSTRAINT `lyadmin_users_user_p_users_id_7212a3dc_fk_lyadmin_u` FOREIGN KEY (`users_id`) REFERENCES `lyadmin_users` (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

#
# Data for table "lyadmin_users_user_permissions"
#



-- #
-- # Structure for table "tb_monitor"
-- #

-- CREATE TABLE `tb_monitor` (
--   `id` varchar(100) NOT NULL COMMENT 'Id',
--   `description` varchar(100) DEFAULT NULL COMMENT '描述',
--   `modifier` varchar(100) DEFAULT NULL COMMENT '修改人',
--   `dept_belong_id` varchar(100) DEFAULT NULL COMMENT '数据归属部门',
--   `update_datetime` datetime(6) DEFAULT NULL COMMENT '修改时间',
--   `create_datetime` datetime(6) DEFAULT NULL COMMENT '创建时间',
--   `ip` varchar(50) DEFAULT NULL,
--   `name` varchar(50) DEFAULT NULL,
--   `os` varchar(50) DEFAULT NULL,
--   `online` tinyint(1) NOT NULL,
--   `status` tinyint(1) NOT NULL,
--   `days` smallint(6) NOT NULL,
--   `interval` smallint(6) NOT NULL,
--   `islocal` tinyint(1) NOT NULL,
--   `creator_id` varchar(100) DEFAULT NULL COMMENT '创建人',
--   PRIMARY KEY (`id`),
--   KEY `tb_monitor_creator_id_27f410f2` (`creator_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='服务监控';

-- #
-- # Data for table "tb_monitor"
-- #

-- #
-- # Structure for table "tb_terminalserver"
-- #

-- CREATE TABLE `tb_terminalserver` (
--   `id` varchar(100) NOT NULL COMMENT 'Id',
--   `description` varchar(100) DEFAULT NULL COMMENT '描述',
--   `modifier` varchar(100) DEFAULT NULL COMMENT '修改人',
--   `dept_belong_id` varchar(100) DEFAULT NULL COMMENT '数据归属部门',
--   `update_datetime` datetime(6) DEFAULT NULL COMMENT '修改时间',
--   `create_datetime` datetime(6) DEFAULT NULL COMMENT '创建时间',
--   `host` varchar(100) NOT NULL,
--   `remark` varchar(100) DEFAULT NULL,
--   `username` varchar(200) NOT NULL,
--   `password` varchar(200) DEFAULT NULL,
--   `pkey` varchar(255) DEFAULT NULL,
--   `pkey_passwd` varchar(255) DEFAULT NULL,
--   `type` smallint(6) NOT NULL COMMENT '验证方式',
--   `creator_id` varchar(100) DEFAULT NULL COMMENT '创建人',
--   `port` int(11) NOT NULL COMMENT '端口号',
--   PRIMARY KEY (`id`),
--   KEY `tb_terminalserver_creator_id_d30e3e38` (`creator_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='终端服务器列表';

-- #
-- # Data for table "tb_terminalserver"
-- #

REPLACE INTO `tb_terminalserver` VALUES ('99508bdc6e454f50ba414f52089928b6',NULL,'superadmin',NULL,'2022-07-17 23:53:34.766663','2022-07-17 17:36:43.286021','124.222.222.225','测试服务器账号','lyadmintest','lyadmintest0008','','',0,NULL,22);