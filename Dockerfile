FROM openjdk:8-jdk

RUN apt-get update ;\
    apt-get install -y tzdata
COPY application.conf /root/
COPY --from=chifleytech/sql-cd /root/app.jar /root/

WORKDIR /root
EXPOSE 8080
EXPOSE 9090
CMD nohup /usr/local/openjdk-8/jre/bin/java -Dcom.sun.management.jmxremote.rmi.port=9090 -Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.port=9090 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.local.only=false -Djava.rmi.server.hostname=localhost -Dconfig.file=application.conf -cp /root/$DB/*:/root/app.jar com.simontuffs.onejar.Boot > /root/logs/out.log 2>&1
#docker build . -t chifleytech/service
#docker run -d -i -t chifleytech/service
#docker exec -it 3c5c4ba3eff8 /bin/bash