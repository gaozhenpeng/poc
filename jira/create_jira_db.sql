-- https://confluence.atlassian.com/adminjiraserver/connecting-jira-applications-to-mysql-5-7-966063305.html

CREATE DATABASE jiradb CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,REFERENCES,ALTER,INDEX on jiradb.* TO 'juser'@'%' IDENTIFIED BY 'juser';

FLUSH PRIVILEGES;

