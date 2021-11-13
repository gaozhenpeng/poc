# https://hub.docker.com/r/jenkins/jenkins
FROM jenkins/jenkins:2.289.1-lts-alpine

ENV  JAVA_OPTS -Djenkins.install.runSetupWizard=false
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
