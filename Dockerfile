FROM centos

MAINTAINER hello@gritfy.com

RUN mkdir /opt/tomcat/

WORKDIR /opt/tomcat
RUN curl -O https://downloads.apache.org/tomcat/tomcat-8/v8.5.86/bin/apache-tomcat-8.5.86.tar.gz
RUN tar xvfz apache*.tar.gz
RUN mv apache-tomcat-8.5.86/* /opt/tomcat/.
RUN yum update -y \
    && yum install java -y
WORKDIR /opt/tomcat/webapps
RUN curl -O -L https://github.com/AKSarav/SampleWebApp/raw/master/dist/SampleWebApp.war
CMD ["/opt/tomcat/bin/catalina.sh", "run"]

EXPOSE 8080
