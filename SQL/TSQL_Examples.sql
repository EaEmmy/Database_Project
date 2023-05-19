-- This Transact-SQL script creates all tables that are used
-- in this lab
-- It loads also all data in the four existing tables.

-- NOTE, please !!
-- Create first the database (sample), using CREATE DATABASE statement 

CREATE DATABASE sample;
USE sample;
CREATE TABLE employee  (emp_no INTEGER NOT NULL CONSTRAINT employee_emp_no_PK PRIMARY KEY, 
                        emp_fname CHAR(20) NOT NULL,
                        emp_lname CHAR(20) NOT NULL,
                        dept_no CHAR(4) NULL);

CREATE TABLE department(dept_no CHAR(4) NOT NULL CONSTRAINT department_dept_no_PK PRIMARY KEY,
                        dept_name CHAR(25) NOT NULL,
                        location CHAR(30) NULL);

CREATE TABLE project   (project_no CHAR(4) NOT NULL CONSTRAINT project_project_no_PK PRIMARY KEY,
                        project_name CHAR(15) NOT NULL,
                        budget FLOAT NULL);

CREATE TABLE works_on	(emp_no INTEGER NOT NULL CONSTRAINT works_on_emp_no_FK FOREIGN KEY REFERENCES employee (emp_no),
                        project_no CHAR(4) NOT NULL CONSTRAINT works_on_project_no_FK FOREIGN KEY REFERENCES project (project_no),
                        job CHAR (15) NULL,
                        enter_date DATE NULL
						CONSTRAINT works_on_PK PRIMARY KEY (emp_no, project_no));

ALTER TABLE employee
ADD CONSTRAINT department_dept_FK FOREIGN KEY(dept_no) REFERENCES department;

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

SELECT * FROM EMPLOYEE;
SELECT * FROM PROJECT;
SELECT * FROM DEPARTMENT;
SELECT * FROM WORKS_ON;

-- 1. Using a while statement, increase the budget of all projects by 10 percent until the sum of budgets is greater than $500,000. The repeated execution will be stopped if the budget of one of the
--projects is greater than $240,000.
USE sample;
WHILE(SELECT SUM(budget)
	  FROM project) > 500000
		BEGIN
			UPDATE project
			SET budget = budget*1.1
			IF(SELECT MAX(budget)
			FROM project) > 240000
			BREAK
		ELSE
			CONTINUE
	    END;

SELECT * FROM project;

-- 2. Create a batch that inserts 300 rows in the employee table. The values of the emp_no column should be unique and between 1 and 300. All values of the columns emp_lname, emp_fname, and
-- dept_no should be set to 'Jane', 'Smith', and 'd1', respectively.
DECLARE @Fname char(20), @Lname char(20), @dept_num char(4)
DECLARE @i int = 1
SET @Fname = 'Jane'
SET @Lname = 'Smith'
SET @dept_num = 'D1'

WHILE @i <= 300
	BEGIN 
	INSERT INTO employee VALUES (@i, @Fname, @Lname, @dept_num)
	SET @i = @i + 1 -- increment loop to get to 300 
	END

SELECT * FROM employee; 

-- 3. Calculate the average of all project budgets and compares this value with the budget of all projects stored in the project table. If the latter value is smaller than the calculated value, the budget of
--project p1 will be increased by the value of the local variable @extra_budget, which is (15000).
DECLARE @AVG_BUDGET MONEY, @EXTRA_BUDGET MONEY
SET @EXTRA_BUDGET = 15000
DECLARE @PNO CHAR(4) = 'P1'
SELECT @AVG_BUDGET = AVG(BUDGET) FROM project
IF (SELECT BUDGET 
	FROM project
	WHERE project_no = @PNO) < @AVG_BUDGET 
	BEGIN
		UPDATE PROJECT
		SET budget = BUDGET + @EXTRA_BUDGET
		WHERE project_no = @PNO
	    PRINT 'BUDGET FOR PROJECT' + @PNO + 'INCREASE BY' + @EXTRA_BUDGET
	END

SELECT * FROM project;

-- 4. Find projects whose budget is greater than 10,000. Use IF statement to check if the query returns any project and print out a message if no project returns. Use @@ROWCOUNT which is a system variable
--that returns the number of rows affected by the last previous statement.
SELECT *
FROM project
WHERE BUDGET > 1000000;
IF @@ROWCOUNT = 0
	PRINT 'no projects with budget greater than 10000' 

-- 5. Get the number of employees that work on project 'p1'. Print a message If the number of employees is greater than 2. If not find those employees who work in project p1 and belong to the Sales department.
IF (SELECT COUNT(*)
	FROM works_on
	WHERE project_no = 'P1') > 2
	PRINT 'THE NUMBER OF EMPLOYEE IN P1 IS 3 OR MORE'
ELSE
	BEGIN
		SELECT E.*, D.*
		FROM EMPLOYEE E 
	JOIN WORKS_ON W
		ON E.emp_no = W.emp_no
	JOIN department D
		ON E.dept_no = D.dept_no
		WHERE dept_name = 'SALES' AND W.project_no = 'P1'
	END
