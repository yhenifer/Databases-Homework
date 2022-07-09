CREATE TABLE mentors (
  id           SERIAL PRIMARY KEY,
  name         VARCHAR(30) NOT NULL,
  yearsInG   INT,
  address      VARCHAR(120),
  favoriteLang      VARCHAR(120)
);

INSERT INTO mentors (name, yearsInG, address, favoriteLang )
             VALUES ('Yogi' , 6 ,'carrer sant pau 123 Manresa', 'React');
INSERT INTO mentors (name, yearsInG, address, favoriteLang )
            VALUES ('Xavi', 3 ,'carrer diputacion 47 Barcelona', 'Node');
INSERT INTO mentors (name, yearsInG, address, favoriteLang )
            VALUES ('Carles', 1 ,'carrer vic 3 Girona', 'JavaScript');
INSERT INTO mentors (name, yearsInG, address, favoriteLang )
            VALUES ('Nuria', 2 ,'carrer magi 14 Lleida', 'Node');
INSERT INTO mentors (name, yearsInG, address, favoriteLang )
            VALUES ('Valen', 9 ,'carrer pere III 123 Barcelona', 'JavaScript');

SELECT * FROM mentors;

 CREATE TABLE students (
  id            SERIAL PRIMARY KEY,
  name          VARCHAR(30) NOT NULL,
  address       VARCHAR(120),
  graduated     VARCHAR(30)NOT NULL
  );

INSERT INTO students (name, address, graduated  )
            VALUES ('Diego', 'carrer cardona 3  Manresa', 'si');
            
INSERT INTO students (name, address, graduated  )
            VALUES ('Ingrid', 'carrer vic 45  SantJuan', 'no');
            
INSERT INTO students (name, address, graduated  )
            VALUES ('Daniela', 'carrer cardene 124  Barcelona', 'si');
            
INSERT INTO students (name, address, graduated  )
            VALUES ('Martin', 'carrer diputacion 89  Vic', 'no');
            
INSERT INTO students (name, address, graduated  )
            VALUES ('Juana', 'carrer santjose 45  Barcelona', 'si');
            
INSERT INTO students (name, address, graduated  )
            VALUES ('Raquel', 'carrer juan bautista 13  Manresa', 'si');
            
INSERT INTO students (name, address, graduated  )
            VALUES ('Antonia', 'carrer gran via 90  Badalona', 'si');
            
INSERT INTO students (name, address, graduated  )
            VALUES ('Jorge', 'carrer nou 3  Badalona', 'si');
            
INSERT INTO students (name, address, graduated  )
            VALUES ('Alvaro', 'carrer magnet 67  Manresa', 'no');
            
INSERT INTO students (name, address, graduated  )
            VALUES ('Jose', 'carrer cos 6  Sant Juan', 'si');

SELECT * FROM students;

CREATE TABLE clases (  
  id            SERIAL PRIMARY KEY,
  mentor        VARCHAR(30) NOT NULL,
  topic         VARCHAR(20),     
  date          DATE NOT NULL,
  location      VARCHAR(20)
  );

INSERT INTO clases (mentor, topic, date, location)
            VALUES ('Yogi', 'JavaScript', '2022-01-15', 'Manresa');
INSERT INTO clases (mentor, topic, date, location)
            VALUES ('Xavi','React', '2022-02-15', 'Barcelona');
INSERT INTO clases (mentor, topic, date, location)
            VALUES ('Carles', 'Node' ,'2022-03-15','Girona');
INSERT INTO clases (mentor, topic, date, location)
            VALUES ('Nuria', 'SQL', '2022-04-15','Lleida');
INSERT INTO clases (mentor, topic, date, location)
            VALUES ('Valen', 'Node','2022-05-15','Barcelona'); 

SELECT * FROM clases;

CREATE TABLE  attendees (
    id             SERIAL PRIMARY KEY,
    student_id     INT REFERENCES students(id),
    class_id       INT REFERENCES clases(id)
  );

INSERT INTO attendees (student_id,class_id)
                VALUES (1,      1),
                       (2,      2),
                       (3,      3),
                       (4,      4),
                       (5,      5),
                       (6,      5),
                       (7,      4),
                       (8,      3),
                       (9,      2),
                       (10,     1);

SELECT * from attendees ;

SELECT name, yearsInG    FROM mentors WHERE yearsInG    > 5;

SELECT name, favoriteLang       FROM mentors WHERE favoriteLang       = 'JavaScript';

SELECT name FROM students WHERE graduated = 'si';

SELECT * FROM clases WHERE date < '2022-06-01';

SELECT student_id FROM attendees
WHERE class_id = 1;

