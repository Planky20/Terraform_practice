CREATE TABLE Course
(
  CourseID int,
  CourseName varchar(1000),
  Rating numeric(2,1)
);

INSERT INTO Course (CourseID, CourseName, Rating) VALUES (1, 'Docker for frogs', 4.8);
INSERT INTO Course (CourseID, CourseName, Rating) VALUES (2, 'Kubernetes for frogs', 4.9);
insert into Course (CourseID, CourseName, Rating) values (3, 'Azure for frogs', 4.3);