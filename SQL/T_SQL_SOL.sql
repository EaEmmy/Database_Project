--Using a while statement, increase the budget of all projects by 10 
--percent until the sum of budgets is greater than $500,000. The 
--repeated execution will be stopped if the budget of one of the 
--projects is greater than $240,000

WHILE (SELECT SUM(BUDGET)
        FROM PROJECT ) < 500000
		BEGIN
		  UPDATE PROJECT
		  SET BUDGET = BUDGET * 1.1
		  IF ( SELECT MAX(BUDGET)
		        FROM PROJECT) > 240000
				BREAK
		  ELSE
		    CONTINUE
        END

--2. Create a batch that inserts 300 rows in the employee table. The 
--values of the emp_no column should be unique and between 1 and 
--300. All values of the columns emp_lname, emp_fname, and 
--dept_no should be set to 'Jane', 'Smith', and 'd1', respectively.
DECLARE @FNAME CHAR(20) = 'JANE'
DECLARE @LNAME CHAR(20) = 'SMITH'
DECLARE @DEPT_NUM CHAR(4)
SET @DEPT_NUM = 'D1'
DECLARE @I INTEGER = 1
WHILE @I <=300
BEGIN
   INSERT INTO EMPLOYEE VALUES (@I, @FNAME, @LNAME,@DEPT_NUM)
   SET @I = @I+1
END

--3. Calculate the average of all project budgets and compares this value 
-- with the budget of all projects stored in the project table. If the 
--latter value is smaller than the calculated value, the budget of 
--project p1 will be increased by the value of the local variable 
-- @extra_budget, which is (15000).

DECLARE @AVG_BUDGET MONEY, @extra_budget MONEY , @PNUM CHAR(4)
SET @extra_budget = 15000
SET @PNUM = 'P1'
SELECT @AVG_BUDGET =  AVG(BUDGET) FROM PROJECT
IF (SELECT BUDGET
    FROM PROJECT
	WHERE PROJECT_NO = @PNUM) < @AVG_BUDGET
	BEGIN
	  UPDATE PROJECT
	  SET BUDGET = BUDGET + @extra_budget
	  WHERE PROJECT_NO =@PNUM
	  PRINT '**** BUDGET OF PROJECT @PNUM INCREASED BY @extra_budget ****'
	END

--4. Find projects whose budget is greater than 10,000. Use IF statement 
--to check if the query returns any project and print out a message if 
--no project returns. Use @@ROWCOUNT which is a system variable 
--that returns the number of rows affected by the last previous 
--statement.

BEGIN
  SELECT *
  FROM PROJECT
  WHERE BUDGET = 10000;
  IF @@ROWCOUNT = 0 
     PRINT ' NO PROJECT WITH BUDGET GREATER THAN 10000 FOUND';
ELSE
  PRINT '*******'
END

--5. Get the number of employees that work on project 'p1'. Print a 
-- message If the number of employees is greater than 2. If not find 
--those employees who work in project p1 and belong to the Sales 
--department.

IF (SELECT COUNT(*)
    FROM WORKS_ON
	WHERE PROJECT_NO ='P1') > 2
	PRINT 'THE NUMBER OF EMPLOYEES IN THE PROJECT P1 IS 3 OR MORE'
ELSE 
   BEGIN
     SELECT E.*, W.*, D.*
	 FROM EMPLOYEE E JOIN WORKS_ON W
	 ON E.EMP_NO = W.EMP_NO
	 JOIN DEPARTMENT D
	 ON E.dept_no = D.DEPT_NO
	 WHERE W.PROJECT_NO = 'P1' AND D.dept_name ='SALES'
  END












