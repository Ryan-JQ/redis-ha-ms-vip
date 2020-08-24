# redis-ha-ms-vip

# Master
## Redis
tar -zxvf redis-5.0.9.tar.gz
make && make install
./install_server.sh
vi /etc/redis/6379.conf
/etc/init.d/redis_6379 restart
cp sentinel.conf /etc/redis
vi sentinel.conf
./redis-sentinel sentinel.conf
/usr/local/bin/redis-cli info
## Keepalived
yum install keepalived
cd /etc/keepalived/
vi keepalived.conf
systemctl start keepalived
netstat -alntp
## Rabbitmq
yum install erlang
rpm --import https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey
yum install rabbitmq-server
systemctl start rabbitmq-server
systemctl status rabbitmq-server
cd /etc/rabbitmq/
cp /usr/share/doc/rabbitmq-server-3.3.5/rabbitmq.config.example ./rabbitmq.config
cd /usr/lib/rabbitmq/lib/rabbitmq_server-3.3.5/
wget https://dl.bintray.com/rabbitmq/community-plugins/rabbitmq_delayed_message_exchange-0.0.1.ez
mv rabbitmq_delayed_message_exchange-0.0.1.ez plugins/
rabbitmq-plugins enable rabbitmq_management
systemctl enable rabbitmq-server
rabbitmq-plugins enable rabbitmq_delayed_message_exchange
systemctl restart rabbitmq-serve
rabbitmqctl add_user hongli hongli
rabbitmqctl set_user_tags hongli administrator
cat /var/lib/rabbitmq/.erlang.cookie
scp /var/lib/rabbitmq/.erlang.cookie root@10.250.44.17:/var/lib/rabbitmq/.erlang.cookie
chmod 600 .erlang.cookie
hostname rabbitmqa
rabbitmqctl stop_app
rabbitmqctl join_cluster rabbit@rabbitmqb
rabbitmqctl start_app
rabbitmqctl cluster_status
rabbitmqctl set_policy ha-all "^" '{ "ha-mode" : "all" }'

# Slave
## Redis
tar -zxvf redis-5.0.9.tar.gz
make && make install
./install_server.sh
vi /etc/redis/6379.conf
/etc/init.d/redis_6379 restart
cp sentinel.conf /etc/redis
vi sentinel.conf
./redis-sentinel sentinel.conf
/usr/local/bin/redis-cli info
## Keepalived
yum install keepalived
cd /etc/keepalived/
vi keepalived.conf
systemctl start keepalived
netstat -alntp
## Rabbitmq
yum install erlang
rpm --import https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey
yum install rabbitmq-server
cat /var/lib/rabbitmq/.erlang.cookie
cd /etc/rabbitmq/
cp /usr/share/doc/rabbitmq-server-3.3.5/rabbitmq.config.example ./rabbitmq.config
cd /usr/lib/rabbitmq/lib/rabbitmq_server-3.3.5/
wget https://dl.bintray.com/rabbitmq/community-plugins/rabbitmq_delayed_message_exchange-0.0.1.ez
mv rabbitmq_delayed_message_exchange-0.0.1.ez plugins/
rabbitmq-plugins enable rabbitmq_management
systemctl enable rabbitmq-server
rabbitmq-plugins enable rabbitmq_delayed_message_exchange
systemctl restart rabbitmq-server
rabbitmqctl add_user hongli hongli
rabbitmqctl set_user_tags hongli administrator
chmod 600 .erlang.cookie
hostname rabbitmqb
systemctl restart rabbitmq-server
rabbitmqctl list_policies
