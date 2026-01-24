#!/bin/bash

LOGFILE="/tmp/service_health.log"

services=("ssh" "cron" "systemd-journald")

log() {
   echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >>"$LOGFILE"
}
check_service() {
             local service=$1

             if systemctl is-active --quiet "$service"; then
             log "SERVICE OK: $service is running"
             echo "[OK] $service"
             else
             log "SERVIVCE DOWN: $service is not running"
             echo "[DOWN] $service"
             fi
}
log "Service Health Check Started"

for svc in "${services[@]}"; do
    check_service "$svc"
done


log "Service Health Check Completed"
