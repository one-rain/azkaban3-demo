#!/bin/bash

# shellcheck disable=SC1091
source /etc/profile

LOCAL_IP_INTER=$(/sbin/ifconfig -a | grep inet | grep -v 127.0.0.1 | grep -v inet6 | awk '{print $2}' | tr -d 'addr:' | awk 'NR==1')

function info() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") Info: $1"
}

function warn() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") Warn: $1"
}

function error() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") Error: $1"
}