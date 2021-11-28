# 被监控端代理

## 通过docker安装
``` 
// 主动检查
$ docker run --name some-zabbix-agent --link some-zabbix-server:zabbix-server \
-e ZBX_HOSTNAME="some-hostname" -e ZBX_SERVER_HOST="some-zabbix-server" \
--privileged -d zabbix/zabbix-agent2:latest

// example
$ docker run --name home-centos \
-e ZBX_HOSTNAME='home-centos' -e ZBX_SERVER_HOST='121.5.254.176' -e ZBX_ACTIVESERVERS='121.5.254.176' \
--privileged -d zabbix/zabbix-agent2:latest
``` 