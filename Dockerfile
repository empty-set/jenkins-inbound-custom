FROM jenkins/inbound-agent
LABEL maintainer="dev@ptpos.com"

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000

#ENV JENKINS_HOME /home/${user}

#RUN chown -R ${user}:${user} /home/${user}

# Add the jenkins user to sudoers
#RUN echo "${user}    ALL=(ALL)    ALL" >> etc/sudoers

# Set Name Servers
#COPY /files/resolv.conf /etc/resolv.conf

USER root

RUN apt-get update
#install utils for gitversion
RUN  apt-get install apt-utils  -y
RUN  apt-get install libicu63  -y

# install help
RUN curl https://helm.baltorepo.com/organization/signing.asc | apt-key add -
RUN apt-get install apt-transport-https --yes
RUN echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
RUN apt-get update
RUN apt-get install helm
USER jenkins

#install git version
RUN mkdir gitversion && curl -L https://github.com/GitTools/GitVersion/releases/download/5.3.7/gitversion-ubuntu.18.04-x64-5.3.7.tar.gz | tar xz -C gitversion
USER root
RUN mv gitversion/gitversion /usr/local/bin/gitversion
USER jenkins

#RUN gitversion
