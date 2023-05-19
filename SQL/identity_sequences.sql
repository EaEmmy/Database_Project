--------------IDENTITY----------
CREATE TABLE new_employees
(id_num int IDENTITY(100,1),
fname VARCHAR(20),
minit CHAR(1),
lname VARCHAR(30));

SELECT $identity
FROM new_employees
WHERE fname = 'Karin';

INSERT INTO new_employees (fname, minit, lname) VALUES ('Karin', 'F', 'Josephs');
INSERT INTO new_employees (fname, minit, lname) VALUES ('Pirkko', 'O', 'Koskitalo');

SELECT * FROM new_employees;

-------------SEQUENCES-------------
-- Starts ID by 100 up to 100000 
CREATE SEQUENCE EmpID AS INT
INCREMENT BY 1
START WITH 100
MAXVALUE 100000;

SET IDENTITY_INSERT NEW_EMPLOYEES ON
INSERT INTO new_employees(id_num, fname) VALUES(NEXT VALUE FOR EmpID, 'Jones Smith');

SELECT CURRENT_VALUE
FROM SYS.SEQUENCES
WHERE NAME = 'EmpID'

SELECT *
FROM SYS.SEQUENCES
WHERE NAME = 'EmpID'

-----LAB------

-- Create a New_customer table with 3 columns. One column (cus_code) must be an identity column. Insert 2 records to customer table
CREATE TABLE New_customer 
(cus_code int IDENTITY(100,1),
fname VARCHAR(20),
lname VARCHAR(30));

INSERT INTO New_customer(fname, lname) VALUES('Bob','Mankey');
INSERT INTO New_customer(fname, lname) VALUES('Bobbette','Smith');

SELECT * FROM New_customer;
-- Create a sequence named cust_num_seq to start with 1100, increment by 10
CREATE SEQUENCE cust_num_seq AS INT
START WITH 1100
INCREMENT BY 10;


-- Insert a new row in the New_customer table using the sequence created in #1 above to generate the value for CUS_CODE
-- Check the next value after the new row is inserted?'
-- TURN OTHER INSERTS OFF FIRST BY CHANGING ON TO OFF
SET IDENTITY_INSERT New_customer ON
INSERT INTO New_customer (cus_code, lname) VALUES(NEXT VALUE FOR cust_num_seq,'Smith');

SELECT NEXT VALUE FOR CUST_NUM_SEQ;
-- Create a sequence named New_num_seq. Test your sequence by inserting a new row in New_customer table
CREATE SEQUENCE New_num_seq AS INT
INCREMENT BY 5
MAXVALUE 200000;

SET IDENTITY_INSERT New_customer ON
INSERT INTO New_customer (cus_code, fname) VALUES(NEXT VALUE FOR New_num_seq, 'Billy Smith');

-- Check all of the sequences you have created
SELECT * FROM SYS.SEQUENCES WHERE NAME = 'NEW_NUM_SEQ';
SELECT * FROM SYS.SEQUENCES WHERE NAME = 'CUST_NUM_SEQ';
SELECT * FROM SYS.SEQUENCES;

-- Alter New_num_seq to restart with new value
ALTER SEQUENCE New_num_seq
RESTART WITH 1500
MAXVALUE 100000;

SELECT * FROM New_customer;

-- Drop the sequences created earlier
DROP SEQUENCE cust_num_seq;
DROP SEQUENCE New_num_seq;	
-------------------------------------------INDEX--------------------------------
-----drop table---
DROP TABLE new_employees;

--- HAS A KEY AND AN INDEX
CREATE TABLE new_employees
(id_num int IDENTITY(100,1) PRIMARY KEY,
fname VARCHAR(20),
minit CHAR(1),
lname VARCHAR(30));

INSERT INTO new_employees (fname, minit, lname) VALUES ('Karin', 'F', 'Josephs');
INSERT INTO new_employees (fname, minit, lname) VALUES ('Pirkko', 'O', 'Koskitalo');

-- Highlight SELECT statment and use Display Estimated Execution Plan (Ctrl+L)

-- Clustered index scan, with PK
SELECT * FROM new_employees
WHERE fname = 'Karin'; 

-- Table scan, no PK
SELECT * FROM New_customer 
WHERE fname = 'Bob';

------
CREATE INDEX new_employees_INDEX 
ON new_employees

