CREATE DATABASE startersql;
USE startersql;
CREATE TABLE users (
id INT AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(100) NOT NULL,
 email VARCHAR(100) UNIQUE NOT NULL,
 gender ENUM('Male', 'Female', 'Other'),
 date_of_birth DATE,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
select * from users;
select id,name from users;
rename table users to programers;
select * from programers;
ALTER TABLE programers ADD COLUMN is_active BOOLEAN DEFAULT true;
SELECT * FROM programers;
ALTER TABLE programers DROP COLUMN is_active;
SELECT * FROM programers;
ALTER TABLE programers MODIFY COLUMN name VARCHAR(150);
ALTER TABLE programers MODIFY COLUMN email VARCHAR(100) AFTER id;
SELECT * FROM programers;





