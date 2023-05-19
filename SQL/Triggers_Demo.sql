CREATE TABLE EMPLOYEE
(ID INT PRIMARY KEY,
NAME VARCHAR(30),
SALARY INT,
GENDER VARCHAR(10),
DEPARTMENT_NAME VARCHAR(20))
GO
-- Insert data into Employee table
INSERT INTO Employee VALUES (1,'Papero', 5000, 'Male', 'Finance')
INSERT INTO Employee VALUES (2,'Priyanka', 5400, 'Female', 'IT')
INSERT INTO Employee VALUES (3,'Anurag', 6500, 'male', 'IT')
INSERT INTO Employee VALUES (4,'Samon', 4700, 'Male', 'HR')
INSERT INTO Employee VALUES (5,'Hina', 6600, 'Female', 'Finance')
(ACTIVITY VARCHAR(20),
ACTIVITY_DATE DATETIME)
select * from Logs
-- ('Data is inserted', getdate()) into Logs table. This trigger will be fired, whenever a new Employee is added to the system.
-- The trigger will be executed automatically. Check both tables and see.
-- Test the trigger by inserting into Employee table the VALUES (7,'Bansal',10000,'male','IT')
select * from Logs
-- 'Pranaya' row from Employee table, the message in the trigger will be displayed.
select * from Logs
-- To do so, you are simply rollback the transaction which will roll back the insert statement. PRINT 'YOU CANNOT PERFORM INSERT OPERATION'. 
-- Test your trigger by inserting the following: INSERT INTO Employee VALUES (8, �Saroj�, 7600, �Male�, �IT�)
select * from Logs
select * from Logs
(Dept_name VARCHAR(20) primary key,
Dept_location VARCHAR(30))
INSERT INTO Department VALUES ('Finance', 'LONDON')
INSERT INTO Department VALUES ('IT','NEW YORK')
INSERT INTO Department VALUES ('HR','MONTREAL')
INSERT INTO Department VALUES ('ADMIN.','MONTREAL')

ALTER TABLE EMPLOYEE
ADD CONSTRAINT EMP_DEPT_NAME FOREIGN KEY (Department_Name) REFERENCES Department

-- b) Now let�s create a trigger that shall fire upon the DELETE statement on the DEPARTMENT table. Your trigger must satisfy the following requirements:
-- c) a. Perform the action INSTEAD OF DELETE

--GO
--DISABLE TRIGGER trg_delemployee_record ON EMPLOYEE

