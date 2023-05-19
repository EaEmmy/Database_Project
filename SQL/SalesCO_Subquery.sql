
CREATE TABLE VENDOR (  
V_CODE 		NUMERIC,  
V_NAME 		VARCHAR(35) NOT NULL,  
V_CONTACT 	VARCHAR(15) NOT NULL,  
V_AREACODE 	CHAR(3) NOT NULL,  
V_PHONE 	CHAR(8) NOT NULL,  
V_STATE 	CHAR(2) NOT NULL,  
V_ORDER 	CHAR(1) NOT NULL,  
PRIMARY KEY (V_CODE));

CREATE TABLE PRODUCT ( 
P_CODE 	VARCHAR(10) CONSTRAINT PRODUCT_P_CODE_PK PRIMARY KEY, 
P_DESCRIPT 	VARCHAR(35) NOT NULL, 
P_INDATE 	DATE NOT NULL, 
P_QOH 	  	NUMERIC NOT NULL, 
P_MIN 		NUMERIC NOT NULL, 
P_PRICE 	NUMERIC(8,2) NOT NULL, 
P_DISCOUNT 	NUMERIC(5,2) NOT NULL, 
V_CODE 		NUMERIC, 
CONSTRAINT PRODUCT_V_CODE_FK 
FOREIGN KEY (V_CODE) REFERENCES VENDOR);

CREATE TABLE CUSTOMER ( 
CUS_CODE	NUMERIC PRIMARY KEY, 
CUS_LNAME	VARCHAR(15) NOT NULL, 
CUS_FNAME	VARCHAR(15) NOT NULL, 
CUS_INITIAL	CHAR(1), 
CUS_AREACODE 	CHAR(3) DEFAULT '615' NOT NULL CHECK(CUS_AREACODE IN ('615','713','931')), 
CUS_PHONE	CHAR(8) NOT NULL, 
CUS_BALANCE	NUMERIC(9,2) DEFAULT 0.00, 
CONSTRAINT CUS_UI1 UNIQUE(CUS_LNAME,CUS_FNAME));

CREATE TABLE INVOICE ( 
INV_NUMBER     	NUMERIC PRIMARY KEY, 
CUS_CODE	NUMERIC NOT NULL REFERENCES CUSTOMER(CUS_CODE), 
INV_DATE  	DATE DEFAULT GETDATE() NOT NULL, 
CONSTRAINT INV_CK1 CHECK (INV_DATE > ('01-JAN-2012')));



CREATE TABLE LINE ( 
INV_NUMBER 	NUMERIC NOT NULL, 
LINE_NUMBER	NUMERIC(2,0) NOT NULL, 
P_CODE		VARCHAR(10) NOT NULL, 
LINE_UNITS	NUMERIC(9,2) DEFAULT 0.00 NOT NULL, 
LINE_PRICE	NUMERIC(9,2) DEFAULT 0.00 NOT NULL, 
PRIMARY KEY (INV_NUMBER,LINE_NUMBER), 
FOREIGN KEY (INV_NUMBER) REFERENCES INVOICE ON DELETE CASCADE, 
FOREIGN KEY (P_CODE) REFERENCES PRODUCT(P_CODE), 
CONSTRAINT LINE_UI1 UNIQUE(INV_NUMBER, P_CODE));


-- VENDOR

INSERT INTO VENDOR VALUES(21225,'Bryson, Inc.'    ,'Smithson','615','223-3234','TN','Y');

INSERT INTO VENDOR VALUES(21226,'SuperLoo, Inc.'  ,'Flushing','904','215-8995','FL','N');

INSERT INTO VENDOR VALUES(21231,'DE Supply'     ,'Singh'   ,'615','228-3245','TN','Y');

INSERT INTO VENDOR VALUES(21344,'Gomez Bros.'     ,'Ortega'  ,'615','889-2546','KY','N');

INSERT INTO VENDOR VALUES(22567,'Dome Supply'     ,'Smith'   ,'901','678-1419','GA','N');

INSERT INTO VENDOR VALUES(23119,'Randsets Ltd.'   ,'Anderson','901','678-3998','GA','Y');

INSERT INTO VENDOR VALUES(24004,'Brackman Bros.'  ,'Browning','615','228-1410','TN','N');

INSERT INTO VENDOR VALUES(24288,'ORDVA, Inc.'     ,'Hakford' ,'615','898-1234','TN','Y');

INSERT INTO VENDOR VALUES(25443,'BK, Inc.'      ,'Smith'   ,'904','227-0093','FL','N');

INSERT INTO VENDOR VALUES(25501,'Damal Supplies'  ,'Smythe'  ,'615','890-3529','TN','N');

INSERT INTO VENDOR VALUES(25595,'Rubicon Systems' ,'Orton'   ,'904','456-0092','FL','Y');

-- Product

INSERT INTO PRODUCT VALUES('11QER/31','Power painter, 15 psi., 3-nozzle','03-NOV-2011', 8, 5,109.99,0.00,25595);

