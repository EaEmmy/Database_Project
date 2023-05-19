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

SELECT * FROM EMPLOYEE;
SELECT * FROM PROJECT;
SELECT * FROM DEPARTMENT;
SELECT * FROM WORKS_ON;

-----LAB-----
--1) Create a stored procedure Proc_increase_budget that increases the budgets of all projects for a certain percentage value that is defined using the parameter @percent.
--Use EXECUTE statement to execute the stored procedure Proc_increase_budget and increases the budgets of all projects by 10 percent.

GO
CREATE PROC Proc_increase_budget @percent NUMERIC 
AS
BEGIN
	 UPDATE PROJECT
	 SET BUDGET = BUDGET + BUDGET*@percent
END
GO 
EXEC Proc_increase_budget 0.1
GO

--2) Using While statement, write anonymous T-SQL block such as:
--a. if the average project budget less than $30000, the WHILE loop doubles the budget and then selects the maximum budget. 
--If the maximum budget is less than or equal to $500000, the WHILE loop restarts (using CONTINUE ) and doubles the budget again. 
--The loop continues doubling the budget until the maximum budget is greater than $500000, and then exits the WHILE loop and 
--prints a message.

GO 
WHILE(SELECT AVG(BUDGET)
	 FROM PROJECT) < 30000
		BEGIN
			UPDATE PROJECT
			SET BUDGET = BUDGET*2
				IF(SELECT MAX(BUDGET)
				FROM PROJECT) <= 500000				
			BREAK
		ELSE
		BEGIN
			CONTINUE	
			PRINT 'BUDGET DOUBLED'
			END
		END;

SELECT * FROM PROJECT;

--3) Create a simple stored procedure Proc_employees_in_dept that displays the numbers 
--and family names of all employees working for a particular department. 
--(The department number is a parameter that must be specified when the procedure is invoked.) 
--Execute the procedure by passing a department number

GO
CREATE PROC Proc_employees_in_dept @DEP_NUM CHAR(4)
AS 
BEGIN		
	SELECT EMP_NO, EMP_LNAME, DEPT_NO
	FROM employee
	WHERE @DEP_NUM = DEPT_NO
END;
EXEC Proc_employees_in_dept 'd2';

SELECT * FROM EMPLOYEE

--4) Create Proc_employees_name_project procedure to display names of all employees 
--that belong to a particular project. Use input parameter @pr_number to specify a project number.
GO
ALTER PROC Proc_employees_name_project @pr_number CHAR(4)
AS 
BEGIN		
     SELECT E.EMP_NO, EMP_FNAME, EMP_LNAME, p.project_no
	 FROM EMPLOYEE E, WORKS_ON W, PROJECT P
	 WHERE E.emp_no = W.emp_no
	 AND
	 W.project_no = P.project_no
	 AND P.project_no = @pr_number
END;
EXEC  Proc_employees_name_project p1

SELECT * FROM EMPLOYEE;
SELECT * FROM PROJECT;
SELECT * FROM WORKS_ON;

--5) Write a procedure named PRC_EMPLOYEE_ADD to add a new employee record to the Employee table. 
--Use the following values in the new record: (1100, ‘Jain’, ‘Smith’, ‘d1’). 
--You should execute the procedure and verify that the new employee was added to ensure your code is correct.
GO 
CREATE PROC PRC_EMPLOYEE_ADD @EMP_NUM INT, @FNAME CHAR(20), @LNAME CHAR(20), @DEPT_NUM CHAR(4)
AS
BEGIN
	 INSERT INTO employee (emp_no, emp_fname, emp_lname, dept_no) VALUES (@EMP_NUM, @FNAME, @LNAME, @DEPT_NUM)
END
GO
EXEC PRC_EMPLOYEE_ADD 1100, Jain, Smith, d1

--6) Write a stored procedure named Proc_MaxBudget which will return as output the highest project budget.
GO
ALTER PROC Proc_MaxBudget 
AS
BEGIN 
	 SELECT MAX(BUDGET) AS MAX_BUDGET
	 FROM PROJECT
END;
EXEC Proc_MaxBudget 

--*****7) Write a stored procedure named Proc_GetEmployeesNames which will display the 
--employee’s first name and last name who works at department located at a given location. 
--If the location is empty, please print a message saying, “The input location cannot be empty.”
GO
CREATE PROC Proc_GetEmployeesNames @LOC_NUM CHAR(30) = NULL
AS
BEGIN
	IF (@LOC_NUM = NULL) 
	PRINT 'The input location cannot be empty.'
	ELSE
BEGIN
	SELECT EMP_FNAME, EMP_LNAME
	FROM EMPLOYEE E, DEPARTMENT D
	WHERE E.dept_no = D.dept_no
	AND D.location = @LOC_NUM
END
	END
EXEC Proc_GetEmployeesNames 

--8) Create Proc_delete_emp procedure to delete an employee from employee and works_on tables respectively, 
--giving the employee number as a parameter. Test the procedure by deleting employee number 28559
GO
CREATE PROC Proc_delete_emp @EMP_NUM INT
AS
BEGIN
	DELETE FROM employee  
	WHERE emp_no = @EMP_NUM
	DELETE FROM works_on  
	WHERE emp_no = @EMP_NUM
END
EXEC Proc_delete_emp 28559

SELECT * FROM EMPLOYEE;
SELECT * FROM works_on;

--9) Create a procedure to calculate the number of projects on which the employee (with the employee number @employee_no) works. 
--The calculated value is then assigned to the @counter parameter. The @counter parameter must be declared with the OUTPUT 
--option in the procedure as well as in the EXECUTE statement
GO
CREATE PROC PROC_PROJECT_WORKS_ON @counter_parameter NUMERIC OUTPUT, @employee_no INT 
AS
BEGIN
	SELECT w.emp_no, project_name, COUNT(w.project_no)
	FROM employee e, works_on w, project p
	WHERE e.emp_no = w.emp_no
	AND
	w.project_no = p.project_no
	AND @employee_no = e.emp_no
	GROUP BY w.project_no
END
EXEC PROC_PROJECT_WORKS_ON 10102

SELECT * FROM employee;
SELECT * FROM works_on;
SELECT * FROM project;
