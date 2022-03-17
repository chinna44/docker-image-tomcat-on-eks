FROM centos:8
MAINTAINER: giridhard444@gmail.com

ENV CREATE_DIR /opt/software/

WORKDIR $CREATE_DIR

RUN     yum update -y \
        && cd $CREATE_DIR
		&& wget https://mirrors.estointernet.in/apache/tomcat/tomcat-8/v8.5.76/bin/apache-tomcat-8.5.76.tar.gz
		&& tar -xzvf apache-tomcat-8.5.76.tar.gz
		&& ln -s /opt/software/apache-tomcat-8.5.76 tomcat
		&& wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm
		&& rpm -ivh --prefix /opt/software/ jdk-17_linux-x64_bin.rpm
		&& ln -s /opt/software/jdk-17.0.2 java
		
COPY index.html /opt/software/tomcat/webapps/ROOT/index.html
COPY tomcat-start/tomcat.service /usr/lib/systemd/system/tomcat.service
COPY ./target/giridhar.war /opt/software/tomcat/webapps/

RUN     cd /etc/systemd/system/multi-user.target.wants/
        && ln -s /usr/lib/systemd/system/tomcat.service tomcat.service
        
EXPOSE 8080
EXPOSE 4444

CMD ["systemctl", "start", "tomcat"]
