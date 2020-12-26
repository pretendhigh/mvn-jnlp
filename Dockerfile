FROM centos:7.6.1810

ENV TIMEZONE=Asia/Shanghai \
    LANG=zh_CN.UTF-8

COPY CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
COPY docker-ce.repo /etc/yum.repos.d/docker-ce.repo
RUN mkdir -p /usr/share/jenkins \
    && mkdir -p /root/.kube \
    && yum clean all \
    && yum makecache \
    && yum install -y java-1.8.0-openjdk docker-ce maven git \
    && yum clean all
COPY jenkins-slave /usr/local/bin/jenkins-slave
COPY slave.jar /usr/share/jenkins
COPY kubectl /usr/bin/kubectl


USER root

WORKDIR /home/jenkins

ENTRYPOINT ["jenkins-slave"]
