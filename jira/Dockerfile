FROM atlassian/jira-software:8.15.0
# https://hub.docker.com/r/atlassian/jira-software/

# https://bitbucket.org/atlassian-docker/docker-atlassian-jira/src/master/Dockerfile

# jdbc tested versions
# https://confluence.atlassian.com/doc/database-jdbc-drivers-171742.html
# https://downloads.mysql.com/archives/c-j/
RUN apt-get update && apt-get install -y wget unzip && \
    wget https://downloads.mysql.com/archives/get/p/3/file/mysql-connector-java-5.1.48.zip && \
    unzip mysql-connector-java-5.1.48.zip && \
    cd mysql-connector-java-5.1.48 && \
    mv -v *.jar /opt/atlassian/jira/lib && cd .. && \
    rm -frv mysql-connector-java-5.1.48*

# https://bitbucket.org/atlassian-docker/docker-atlassian-jira/src/master/config/dbconfig.xml.j2
# https://confluence.atlassian.com/adminjiraserver/connecting-jira-applications-to-mysql-5-7-966063305.html
COPY dbconfig.xml.j2 /opt/atlassian/etc/

