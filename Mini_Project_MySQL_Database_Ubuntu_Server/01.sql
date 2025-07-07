-- Create the DB, the table and add relevant rows of information

CREATE DATABASE appdb;

-- Then use the context of the new database

USE appdb;

-- Create a table inside the database

CREATE TABLE Course 
(
 CourseID int,
 CourseName varchar (1000),
 Rating numeric (2,1)
);

-- Insert rows of data into the table

INSERT INTO Course (CourseID,CourseName,Rating) VALUES (1, 'Zupa Dyniowa', 4.5);

INSERT INTO Course (CourseID,CourseName,Rating) VALUES (1, 'Zupa Pomidorowa', 4.6);

INSERT INTO Course (CourseID,CourseName,Rating) VALUES (1, 'Barszcz', 5.0);

-- Also create new user and grant them access to the database

-- Create users for remote and local access (% for remote access, localhost for local access)
CREATE USER 'appusr'@'%' IDENTIFIED WITH mysql_native_password BY 'user password'; 
CREATE USER 'appusr'@'localhost' IDENTIFIED WITH mysql_native_password BY 'user password'; 

GRANT SELECT ON *.* TO 'appusr'@'localhost' WITH GRANT OPTION;
GRANT SELECT on *.* TO 'appusr'@'%' WITH GRANT OPTION;