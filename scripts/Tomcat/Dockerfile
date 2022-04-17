FROM nexus.xxx.ru/ubuntu-base:20.04 as build
MAINTAINER Vadim Maltsev <windows-1995@mail.ru>
RUN apt update -y \
    && apt install wget zip sudo systemctl nano -y
RUN apt install openjdk-8-jre-headless -y
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
RUN groupadd tomcat \
    && useradd -d /usr/share/tomcat -g tomcat -M -s /bin/false tomcat
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.62/bin/apache-tomcat-9.0.62.tar.gz -O /tmp/tomcat.tar.gz \
    && mkdir -p /usr/share/tomcat \
    && sudo tar xvf /tmp/tomcat.tar.gz -C /usr/share/tomcat --strip-components 1 \
    && sudo chgrp -R tomcat /usr/share/tomcat \
    && sudo chmod -R g+r /usr/share/tomcat/conf \
    && sudo chmod g+x /usr/share/tomcat/conf \
    && cd /usr/share/tomcat/ \
    && sudo chown -R tomcat webapps work temp logs
ADD . /
RUN sudo systemctl daemon-reload \
    && sudo systemctl enable tomcat.service \
    && sudo systemctl start tomcat.service
CMD ["/usr/share/tomcat/bin/catalina.sh", "run"]