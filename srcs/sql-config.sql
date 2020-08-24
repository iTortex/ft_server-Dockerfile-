CREATE DATABASE local_base;
CREATE USER 'amarcele'@'localhost' IDENTIFIED BY 'root';
GRANT ALL PRIVILEGES ON local_base.* TO 'amarcele'@'localhost';
FLUSH PRIVILEGES;
UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE user='amarcele';