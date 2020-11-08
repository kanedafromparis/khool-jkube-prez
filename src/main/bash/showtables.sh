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

docker exec -it \
    mariadb-1 \
    sh -c 'echo "select * from todo_item;" | \
    mysql -uroot -p"$MYSQL_ROOT_PASSWORD" db_todo'