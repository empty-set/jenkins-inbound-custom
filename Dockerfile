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
#RUN  apt-get install mono-complete -y
RUN  apt-get install apt-utils  -y
RUN  apt-get install libicu63  -y
USER jenkins

RUN mkdir gitversion && curl -L https://github.com/GitTools/GitVersion/releases/download/5.3.7/gitversion-ubuntu.18.04-x64-5.3.7.tar.gz | tar xz -C gitversion
USER root
RUN mv gitversion/gitversion /usr/local/bin/gitversion
USER jenkins

#RUN gitversion
