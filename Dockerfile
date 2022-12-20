FROM  centos:latest

MAINTAINER agbawochinonso488@gmail.com

RUN yum install -y httpd \
unzip

ADD https://www.free-css.com/assets/files/free-css-templates/download/page286/consult.zip /var/www/html/
WORKDIR /var/www/html/
RUN unzip consult.zip
RUN cp -rvf consultancy-website-template/* .
RUN rm -rf consultancy-website-template consult.zip
CMD ["/usr/sbin/httpd","-D", "FOREGROUND"]
EXPOSE 80 22