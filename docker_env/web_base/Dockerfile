FROM centos:7

COPY files/ /usr/local/src/
RUN yum install wget lrzsz vim iproute -y && \
    echo "LANG=en_US.UTF8" >/etc/locale.conf && \
    echo 'colorscheme murphy' > ~/.vimrc && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc make openssh-clients libffi-devel && \
    cd /usr/local/src && \
    tar -xf Python-3.9.16.tgz && \
    cd Python-3.9.16 && \
    ./configure --prefix=/usr/local/python3.9.16 && \
    make && \
    make install && \
    cd /usr/local/  && \
    /usr/local/python3.9.16/bin/python3 -m venv dev && \
    wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo && \
    yum install supervisor -y && \
    sed -i 's#nodaemon=false#nodaemon=true#g' /etc/supervisord.conf && \
    curl -fsSL https://repo.saltproject.io/py3/redhat/7/x86_64/3004.repo | tee /etc/yum.repos.d/salt.repo && \
    yum clean expire-cache  && \
    yum install salt-minion -y  && \
    yum install python-devel mysql-devel -y && \
    # nginx 安装
    yum -y install gcc gcc-c++ autoconf automake openssl openssl-devel pcre pcre-devel zlib zlib-devel nginx && \
    cd /usr/local/src && \ 
    yum install nginx -y && \
    mkdir -p /data/www && mkdir -p /data/ProjectDM/group && mkdir -p /data/salt/pillar && \
    groupadd -g 10001 www && \
    useradd www -u 10001 -g www -s /sbin/nologin && \
    chown -R www.www /data/www && \
    cp /usr/local/src/nginx.conf /etc/nginx/nginx.conf  && \
    # cron 和 rsyslogd安装,crond的日志/var/log/cron必须按照rsyslogd才能有
    yum install vixie-cron crontabs rsyslog -y && \
    # rsyslogd默认用journal跑必须删除,并且要修改对应配置文件里的内容，不然无法生成日志文件
    rm -rf /etc/rsyslog.d/listen.conf  && \
    sed -i 's/^$ModLoad imjournal/#$ModLoad imjournal/g' /etc/rsyslog.conf  && \
    sed -i 's/^$IMJournalStateFile imjournal.state/#$IMJournalStateFile imjournal.state/g' /etc/rsyslog.conf  && \
    sed -i 's/$OmitLocalLogging on/$OmitLocalLogging off/g' /etc/rsyslog.conf  && \
    yum clean all
ENV LANG "en_US.UTF8"
CMD ["/bin/bash"]