FROM docker:1.11-dind

# install sshd
RUN apk add --update --no-cache openssh \
    && rm -rf /etc/ssh/ssh_host_*_key \
    && ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa \
    && ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa \
    && ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa \
    && ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519 \
    && mkdir -p /var/run/sshd

# install vsc tools, supervisor
RUN apk add --no-cache \
                git \
                subversion \
                supervisor\
    && mkdir -p /var/log/supervisor

# install jdk
# RUN apk add --no-cache openjdk8="8.92.14-r1"

# java env
#ENV JAVA_VERSION_MAJOR 8
#ENV JAVA_VERSION_MINOR 92
#ENV JAVA_VERSION_BUILD 14
#ENV JAVA_PACKAGE       jdk
#ENV JAVA_HOME          /usr/lib/jvm/java-1.8-openjdk

# add root passwd
RUN echo -e "admin\nadmin" | passwd root \
    && alias la="ls -lAh" \
    && rm -rf /tmp/*

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8
#ENV PATH $PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin

EXPOSE 22 80

WORKDIR /root

COPY supervisor.conf /etc/supervisor.conf

# COPY entrypoint.sh /usr/local/bin
# ENTRYPOINT ["entrypoint.sh"]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor.conf"]
