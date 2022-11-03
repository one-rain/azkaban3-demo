#!/bin/bash

azkaban_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

function start() {
    if cd "${azkaban_dir}"/azkaban-exec-server && sudo ./bin/start-exec.sh; then
        echo "success start azkaban-exec-server, will activate server..."
        sleep 3s
        cur_port=$(cat ./executor.port)
        echo "port: ${cur_port}"
        result=$(curl http://127.0.0.1:"${cur_port}"/executor?action=activate)
        echo "$status"
        status=$(echo "${result}" | jq '.status' | xargs)
        if [ "${status}" == "success" ]; then
          echo "success activate, will start azkaban-web-server.."
          if cd "${azkaban_dir}"/azkaban-web-server && sudo ./bin/start-web.sh; then
            echo "success start azkaban-web-server"
          else
            echo "start azkaban-web-server failed."
          fi 
        fi
    else
        echo "star azkaban-exec-server failed."
        exit
    fi
}

function stop() {
    if cd "${azkaban_dir}"/azkaban-web-server && sudo ./bin/shutdown-web.sh; then
        echo "success stop azkaban-web-server, will stop azkaban-exec-server."
    else
        echo "stop azkaban-web-server failed."
    fi

    if cd "${azkaban_dir}"/azkaban-exec-server && sudo ./bin/shutdown-exec.sh; then
        cd "${azkaban_dir}"/azkaban-exec-server && sudo rm -rf ./executor.port
        echo "success stop azkaban-exec-server"
    else
        echo "stop azkaban-exec-server failed."
    fi
}

case "${1}" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart)
    stop
    start
    ;;
  *)
    echo "Error args, please use start | stop | restart"
    exit
esac