FROM centos:latest
MAINTAINER ywfwj2008 <ywfwj2008@163.com>

ENV REMOTE_PATH=https://github.com/ywfwj2008/bt-panel/raw/master

WORKDIR /tmp

# install bt panel
ADD ${REMOTE_PATH}/install.sh /tmp/install.sh
RUN chmod 777 install.sh && \
    bash install.sh && \
    rm -rf /tmp/*

# install supervisord
ADD ./supervisord.conf /etc/supervisor/supervisord.conf
RUN pip install --upgrade pip && \
    pip install supervisor && \
    mkdir -p /etc/supervisor/conf.d /var/log/supervisor

# expose port
EXPOSE 8888 80 443 21 20

# Set the entrypoint script.
ENTRYPOINT ["/etc/init.d/bt", "start"]

#Define the default command.
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
