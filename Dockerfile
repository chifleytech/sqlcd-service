FROM openjdk:8-jdk

ENV LOG_LEVEL="info"

RUN apt-get update ;\
    apt-get install -y tzdata

WORKDIR /root

COPY --from=chifleytech/sqlcd-service-build /root/app.jar /root/

RUN mkdir /root/template
RUN mkdir /root/template/conf
RUN mkdir /root/template/drivers

RUN mkdir /root/conf/
RUN mkdir /root/drivers
RUN mkdir /root/logs

COPY application.conf /root/template/conf/
COPY logback-info.xml /root/template/conf/
COPY logback-warn.xml /root/template/conf/
COPY drivers /root/template/drivers

COPY run.sh /root/run.sh
RUN chmod 766 run.sh
EXPOSE 8080
EXPOSE 9090

CMD /root/run.sh
