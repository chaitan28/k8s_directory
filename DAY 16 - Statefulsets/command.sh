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