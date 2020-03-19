# Базовая платформа для запуска Nginx
FROM ubuntu:18.04
 
# Стандартный апдейт репозитория
RUN apt-get -y update
# Установка Nginx
RUN apt-get install -y nginx
# Указываем Nginx запускаться на переднем плане (daemon off)
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
# В индексном файле меняем первое вхождение nginx на docker-nginx

RUN sed -i "0,/nginx/s/nginx/docker-nginx/i" /usr/share/nginx/html/index.html
#COPY nginx.conf /etc/nginx/nginx.conf
# Запускаем Nginx. CMD указывает, какую команду необходимо запустить, когда контейнер запущен.
COPY default /etc/nginx/sites-enabled/default
COPY index.html /var/www/html/my/index.html
COPY date.html /var/www/html/my/date.html
RUN ["/bin/bash", "-c", "ls -l /var/log/nginx/access.log >> /var/www/html/my/date.html"]
#RUN docker container ls --format 'table {{.Names}}\t{{.Status}}' >> /var/www/html/my/date.html
CMD [ "nginx" ]
#CMD ["docker container ls --format 'table {{.Names}}\t{{.Status}}' >> /var/www/html/my/date.html"]
