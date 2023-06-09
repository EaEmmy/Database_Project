
CREATE TABLE hotel( 
hotelno CHAR(4) PRIMARY KEY, 
hotelname VARCHAR(20) NOT NULL, 
city VARCHAR(20) NOT NULL 
);
CREATE TABLE room(
roomno char(4),
hotelno char(4),
rtype varchar(10),
price numeric  (5,2),
primary key (roomno, hotelno),
foreign key (hotelno) REFERENCES hotel(hotelno)
);
CREATE TABLE guest( 
guestno CHAR(5) PRIMARY KEY, 
guestname VARCHAR(20) NOT NULL, 
guestaddress VARCHAR(50) NOT NULL 
);
CREATE TABLE booking(
hotelno char(4),
guestno char(5),
datefrom date,
dateto date,
roomno char(4),
primary key (hotelno, guestno, datefrom),
foreign key (hotelno) REFERENCES hotel(hotelno),
foreign key (guestno) REFERENCES guest(guestno),
foreign key (roomno, hotelno) REFERENCES room(roomno,hotelno)
);
insert into hotel values('fb01', 'Grosvenor', 'London');
insert into hotel values('fb02', 'Watergate', 'Paris');
insert into hotel values('ch01', 'Omni Shoreham', 'London');
insert into hotel values('ch02', 'Phoenix Park', 'London');
insert into hotel values('dc01', 'Latham', 'Berlin');
insert into room values('501', 'fb01', 'single', 19);
insert into room values('601', 'fb01', 'double', 29);
insert into room values('701', 'fb01', 'family', 39);
insert into room values('1001', 'fb02', 'single', 58);
insert into room values('1101', 'fb02', 'double', 86);
insert into room values('1001', 'ch01', 'single', 29.99);
insert into room values('1101', 'ch01', 'family', 59.99);
insert into room values('701', 'ch02', 'single', 10);
insert into room values('801', 'ch02', 'double', 15);
insert into room values('901', 'dc01', 'single', 18);
insert into room values('1001', 'dc01', 'double', 30);
insert into room values('1101', 'dc01', 'family', 35);
insert into guest values('10001', 'John Kay', '56 High St, London');
insert into guest values('10002', 'Mike Ritchie', '18 Tain St, London');
insert into guest values('10003', 'Mary Tregear', '5 Tarbot Rd, Aberdeen');
insert into guest values('10004', 'Joe Keogh', '2 Fergus Dr, Aberdeen');
insert into guest values('10005', 'Carol Farrel', '6 Achray St, Glasgow');
insert into guest values('10006', 'Tina Murphy', '63 Well St, Glasgow');
insert into guest values('10007', 'Tony Shaw', '12 Park Pl, Glasgow');
insert into booking values('fb01', '10001', '04-04-01',  '04-04-08', '501');
insert into booking values('fb01', '10004', '04-04-15' , '04-05-15', '601');
insert into booking values('fb01', '10005', '04-05-02', '04-05-07', '501');
insert into booking values('fb01', '10002','6-05-04', '04-05-29', '601');
insert into booking values('fb01', '10001', '04-05-01', null, '701');
insert into booking values('fb02', '10003', '04-04-05','10-04-04', '1001');
insert into booking values('fb02', '10005', '04-05-12','3-05-04', '1101');
insert into booking values('ch01', '10006', '04-04-21', null, '1101');
insert into booking values('ch02', '10002','04-04-25', '04-05-06', '801');
insert into booking values('dc01', '10007','04-05-13', '04-05-15', '1001');
insert into booking values('dc01', '10003', '04-05-20', null, '1001');



SELECT * FROM HOTEL;
SELECT * FROM ROOM;
SELECT * FROM GUEST;
SELECT * FROM BOOKING;

--1. List full details of all hotels in London. 
SELECT *
FROM HOTEL
WHERE UPPER(CITY) = 'LONDON';


-- 2. Find the highest list price of all rooms 
SELECT MAX(PRICE) MAX_PRICE
FROM ROOM;

--3. List the names and addresses of all guests in London, alphabetically ordered by name. 
SELECT GUESTNAME, GUESTADDRESS
FROM GUEST
WHERE UPPER(GUESTADDRESS) LIKE '%LONDON%'
ORDER BY GUESTNAME ; --DESC; --

--4. List all double or family rooms with a price below �40.00 per night, in ascending order of price
SELECT *
FROM ROOM
WHERE UPPER(RTYPE) IN ('DOUBLE', 'FAMILY') AND PRICE < 40;


-- 5. List the bookings for which no dateTo has been specified. 
SELECT *
FROM BOOKING
WHERE DATETO IS NULL;


-- 6. Find the guests whose name ends with the letter y. 
SELECT GUESTNAME
FROM GUEST
WHERE LOWER(GUESTNAME) LIKE '%y';



-- 7. Find the guests where the second character is the letter a. 

SELECT GUESTNAME
FROM GUEST
WHERE LOWER(GUESTNAME) LIKE '_a%';


-- 8. What is the average price of a room? 
SELECT ROUND(AVG(PRICE), 2) AVG_PRICE
FROM ROOM;

-- 9. What is the total revenue per night from all double rooms? 
SELECT SUM(PRICE) 'Total Revenue'
FROM ROOM
WHERE UPPER(RTYPE) ='DOUBLE';



-- 10. List the number of rooms in each hotel.

SELECT HOTELNO, COUNT(ROOMNO) 'Number of Rooms'
FROM ROOM
GROUP BY HOTELNO;