FROM centos:7
MAINTAINER giridhard444@gmail.com

ENV CREATE_DIR /opt/software/
ENV VER 9.0.39

WORKDIR $CREATE_DIR

RUN     yum update -y \
        && yum install wget -y \
        && cd $CREATE_DIR \
	&& wget https://archive.apache.org/dist/tomcat/tomcat-9/v${VER}/bin/apache-tomcat-${VER}.tar.gz \
	&& tar -xzvf apache-tomcat-${VER}.tar.gz \
	&& ln -s /opt/software/apache-tomcat-${VER} tomcat \
	&& wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm \
	&& rpm -ivh --prefix /opt/software/ jdk-17_linux-x64_bin.rpm \
	&& ln -s /opt/software/jdk-17.0.2 java
		
COPY index.html /opt/software/tomcat/webapps/ROOT/index.html
COPY tomcat-start/tomcat.service /usr/lib/systemd/system/tomcat.service
COPY ./target/giridhar.war /opt/software/tomcat/webapps/

RUN     cd /etc/systemd/system/multi-user.target.wants \
        && ln -s /usr/lib/systemd/system/tomcat.service tomcat.service
        
EXPOSE 8080

CMD ["/opt/software/tomcat/bin/startup.sh", "run"]
