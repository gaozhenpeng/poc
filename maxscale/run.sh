set -x

for db in db1 db2 db3
do
  # start master
  docker-compose up -d $db
  sleep 20
  docker-compose exec $db mysql -uroot -ppass -e "SHOW MASTER STATUS"
  export MASTER_LOG_FILE=$(docker-compose exec $db mysql -uroot -ppass -e "SHOW MASTER STATUS" | grep -w ${db}-bin | tr -s ' ' | cut -d ' ' -f 2)
  export MASTER_LOG_POS=$(docker-compose  exec $db mysql -uroot -ppass -e "SHOW MASTER STATUS" | grep -w ${db}-bin | tr -s ' ' | cut -d ' ' -f 4)

  # start slave
  docker-compose up -d ${db}s
  sleep 20
  docker-compose exec ${db}s mysql -uroot -ppass -e "STOP SLAVE; RESET SLAVE"
  docker-compose exec ${db}s mysql -uroot -ppass -e "
CHANGE MASTER TO
MASTER_HOST='${db}',
MASTER_USER='root',
MASTER_PASSWORD='pass',
MASTER_LOG_FILE='${MASTER_LOG_FILE}',
MASTER_LOG_POS=${MASTER_LOG_POS}; START SLAVE"

  sleep 5
  docker-compose exec ${db}s mysql -uroot -ppass -e "SHOW SLAVE STATUS \G"
done

# start maxscale
docker-compose up -d mxs
sleep 5
docker-compose exec mxs maxctrl list servers

