FROM ubuntu:16.04

RUN apt-get -y update
RUN apt-get -y install apache2

COPY ./index.html /var/www/html/index.html
COPY ./style.css /var/www/html/style.css
COPY ./icon.png /var/www/html/icon.png
# RUN echo '<h1>Hello from docker and ECR</h1>' > /var/www/html/index.html

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

EXPOSE 80
