docker-compose exec mariadb mysqldump -uroot -proot k3s > $(date +'%Y%m%d%H%M%S').sql
