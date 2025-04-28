kubectl run mysql-client --image=bitnami/mysql:5.7 -i --rm --restart=Never -- bash -c " 
mysql -h mysql-0.mysql -uroot <<EOF
CREATE DATABASE test;
USE test;
CREATE TABLE messages (message VARCHAR(250));
INSERT INTO messages VALUES ('hello');
INSERT INTO messages VALUES ('hey');
EOF
"
# It pulls the bitnami/mysql:5.7 image.
# It runs a one-time mysql client connecting to your mysql-0.mysql headless service DNS.
# It creates the test database, messages table, and inserts some values.
# Then deletes the pod after execution (--rm).


kubectl run mysql-client --image=mysql:5.7 -i -t --rm --restart=Never -- \
  mysql -h mysql-read -e "SELECT * FROM test.messages"

# Run a one-time temporary pod using the mysql:5.7 image.
# Execute a MySQL query (SELECT * FROM test.messages) against the mysql-read service (which is your read-replica endpoint).
# Then exit and delete the pod immediately (--rm).

kubectl run mysql-client-loop --image=mysql:5.7 -i -t --rm --restart=Never -- \
  bash -ic "while sleep 1; do mysql -h mysql-read -e 'SELECT @@server_id,NOW(),message from test.messages'; done"


# Inside that pod, run a loop:

# Every 1 second, send a MySQL query:
# SELECT @@server_id, NOW(), message FROM test.messages

# This gives:
# @@server_id ➔ Tells which replica node you connected to.
# NOW() ➔ Current timestamp.
# message ➔ Data from your table.
# This is dynamically set during pod initialization (remember the init container with echo server-id=$((100 + $ordinal))?).
# mysql-0 ➔ server_id = 100
# mysql-1 ➔ server_id = 101
# mysql-2 ➔ server_id = 102