#!/bin/bash
#
# This bach is a trick to getaround quote hell
# use it with 
# watch -n 2 bash showtables.sh
#
# Remember
#(optional)
# docker-machine create prez-fabric8-dmp`
#`eval $(docker-machine env prez-fabric8-dmp) && \`
#`docker-machine ip prez-fabric8-dmp `
#
#eval $(minikube -p khool-jkube-prez docker-env)


docker run -it \
    --link todo-mariadb:mysql \
    --rm mariadb:10.3.10 \
    sh -c 'echo "select * from todo_item;" | \
    mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" \
    -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD" db_todo'