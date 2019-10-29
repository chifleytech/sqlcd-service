#!/usr/bin/env bash

if [[ -z "${JRE_HOME}" ]]; then
  echo "PLEASE SET JRE_HOME"
  export JAVA_BIN="java"
else
  export JAVA_BIN=${JRE_HOME}/bin/java 
fi
 echo "Using Java binary "$JAVA_BIN

if [[ -z "${SQLCD_HOME}" ]]; then
  export SQLCD_HOME="."
fi

if [[ -z "${HOSTNAME}" ]]; then
  export HOSTNAME="localhost"
fi

if [[ -z "${LOG_LEVEL}" ]]; then
  export LOG_LEVEL="INFO"
fi

if [ -z "$(ls -A ${SQLCD_HOME}/drivers)" ]; then
    cp -r ${SQLCD_HOME}/template/drivers/* ${SQLCD_HOME}/drivers
fi

if [ -z "$(ls -A ${SQLCD_HOME}/conf)" ]; then
    cp -r ${SQLCD_HOME}/template/conf/* ${SQLCD_HOME}/conf
fi

export ESCAPED_SQLCD_HOME=$(echo ${SQLCD_HOME} | sed 's/\//\\\//g')
sed -i '' -e 's/${LOG_LEVEL}/'"${LOG_LEVEL}"'/g' ${SQLCD_HOME}/conf/logback.xml
sed -i '' -e 's/${SQLCD_HOME}/'"${ESCAPED_SQLCD_HOME}"'/g' ${SQLCD_HOME}/conf/application.conf

$JAVA_BIN \
-Dlogback.configurationFile=${SQLCD_HOME}/conf/logback.xml \
-Dconfig.file=${SQLCD_HOME}/conf/application.conf \
-Dcom.chifleytech.app=sqlcd \
-Dcom.sun.management.jmxremote.rmi.port=9090 \
-Dcom.sun.management.jmxremote=true \
-Dcom.sun.management.jmxremote.port=9090 \
-Dcom.sun.management.jmxremote.ssl=false \
-Dcom.sun.management.jmxremote.authenticate=false \
-Dcom.sun.management.jmxremote.local.only=false \
-Djava.rmi.server.hostname=$HOSTNAME \
-cp ${SQLCD_HOME}/drivers/*:${SQLCD_HOME}/sqlcd.jar \
com.simontuffs.onejar.Boot