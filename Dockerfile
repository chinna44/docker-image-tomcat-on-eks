FROM tomcat:8.5.35-jre10
MAINTAINER giridhar
COPY ./index.html /usr/local/tomcat/webapps/ROOT/
COPY ./target/giridhar.war /usr/local/tomcat/webapps/
EXPOSE 8080
RUN chmod +x /usr/local/tomcat/bin/catalina.sh
ENTRYPOINT ["catalina.sh", "run"]
