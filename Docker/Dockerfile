# Dockerfile

FROM baseImage

# RUN command
# RUN [exe, arg1, arg2 ...]
RUN yum install -y epel-release \
    && yum install -y mariadb-server mariadb redis nginx java-1.8.0-openjdk.x86_64

RUN echo 'Ahri' > /usr/share/nginx/html/index/html

USER daemon
