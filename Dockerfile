FROM tomcat7-jre8:latest

RUN yum install wget unzip -y
RUN wget https://dev.imaicloud.com/files/comic/IAM-war/iam.war
RUN unzip iam.war -d /tomcat/webapps/iam/

