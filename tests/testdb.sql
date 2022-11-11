

CREATE USER 'testuser'@'localhost' IDENTIFIED BY  'pwd';
GRANT ALL ON tests.* TO 'testuser'@'localhost';
FLUSH PRIVILEGES ;
CREATE DATABASE IF NOT EXISTS tests;
