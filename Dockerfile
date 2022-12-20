FROM  centos:latest

MAINTAINER agbawochinonso488@gmail.com

RUN cd /etc/yum.repos.d/ 

RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*

RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum update -y

RUN yum install -y httpd
RUN yum install unzip

ADD https://www.free-css.com/assets/files/free-css-templates/download/page286/consult.zip /var/www/html/
WORKDIR /var/www/html/
RUN unzip consult.zip
RUN cp -rvf consultancy-website-template/* .
RUN rm -rf consultancy-website-template consult.zip
CMD ["/usr/sbin/httpd","-D", "FOREGROUND"]
EXPOSE 80 22