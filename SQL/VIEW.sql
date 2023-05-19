-- This Transact-SQL script creates all tables that are used
-- in this lab
-- It loads also all data in the four existing tables.

-- NOTE, please !!
-- Create first the database (sample), using CREATE DATABASE statement 

USE sample;
CREATE TABLE employee  (emp_no INTEGER NOT NULL, 
                        emp_fname CHAR(20) NOT NULL,
                        emp_lname CHAR(20) NOT NULL,
                        dept_no CHAR(4) NULL);

CREATE TABLE department(dept_no CHAR(4) NOT NULL,
                        dept_name CHAR(25) NOT NULL,
                        location CHAR(30) NULL);

CREATE TABLE project   (project_no CHAR(4) NOT NULL,
                        project_name CHAR(15) NOT NULL,
                        budget FLOAT NULL);

CREATE TABLE works_on	(emp_no INTEGER NOT NULL,
                        project_no CHAR(4) NOT NULL,
                        job CHAR (15) NULL,
                        enter_date DATE NULL);

insert into employee values(25348, 'Matthew', 'Smith',    'd3');
insert into employee values(10102, 'Ann',     'Jones',    'd3');
insert into employee values(18316, 'John',    'Barrimore','d1');
insert into employee values(29346, 'James',   'James',    'd2');
insert into employee values(9031,  'Elke',    'Hansel',   'd2');
insert into employee values(2581,  'Elsa',    'Bertoni',  'd2');
insert into employee values(28559, 'Sybill',  'Moser',    'd1');

insert into department values ('d1', 'Research',   'Dallas');
insert into department values ('d2', 'Accounting', 'Seattle');
insert into department values ('d3', 'Marketing',  'Dallas');

insert into project values ('p1', 'Apollo', 120000.00);
insert into project values ('p2', 'Gemini', 95000.00);
insert into project values ('p3', 'Mercury', 186500.00);

insert into works_on values (10102, 'p1',  'Analyst',   '2016.10.1');
insert into works_on values (10102, 'p3',  'Manager',   '2018.1.1');
insert into works_on values (25348, 'p2',  'Clerk',     '2017.2.15');
insert into works_on values (18316, 'p2',  NULL,        '2017.6.1');
insert into works_on values (29346, 'p2',  NULL,        '2016.12.15');
insert into works_on values (2581,  'p3',  'Analyst',   '2017.10.15');
insert into works_on values (9031,  'p1',  'Manager',   '2017.4.15');
insert into works_on values (28559, 'p1',  NULL,        '2017.8.1');
insert into works_on values (28559, 'p2',  'Clerk',     '2018.2.1')
insert into works_on values (9031,  'p3',  'Clerk',     '2016.11.15');  
insert into works_on values (29346, 'p1',  'Clerk',     '2017.1.4');

SELECT * FROM employee;
SELECT * FROM project;
SELECT * FROM department;
SELECT * FROM works_on; 

-- VIEW EXAMPLES
--1. Create a view that comprises the data of all employees who work for the department d1.
GO
CREATE VIEW V_1
AS SELECT *
FROM EMPLOYEE
WHERE dept_no = 'D1';
GO

SELECT * FROM V_1;
SELECT EMP_FNAME, EMP_LNAME FROM V_1;

--2. For the project table, create a view that can be used by employees who are allowed to view all data of this table except the budget column.
GO
CREATE VIEW V_2
AS SELECT PROJECT_NO, PROJECT_NAME
FROM PROJECT;
GO

SELECT * FROM V_2;
SELECT PROJECT_NAME FROM V_2;
-- ERROR BECAUSE VIEW OF BUDGET IS HIDDEN 
SELECT BUDGET FROM V_2;

--3. Create a view that comprises the first and last names of all employees who entered their projects in the second half of the year 2017.
GO
CREATE VIEW V_3
AS SELECT EMP_FNAME, EMP_LNAME, ENTER_DATE
FROM EMPLOYEE E JOIN WORKS_ON W
ON E.emp_no = W.emp_no
WHERE enter_date BETWEEN '06/01/2017' AND '12/31/2017';
GO

SELECT * FROM V_3;
-- NO INFORMATION, VIEW ONLY DISPLAYS INFO FROM JUNE TO DEC 
SELECT * FROM V_3
WHERE enter_date = '10/01/2016';


--4. Solve Exercise 3 so that the original columns f_name and l_name have NEW NAMES in the view: FIRST and LAST, respectively.
GO
--NEW COLUMN NAMES
CREATE VIEW V_4(FIRST, LAST)
AS SELECT EMP_FNAME, EMP_LNAME
FROM V_3;
GO

