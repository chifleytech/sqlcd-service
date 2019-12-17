FROM chifleytech/sqlcd-service-build:1.1.2

FROM openjdk:8-jdk

RUN apt-get update ;\
    apt-get install -y tzdata

WORKDIR /root

COPY --from=0 /root/app.jar /root/sqlcd.jar

RUN mkdir /root/template
RUN mkdir /root/template/conf
RUN mkdir /root/template/drivers

RUN mkdir /root/conf/
RUN mkdir /root/drivers
RUN mkdir /root/logs

COPY application.conf /root/template/conf/
COPY logback.xml /root/template/conf/
COPY drivers /root/template/drivers

COPY start-sqlcd.sh /root/start-sqlcd.sh
COPY stop-sqlcd.sh /root/stop-sqlcd.sh
COPY LICENSE /root/LICENCE

RUN chmod 766 start-sqlcd.sh
RUN chmod 766 stop-sqlcd.sh

EXPOSE 7080
EXPOSE 9090

# deploy to public repo
RUN mkdir /bare-metal-deploy
RUN cp -r /root/* /bare-metal-deploy

CMD /root/start-sqlcd.sh
