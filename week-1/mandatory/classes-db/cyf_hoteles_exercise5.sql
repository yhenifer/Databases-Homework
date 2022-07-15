drop table if exists bookings;
drop table if exists hotels;
drop table if exists customers;

CREATE TABLE customers (
  id       SERIAL PRIMARY KEY,
  name     VARCHAR(30) NOT NULL,
  email    VARCHAR(120) NOT NULL,
  address  VARCHAR(120),
  city     VARCHAR(30),
  postcode VARCHAR(12),
  country  VARCHAR(20)
);

CREATE TABLE hotels (
  id       SERIAL PRIMARY KEY,
  name     VARCHAR(120) NOT NULL,
  rooms    INT NOT NULL,
  postcode VARCHAR(10)
);

CREATE TABLE bookings (
  id            SERIAL PRIMARY KEY,
  customer_id   INT REFERENCES customers(id),
  hotel_id      INT REFERENCES hotels(id),
  checkin_date  DATE NOT NULL,
  nights        INT NOT NULL
);

INSERT INTO customers (name, email, address, city, postcode, country) 
VALUES ('John Smith','j.smith@johnsmith.org','11 New Road','Liverpool','L10 2AB','UK');
INSERT INTO customers (name, email, address, city, postcode, country) 
VALUES ('Sue Jones','s.jones1234@gmail.com','120 Old Street','London','N10 3CD','UK');
INSERT INTO customers (name, email, address, city, postcode, country) 
VALUES ('Alice Evans','alice.evans001@hotmail.com','3 High Road','Manchester','m13 4ef','UK');
INSERT INTO customers (name, email, address, city, postcode, country) 
VALUES ('Mohammed Trungpa','mo.trungpa@hotmail.com','25 Blue Road','Manchester','M25 6GH','UK');
INSERT INTO customers (name, email, address, city, postcode, country) 
VALUES ('Steven King','steve.king123@hotmail.com','19 Bed Street','Newtown', 'xy2 3ac','UK');
INSERT INTO customers (name, email, address, city, postcode, country) 
VALUES ('Nadia Sethuraman','nadia.sethuraman@mail.com','135 Green Street','Manchester','M10 4BG','UK');
INSERT INTO customers (name, email, address, city, postcode, country) 
VALUES ('Melinda Marsh','mel.marsh-123@gmail.com','7 Preston Road','Oldham','OL3 5XZ','UK');
INSERT INTO customers (name, email, address, city, postcode, country) 
VALUES ('Martín Sommer','martin.sommer@dfgg.net','C/ Romero, 33','Madrid','28016','Spain');
INSERT INTO customers (name, email, address, city, postcode, country) 
VALUES ('Laurence Lebihan','laurence.lebihan@xmzx.net','12, rue des Bouchers','Marseille','13008','France');
INSERT INTO customers (name, email, address, city, postcode, country) 
VALUES ('Keith Stewart','keith.stewart@gmail.com','84 Town Lane','Tadworth','td5 7ng','UK');

INSERT INTO hotels (name, rooms, postcode) 
VALUES ('Golden Cavern Resort', 10, 'L10ABC');
INSERT INTO hotels (name, rooms, postcode) 
VALUES ('Elder Lake Hotel', 5, 'L10ABC');
INSERT INTO hotels (name, rooms, postcode) 
VALUES ('Pleasant Mountain Hotel', 7, 'ABCDE1');
INSERT INTO hotels (name, rooms, postcode) 
VALUES ('Azure Crown Resort & Spa', 18, 'DGQ127');
INSERT INTO hotels (name, rooms, postcode) 
VALUES ('Jade Peaks Hotel', 4, 'DGQ127');
INSERT INTO hotels (name, rooms, postcode) 
VALUES ('Elegant Resort', 14, 'DGQ127');
INSERT INTO hotels (name, rooms, postcode) 
VALUES ('Cozy Hotel', 20, 'AYD189');
INSERT INTO hotels (name, rooms, postcode) 
VALUES ('Snowy Echo Motel', 15, 'AYD189');

INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) 
VALUES (1, 1, '2019-10-01', 2);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) 
VALUES (1, 1, '2019-12-10', 6);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) 
VALUES (1, 3, '2019-07-20', 4);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) 
VALUES (2, 3, '2020-03-10', 4);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) 
VALUES (2, 5, '2020-04-01', 1);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) 
VALUES (3, 1, '2019-11-01', 1);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) 
VALUES (3, 2, '2019-11-23', 2);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) 
VALUES (4, 8, '2019-12-23', 3);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) 
VALUES (4, 2, '2019-09-16', 5);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) 
VALUES (6, 5, '2019-09-14', 2);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) 
VALUES (6, 6, '2020-01-14', 5);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) 
VALUES (8, 4, '2020-02-01', 3);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) 
VALUES (8, 5, '2020-01-03', 7);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) 
VALUES (8, 8, '2019-12-25', 4);

--Week1

SELECT * FROM customers WHERE name = 'Laurence Lebihan';
SELECT * FROM customers WHERE country = 'UK';
SELECT address, city, postcode FROM customers WHERE name = 'Melinda Marsh';
SELECT * FROM hotels WHERE postcode = 'DGQ127';
SELECT * FROM hotels WHERE rooms > 11;
SELECT * FROM hotels WHERE rooms > 6 AND rooms < 15;
SELECT * FROM hotels WHERE rooms = 10 OR rooms = 20;
SELECT * FROM bookings WHERE customer_id = 1;
SELECT * FROM bookings WHERE nights > 4;
SELECT * FROM bookings WHERE checkin_date > '2020/01/01';
SELECT * FROM bookings WHERE checkin_date > '2020/01/01' AND nights < 4;

SELECT * FROM customers
SELECT * FROM test

--Week2
--Exercise1
ALTER TABLE customers ADD COLUMN date_of_birth DATE;
ALTER TABLE customers RENAME COLUMN date_of_birth TO birthdate;
ALTER TABLE customers DROP COLUMN birthdate;


--Exercise2:
CREATE TABLE test ();
DROP TABLE test;
UPDATE customers SET name='Bob Marley', country='Jamaica' WHERE id=3;
SELECT * FROM customers;

--Exercise3
UPDATE hotels SET postcode='L10XYZ' WHERE name='Elder Lake Hotel';
--3.2
UPDATE hotels SET rooms=25 WHERE name='Cozy Hotel';
--3.3
UPDATE customers SET address='2 Blue Street', city='Glasgow', postcode='G11ABC' WHERE name='Nadia Sethuraman';
--3.4
UPDATE bookings SET nights=5 WHERE customer_id=1 AND hotel_id=1


SELECT COUNT(*) FROM bookings WHERE customer_id=1 AND hotel_id=1; 
--COUNT comando para contar cuantas reservas tiene el  cliente 1  en el hotel 1--

SELECT * FROM customers
SELECT * FROM hotels
SELECT * FROM bookings

--Exercise4
--4.1
DELETE FROM bookings WHERE customer_id=8 AND checkin_date='2020-01-03';
--4.2
DELETE FROM bookings WHERE customer_id=6;
--4.3
DELETE FROM customers WHERE id=6;

--Exercise5
--5.2
SELECT * FROM customers 
INNER JOIN bookings ON customers.id=bookings.customer_id 
WHERE bookings.checkin_date>'2020-01-01';

--5.3
SELECT c.name, b.checkin_date AS checkInDate, b.nights 
FROM customers AS c
INNER JOIN bookings AS b ON c.id=b.customer_id 
INNER JOIN hotels AS h ON h.id=b.hotel_id 
WHERE h.name='Jade Peaks Hotel';

--5.4
SELECT c.name, b.checkin_date, h.name 
FROM bookings AS b
INNER JOIN customers AS c ON c.id=b.customer_id
INNER JOIN hotels AS h ON h.id=b.hotel_id 
WHERE b.nights>=5;

--Exercise6 
--6.1
SELECT name FROM customers WHERE name LIKE 'S%';
--6.2
SELECT name FROM hotels WHERE name LIKE '%Hotel%';
--6.3
SELECT b.checkin_date, c.name, h.name
FROM bookings AS b
INNER JOIN customers AS c ON b.customer_id=c.id
INNER JOIN hotels AS h ON b.hotel_id=h.id
ORDER BY b.nights DESC
LIMIT 5;