INSERT INTO PRODUCT VALUES('13-Q2/P2','7.25-in. pwr. saw blade','13-DEC-2011', 32, 15, 14.99,0.05,21344);

INSERT INTO PRODUCT VALUES('14-Q1/L3','9.00-in. pwr. saw blade','13-NOV-2011', 18, 12, 17.49,0.00,21344);

INSERT INTO PRODUCT VALUES('1546-QQ2','Hrd. cloth, 1/4-in., 2x50','15-JAN-2012', 15, 8, 39.95,0.00,23119);

INSERT INTO PRODUCT VALUES('1558-QW1','Hrd. cloth, 1/2-in., 3x50','15-JAN-2012', 23, 5, 43.99,0.00,23119);

INSERT INTO PRODUCT VALUES('2232/QTY','BD jigsaw, 12-in. blade','30-DEC-2011', 8, 5,109.92,0.05,24288);

INSERT INTO PRODUCT VALUES('2232/QWE','BD jigsaw, 8-in. blade','24-DEC-2011', 6,  5, 99.87,0.05,24288);

INSERT INTO PRODUCT VALUES('2238/QPD','BD cordless drill, 1/2-in.','20-JAN-2012', 12, 5, 38.95,0.05,25595);

INSERT INTO PRODUCT VALUES('23109-HB','Claw hammer','20-JAN-2012', 23, 10,  9.95,0.10,21225);

INSERT INTO PRODUCT VALUES('23114-AA','Sledge hammer, 12 lb.','02-JAN-2012',  8,  5, 14.40,0.05,NULL);

INSERT INTO PRODUCT VALUES('54778-2T','Rat-tail file, 1/8-in. fine','15-DEC-2011', 43, 20, 4.99,0.00,21344);

INSERT INTO PRODUCT VALUES('89-WRE-Q','Hicut chain saw, 16 in.','07-FEB-2012', 11, 5,256.99,0.05,24288);

INSERT INTO PRODUCT VALUES('PVC23DRT','PVC pipe, 3.5-in., 8-ft','20-FEB-2012',188, 75, 5.87,0.00,NULL);

INSERT INTO PRODUCT VALUES('SM-18277','1.25-in. metal screw, 25','01-MAR-2012',172, 75, 6.99,0.00,21225);

INSERT INTO PRODUCT VALUES('SW-23116','2.5-in. wd. screw, 50','24-FEB-2012',237,100, 8.45,0.00,21231);

INSERT INTO PRODUCT VALUES('WR3/TT3' ,'Steel matting, 4''x8''x1/6", .5" mesh','17-JAN-2012', 18, 5,119.95,0.10,25595);

-- Customer

INSERT INTO CUSTOMER VALUES(10010,'Ramas'   ,'Alfred','A' ,'615','844-2573',0);

INSERT INTO CUSTOMER VALUES(10011,'Dunne'   ,'Leona' ,'K' ,'713','894-1238',0);

INSERT INTO CUSTOMER VALUES(10012,'Smith'   ,'Kathy' ,'W' ,'615','894-2285',345.86);

INSERT INTO CUSTOMER VALUES(10013,'Olowski' ,'Paul'  ,'F' ,'615','894-2180',536.75);

INSERT INTO CUSTOMER VALUES(10014,'Orlando' ,'Myron' ,NULL,'615','222-1672',0);

INSERT INTO CUSTOMER VALUES(10015,'O''Brian','Amy'   ,'B' ,'713','442-3381',0);

INSERT INTO CUSTOMER VALUES(10016,'Brown'   ,'James' ,'G' ,'615','297-1228',221.19);

INSERT INTO CUSTOMER VALUES(10017,'Williams','George',NULL,'615','290-2556',768.93);

INSERT INTO CUSTOMER VALUES(10018,'Farriss' ,'Anne'  ,'G' ,'713','382-7185',216.55);

INSERT INTO CUSTOMER VALUES(10019,'Smith'   ,'Olette','K' ,'615','297-3809',0);

INSERT INTO INVOICE VALUES(1001,10014,'16-JAN-2012');

INSERT INTO INVOICE VALUES(1002,10011,'16-JAN-2012');

INSERT INTO INVOICE VALUES(1003,10012,'16-JAN-2012');

INSERT INTO INVOICE VALUES(1004,10011,'17-JAN-2012');

INSERT INTO INVOICE VALUES(1005,10018,'17-JAN-2012');

INSERT INTO INVOICE VALUES(1006,10014,'17-JAN-2012');

INSERT INTO INVOICE VALUES(1007,10015,'17-JAN-2012');

INSERT INTO INVOICE VALUES(1008,10011,'17-JAN-2012');

INSERT INTO LINE VALUES(1001,1,'13-Q2/P2',1,14.99);

INSERT INTO LINE VALUES(1001,2,'23109-HB',1,9.95);

INSERT INTO LINE VALUES(1002,1,'54778-2T',2,4.99);

INSERT INTO LINE VALUES(1003,1,'2238/QPD',1,38.95);

INSERT INTO LINE VALUES(1003,2,'1546-QQ2',1,39.95);

