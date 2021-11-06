FROM ubuntu:16.04

RUN apt-get -y update
RUN apt-get -y install apache2

COPY ./index.html /usr/share/nginx/html/index.html
COPY ./style.css /usr/share/nginx/html/style.css
COPY ./icon.png /usr/share/nginx/html/icon.png
# RUN echo '<h1>Hello from docker and ECR</h1>' > /var/www/html/index.html

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

EXPOSE 80