#!/bin/bash
# 检测 Nginx 容器是否存活
# 如果 Nginx 宕机，则停止 Keepalived，触发 VIP 漂移

nginx_status=$(docker ps --filter name=nginx --format '{{.Status}}' | grep -c "Up")

if [ $nginx_status -eq 0 ]; then
    echo "[$(date)] Nginx 容器已宕机，停止 Keepalived" >> /var/log/keepalived-nginx-check.log
    systemctl stop keepalived
    exit 1
fi

exit 0