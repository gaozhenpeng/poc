# maxscale

```bash
# https://hub.docker.com/r/mariadb/maxscale
# https://www.github.com/mariadb-corporation/maxscale-docker
# https://mariadb.com/kb/en/mariadb-maxscale-20-limitations-and-known-issues-within-mariadb-maxscale/#limitations-and-known-issues-within-mariadb-maxscale

# sharding
http://mariadb.com/kb/en/mariadb-maxscale-14/maxscale-simple-sharding-with-two-servers/
https://mariadb.com/kb/en/mariadb-maxscale-14/maxscale-routers-schemarouter-router/

# compose
# https://github.com/mariadb-corporation/maxscale-docker/tree/master/maxscale
# https://registry.hub.docker.com/r/bitnami/mariadb

# config
# https://github.com/mariadb-corporation/maxscale-docker/blob/master/maxscale/maxscale.cnf.d/example.cnf

# management
https://severalnines.com/database-blog/maxscale-basic-management-using-maxctrl-mariadb-cluster

# troubleshoot
https://mariadb.com/kb/en/maxscale-troubleshooting/

# maxscale 6 docs
https://mariadb.com/kb/en/mariadb-maxscale-6-mariadb-maxscale-configuration-guide

# ha maxscale
https://mydbops.wordpress.com/2018/01/24/ha-solution-for-maxscale-or-proxysql/

# schemarouter with readwrite split
https://dzone.com/articles/schema-sharding-with-mariadb-maxscale-21

# test
sudo apt-get install -y mariadb-client

docker-compose exec mxs maxctrl list servers
docker-compose exec mxs maxctrl list services

mariadb -h127.0.0.1 -uroot -ppass
SELECT @@hostname;
SELECT * FROM test.table1;
SELECT * FROM test.table2;
SHOW SHARDS;
```
