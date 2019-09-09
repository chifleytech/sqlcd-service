FROM chifleytech/sqlcd-service-build:latest

FROM openjdk:8-jdk

RUN apt-get update ;\
    apt-get install -y tzdata

WORKDIR /root

COPY --from=0 /root/app.jar /root/

RUN mkdir /root/template
RUN mkdir /root/template/conf
RUN mkdir /root/template/drivers

RUN mkdir /root/conf/
RUN mkdir /root/drivers
RUN mkdir /root/logs

COPY application.conf /root/template/conf/
COPY logback.xml /root/template/conf/logback.xml.template
COPY drivers /root/template/drivers

COPY run.sh /root/run.sh
RUN chmod 766 run.sh
EXPOSE 7080
EXPOSE 9090

CMD /root/run.sh