INSERT INTO LINE VALUES(1003,3,'13-Q2/P2',5,14.99);
 

INSERT INTO LINE VALUES(1005,1,'PVC23DRT',12,5.87);

INSERT INTO LINE VALUES(1006,1,'SM-18277',3,6.99);

INSERT INTO LINE VALUES(1006,2,'2232/QTY',1,109.92);

INSERT INTO LINE VALUES(1006,3,'23109-HB',1,9.95);

INSERT INTO LINE VALUES(1006,4,'89-WRE-Q',1,256.99);

INSERT INTO LINE VALUES(1007,1,'13-Q2/P2',2,14.99);

INSERT INTO LINE VALUES(1007,2,'54778-2T',1,4.99);

INSERT INTO LINE VALUES(1008,1,'PVC23DRT',5,5.87);

INSERT INTO LINE VALUES(1008,2,'WR3/TT3',3,119.95);

INSERT INTO LINE VALUES(1008,3,'23109-HB',1,9.95);


Select * from vendor;
Select * from PRODUCT;
Select * from CUSTOMER;
Select * from INVOICE;
Select * from LINE;

--	1. List the V_CODE and V_NAME of vendors that provide products using subquery
SELECT V_CODE, V_NAME
FROM VENDOR
WHERE V_CODE IN
				(SELECT V_CODE
				 FROM PRODUCT);

--	2. Find all products with a price greater than or equal to the average product price using a subquery 
SELECT *
FROM PRODUCT
WHERE P_PRICE >=
				(SELECT AVG(P_PRICE)
				 FROM PRODUCT);

--	3. List all products wiht the total quantity sold greater than the average quantity sold 
SELECT P_CODE, SUM(LINE_UNITS)
FROM LINE
GROUP BY P_CODE 
HAVING AVG(LINE_UNITS) > 
						(SELECT AVG(LINE_UNITS)
						 FROM LINE);
						 
--	4.	What product(s) have a price equal to the maximum product price using a subquery 
SELECT P_CODE, P_DESCRIPT, P_PRICE
FROM PRODUCT
WHERE P_PRICE =
				(SELECT MAX(P_PRICE)
				 FROM PRODUCT);

--	5.	What product(s) have the highest inventory value (inventory value = P_QOH * P_PRICE)
SELECT *
FROM PRODUCT
WHERE P_QOH * P_PRICE =
						(SELECT MAX(P_QOH * P_PRICE)
						 FROM PRODUCT);

--	6.	List products that have a product cost that is greater than all individual product costs for products provided by vendors from Florida.
SELECT P_CODE, P_DESCRIPT, P_PRICE, P_QOH
FROM PRODUCT
WHERE P_PRICE > ALL 
					(SELECT P_PRICE 
					 FROM PRODUCT 
					 WHERE V_CODE IN
									(SELECT V_CODE
									 FROM VENDOR
									 WHERE V_STATE = 'FL'));

--	7. List the product prices rounded to one decimal place
SELECT P_CODE, ROUND(P_PRICE, 1)
FROM PRODUCT;

--	8.	What products have a price that exceeds the average product price using a subquery
SELECT P_PRICE, P_CODE
FROM PRODUCT
WHERE P_PRICE > 
				(SELECT AVG(P_PRICE)
				FROM PRODUCT);

--	9.	List products with vendor data for products purchased after 15-JAN-2010 - USE JOIN
SELECT P_CODE, P_PRICE, V_NAME, P_INDATE
FROM PRODUCT P JOIN VENDOR V
ON P.V_CODE = V.V_CODE
WHERE P_INDATE > '15-JAN-2010';

-- using subquery
SELECT P_CODE, P_PRICE, V_NAME, P_INDATE
FROM PRODUCT P JOIN VENDOR V
ON P.V_CODE = V.V_CODE
WHERE P_INDATE > ALL (SELECT P_INDATE
					  FROM PRODUCT 
					  WHERE P_INDATE = '15-JAN-2010');

-- LIST ALL INVOICE DATA FOR CUSTOMER NUMBER 10014
SELECT CUS_LNAME, CUS_FNAME, I.INV_NUMBER, INV_DATE, P_DESCRIPT, LINE_UNITS
FROM CUSTOMER C JOIN INVOICE I
ON C.CUS_CODE = I.CUS_CODE
JOIN LINE L
ON L.INV_NUMBER = I.INV_NUMBER
JOIN PRODUCT P
ON L.P_CODE = P.P_CODE
WHERE C.CUS_CODE = '10014';

--	Use the following statements to generate the appropriate SQL command (only one SQL statement)
-- 1. - Aggregate the total cost of products for each vendor
-- 2. - Select only the rows having a total cost greater than 500
-- 3. - List the results in descending order byt total cost 
SELECT V_CODE, SUM(P_PRICE) AS SUM_PRICE 
FROM PRODUCT 
GROUP BY V_CODE 
HAVING SUM(P_PRICE) > 500
ORDER BY SUM(P_PRICE);

