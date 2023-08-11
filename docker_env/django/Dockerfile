FROM web_base
COPY files/ /usr/local/src/
RUN sed -i 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking no/g' /etc/ssh/ssh_config  && \
    mv /usr/local/src/backend /data/www/backend && \
    cd /data/www/backend && \
    /usr/local/dev/bin/pip3 install -r requirements_now2.txt -i https://mirrors.aliyun.com/pypi/simple  && \
    cp /usr/local/src/supervisord.ini /etc/supervisord.d/ && \
    # nginx
    cp /usr/local/src/nginx/nginx.conf /etc/nginx/nginx.conf -r && \
    cp /usr/local/src/nginx/admin.conf /etc/nginx/conf.d/admin.conf  && \
    # 拷贝wait-for-it.sh
    cp /usr/local/src/wait-for-it.sh /usr/local/wait-for-it.sh  && \
    chmod +x /usr/local/wait-for-it.sh  && \
    # 拷贝docker-entrypoint.sh至/usr/bin下并赋予可执行权限
    cp /usr/local/src/docker-entrypoint.sh /usr/bin/docker-entrypoint.sh  && \
    chmod +x /usr/bin/docker-entrypoint.sh  && \
    rm -rf /usr/local/src/*
EXPOSE 80 8090 8088 873     
ENV CONF "/data/www/backend/application/admin_conf.ini"
ENTRYPOINT ["docker-entrypoint.sh"]