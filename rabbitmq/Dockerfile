# https://github.com/bitnami/bitnami-docker-rabbitmq

FROM bitnami/rabbitmq:3.8.11-debian-10-r9
COPY rabbitmq_delayed_message_exchange-20171201-3.7.x.ez /opt/bitnami/rabbitmq/plugins

# https://www.rabbitmq.com/networking.html
#      epmd amqp cli   api   webstomp
EXPOSE 4369 5672 25672 15672 15674

