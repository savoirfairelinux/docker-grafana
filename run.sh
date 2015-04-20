#!/bin/bash

cd grafana-${GRAFANA_VERSION}


function create_db {
    curl --cookie-jar /tmp/cookiefile 'http://localhost/login' -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"user":"admin","email":"","password":"admin"}'

    curl --cookie /tmp/cookiefile 'http://localhost/api/datasources' -X PUT -H 'Content-Type: application/json;charset=utf-8' --data '{"name":"influxdb","type":"influxdb","url":"http://'${INFLUXDB_HOST}':'${INFLUXDB_PORT}'","access":"proxy","isDefault":true,"database":"'${INFLUXDB_NAME}'","user":"'${INFLUXDB_USER}'","password":"'${INFLUXDB_PASS}'"}'

    echo -e "Created InfluxDB datasources."

}

(sleep 30 && create_db)&

 ./bin/grafana-server -config="/grafana.ini"
