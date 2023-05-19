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
INSERT INTO Employee VALUES (5,'Hina', 6600, 'Female', 'Finance')CREATE TABLE LOGS
(ACTIVITY VARCHAR(20),
ACTIVITY_DATE DATETIME)select * from Employee
select * from Logs--3. Create After Trigger named trg_insert_log where, at the time of insertion in the "Employee" table, we insert a record in the "Logs" table. In your trigger action insert the values 
-- ('Data is inserted', getdate()) into Logs table. This trigger will be fired, whenever a new Employee is added to the system.GOCREATE TRIGGER trg_insert_log ON EMPLOYEEAFTER INSERT ASBEGIN	INSERT INTO LOGS VALUES('Data is inserted', getdate());END -- 4. Test your trigger by Inserting the following row in the "Employee" table: (Insert into Employee the VALUES(6,'Rahul',20000,'Female','Finance'). 
-- The trigger will be executed automatically. Check both tables and see.Insert into Employee VALUES (6,'Rahul',20000,'Female','Finance');-- 5. ALTER the preceding After Trigger (trg_insert_log) to be an INSTEAD OF trigger that executes an insertion into the "Logs" table when we fire the insertion query into the "Employee" table.
-- Test the trigger by inserting into Employee table the VALUES (7,'Bansal',10000,'male','IT')select * from Employee
select * from Logs---------------------------INSTEAD OF INSERT---------------------------------GOALTER TRIGGER trg_insert_log ON EMPLOYEEINSTEAD OF INSERTASBEGIN	INSERT INTO LOGS VALUES('Data is inserted', getdate())END; INSERT INTO EMPLOYEE VALUES (7,'Bansal',10000,'male','IT');-- 6. Create a trigger named trg_delemployee_record that should print 'DONT have permission to delete from that table' instead of deleting the row containing the employee name 
-- 'Pranaya' row from Employee table, the message in the trigger will be displayed.----------------------INSTEAD OF DELETE----------------------------------------GOCREATE TRIGGER trg_delemployee_record ON EMPLOYEEINSTEAD OF DELETEASBEGIN	PRINT'DONT have permission to delete from that table'END;DELETE FROM EMPLOYEEWHERE NAME = 'Papero'; select * from Employee
select * from Logs-- 7. Create a trigger trg_employee_res which should restrict the INSERT operation on the Employee table. 
-- To do so, you are simply rollback the transaction which will roll back the insert statement. PRINT 'YOU CANNOT PERFORM INSERT OPERATION'. 
-- Test your trigger by inserting the following: INSERT INTO Employee VALUES (8, ‘Saroj’, 7600, ‘Male’, ‘IT’)GOCREATE TRIGGER trg_employee_res ON EMPLOYEEFOR INSERT ASBEGIN	PRINT 'YOU CANNOT PERFORM INSERT OPERATION'	ROLLBACK TRANSACTIONEND;INSERT INTO Employee VALUES (8, 'Saroj', 7600, 'Male', 'IT');---------DISABLE TRIGGER-------DISABLE TRIGGER trg_insert_log ON EMPLOYEEselect * from Employee
select * from Logs-- 8. Create a trigger trg_reminder that prints a message to the client when anyone tries to add or change data in the Employee table select * from Employee
select * from LogsGOCREATE TRIGGER trg_reminder ON EMPLOYEEFOR INSERT, UPDATE, DELETEASPRINT 'NOTIFY EMPLOYEE! NO ADD/CHANGE!'INSERT INTO Employee VALUES (8, 'Saroj', 7600, 'Male', 'IT');UPDATE EMPLOYEESET NAME = 'Saroj'WHERE ID = 2;DISABLE TRIGGER trg_delemployee_record ON EMPLOYEE-- 9. Create the following Department table:CREATE TABLE Department
(Dept_name VARCHAR(20) primary key,
Dept_location VARCHAR(30))
INSERT INTO Department VALUES ('Finance', 'LONDON')
INSERT INTO Department VALUES ('IT','NEW YORK')
INSERT INTO Department VALUES ('HR','MONTREAL')
INSERT INTO Department VALUES ('ADMIN.','MONTREAL')SELECT * FROM Department;-- a) Then alter Employee table by adding a foreign key constraint on DEPARTMENT_NAME

ALTER TABLE EMPLOYEE
ADD CONSTRAINT EMP_DEPT_NAME FOREIGN KEY (Department_Name) REFERENCES Department

-- b) Now let’s create a trigger that shall fire upon the DELETE statement on the DEPARTMENT table. Your trigger must satisfy the following requirements:
-- c) a. Perform the action INSTEAD OF DELETE

--GO
--DISABLE TRIGGER trg_delemployee_record ON EMPLOYEEGOCREATE TRIGGER TRG_DEPT_DELETE ON DEPARTMENTINSTEAD OF DELETEASBEGIN	DECLARE @D_NAME VARCHAR(20)	DECLARE @COUNT INT	SELECT @D_NAME =  DEPT_NAME FROM deleted		SELECT @COUNT = COUNT(*) FROM EMPLOYEE		WHERE DEPARTMENT_NAME = @D_NAMEIF @COUNT = 0	DELETE FROM DEPARTMENT 	WHERE DEPT_NAME = @D_NAMEELSE 	PRINT'CANNOT DELETE, DEPARTMENT NAME IS REFERENCED IN EMPLOYEE TABLE'END;SELECT * FROM EMPLOYEE;SELECT * FROM Department;DELETE FROM Department WHERE Dept_name = 'ADMIN.'; DELETE FROM DepartmentWHERE DEPT_NAME = 'IT'