SELECT * FROM V_4;

--5. Use the view in Exercise 1 to display full details of every employee whose last name begins with the letter M.
GO
CREATE VIEW V_5
AS SELECT * 
FROM V_1
WHERE emp_lname LIKE 'M%';
GO

SELECT * FROM V_5;

--6. Create a view that comprises full details of all projects on which the employee named Smith works.
-- JOIN TABLES PROJECT, WORKS_ON, EMPLOYEE
GO
CREATE VIEW V_6
AS SELECT P.*
FROM project P JOIN works_on W
-- PK PROJECT_NO
ON P.project_no = W.project_no
JOIN employee E
-- PK EMP_NO
ON W.emp_no = E.emp_no
WHERE emp_lname = 'SMITH';
GO

SELECT * FROM V_6;

--7. Using the ALTER VIEW statement modify the condition in the view in Exercise 1. The modified view should comprise the data of all employees who work for department d1, department d2, or both.
GO 
ALTER VIEW V_1
AS SELECT *
FROM employee
WHERE dept_no IN ('D1','D2');
GO

SELECT * FROM V_1;

--8. Delete the view created in Exercise 3. What happens with the view created in Exercise 4?
-- V_4 STILL EXISTS BUT WILL NOT BE EXECUTED. V_4 DEPENDS ON V_3
DROP VIEW V_3;

SELECT * FROM V_4;

--9. Using the view from Exercise.2, insert the details of the new project with the project number p2 and the name Moon. Check project table
INSERT INTO V_2 VALUES ('p2', 'Moon');
SELECT * FROM V_2;

--10. Create a view (with the WITH CHECK OPTION clause) that comprises the first and last names of all employees whose employee number is less than 10,000. After that, use the view to insert data for a new employee named Kohn with the employee number 22123, who works for the department d3.
GO
CREATE VIEW V_10(FIRST, LAST)
AS SELECT EMP_FNAME, EMP_LNAME
FROM employee
WHERE emp_no < 10000
WITH CHECK OPTION;
GO
-- ADD EMP_NO AND DEP_NO (ALTER VIEW)
GO
ALTER VIEW V_10(EMP_NUM, FIRST_NAME, LAST_NAME, DEPARTMENT_NO)
AS SELECT emp_no, emp_fname, emp_lname, dept_no
FROM employee
WHERE emp_no < 10000
WITH CHECK OPTION;
GO

SELECT * FROM V_10;
--22123 > 10000 will not execute WITH CHECKP OPTION
INSERT INTO V_10 VALUES (22123, 'Kohn', 'Smith', 'd3');

--11. Solve Exercise 10 without the WITH CHECK OPTION clause and find the differences in relation to the insertion of the data.
GO
CREATE VIEW V_11(EMP_NUM, FIRST_NAME, LAST_NAME, DEPARTMENT_NO)
AS SELECT emp_no, emp_fname, emp_lname, dept_no
FROM employee
WHERE emp_no < 10000;
GO

SELECT * FROM V_11;
INSERT INTO V_11 VALUES (22123, 'MICHEAL', 'KOHN', 'D3');
-- WORKS BUT THE VALUES OF EMPLOYEE COLUMN WON'T BE CHECKED 

--12. Create a view (with the WITH CHECK OPTION clause) with full details from the works_on table for all employees who entered their projects during the years 2017 and 2018. After that, modify the entering date of Technet24 the employee with the employee number 29346. The new date is 06/01/2016.
GO
CREATE VIEW V_12
AS SELECT EMP_NO, PROJECT_NO, ENTER_DATE, JOB
FROM works_on
WHERE enter_date BETWEEN '01/01/2017' AND '12/31/2018'
WITH CHECK OPTION;
GO

SELECT * FROM V_12; 

-- UPDATE DOESN'T WORK BECAUSE DOESN'T BELONG TO DATES BETWEEN '01/01/2017' AND '12/31/2018'
UPDATE V_12
SET ENTER_DATE = '01/01/2021'
WHERE EMP_NO = 29346;

--13. Solve Exercise 12 without the WITH CHECK OPTION clause and find the differences in relation to the modification of the data
GO
CREATE VIEW V_13
AS SELECT EMP_NO, PROJECT_NO, ENTER_DATE, JOB
FROM works_on
WHERE enter_date BETWEEN '01/01/2017' AND '12/31/2018'
GO

UPDATE V_13
SET ENTER_DATE = '01/01/2016'
WHERE EMP_NO = 29346;

SELECT * FROM V_13; 
SELECT * FROM works_on;
-- WORKS BECAUSE NO WITH CHECK OPTION 
-- UPDATE ORIGINAL TABLE 