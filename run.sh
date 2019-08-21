#!/usr/bin/env bash

#if [ -f /root/drivers ]; then
if [ -z "$(ls -A /root/drivers)" ]; then
    cp -r /root/template/drivers/* /root/drivers
fi

if [ -z "$(ls -A /root/conf)" ]; then
    cp -r /root/template/conf/* /root/conf
fi


nohup /usr/local/openjdk-8/jre/bin/java \
-Dlogback.configurationFile=/root/conf/logback-$LOG_LEVEL.xml \
-Dconfig.file=/root/conf/application.conf \
-Dcom.sun.management.jmxremote.rmi.port=9090 \
-Dcom.sun.management.jmxremote=true \
-Dcom.sun.management.jmxremote.port=9090 \
-Dcom.sun.management.jmxremote.ssl=false \
-Dcom.sun.management.jmxremote.authenticate=false \
-Dcom.sun.management.jmxremote.local.only=false \
-Djava.rmi.server.hostname=localhost \
-cp /root/drivers/*:/root/app.jar \
com.simontuffs.onejar.Boot > /root/logs/out.log 2>&1
