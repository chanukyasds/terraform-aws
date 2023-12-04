#!bin/bash

sudo touch /home/ubuntu/sample.txt

mkdir -p /home/ubuntu/.ssh
echo ${ssh_key} >> /home/ubuntu/.ssh/authorized_keys
chown -R ubuntu:ubuntu /home/ubuntu/.ssh
chmod 700 /home/ubuntu/.ssh
chmod 600 /home/ubuntu/.ssh/authorized_keys

sudo apt update

sudo apt install -y haproxy

cat << EOL > /etc/haproxy/haproxy.cfg
global
    maxconn 100
 
defaults
    log global
    mode tcp
    retries 2
    timeout client 30m
    timeout connect 4s
    timeout server 30m
    timeout check 5s
 
listen stats
    mode http
    bind *:7000
    stats enable
    stats uri /
 
listen postgresql_hosts
    bind *:5432
    option pgsql-check user ${username}
    server pg0  ${rds_endpoint} check port ${rds_port}
EOL

sudo systemctl restart haproxy