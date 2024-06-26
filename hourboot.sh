#!/bin/bash
## Edit on crontab and put the code:
## "*/60    *       * * *   root    /bin/hourboot.sh"
LOG_FILE="/var/log/hourboot.log"
HOST="google.com"

function log() {
    local message=$1
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    local log_message="[$timestamp] - $message"

    echo $log_message >> $LOG_FILE
}

log "Iniciando reboot..."
MSG=`ping -qc3 $HOST | grep "PING\|pack" | tr '\n' ' ' | cut -d ' ' -f 1-3,13-15,17 | sed -e 's/, /,/' -e 's/) /),/'`
log "$MSG"
log "Reiniciando!" && sleep 5 && shutdown -r now
