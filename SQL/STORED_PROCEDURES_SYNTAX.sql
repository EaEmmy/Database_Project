--------------STORED PROCEDURES-----------
-- DELETES CUSTOMER WITH CUST_CODE GIVEN BY STORED PROCEDURE PARAMETERS (10019) 

CREATE PROCEDURE REMOVE_CUT (@CUST_ID NUMERIC)
AS
BEGIN
	DELETE FROM CUSTOMER
	WHERE CUS_CODE = @CUST_ID;
	PRINT 'THE CUSTOMER' + @CUS_ID + 'HAS BEEN DELETED'
END;


SELECT * FROM CUSTOMER; 
EXEC REMOVE_CUT 10019;

-- ALTER TO ADD PRINT 
ALTER PROCEDURE REMOVE_CUT (@CUST_ID NUMERIC)
AS
BEGIN
	DELETE FROM CUSTOMER
	WHERE CUS_CODE = @CUST_ID;
	PRINT 'THE CUSTOMER' + @CUST_ID + 'HAS BEEN DELETED'
END;


SELECT * FROM CUSTOMER; 
EXEC REMOVE_CUT 10019;

-- Create a procedure to assign an additional 5% discount for products when the quantity on hand is more than or equal to twice the minimum quatity
SELECT * FROM PRODUCT;
GO

CREATE PROC PROC_PROD_DISCOUNT
AS 
BEGIN
	 UPDATE PRODUCT
	 SET P_DISCOUNT = P_DISCOUNT + 0.5
	 WHERE P_QOH = P_MIN*2;
	 PRINT '**** UPDATE FINISHED****'
END
GO
EXEC PROC_PROD_DISCOUNT
GO

-- ALTER WITH PARAMETERS OF DISCOUNT VALUE @PD 
SELECT * FROM PRODUCT;

GO
ALTER PROC PROC_PROD_DISCOUNT @PD NUMERIC 
AS 
BEGIN
	 UPDATE PRODUCT
	 SET P_DISCOUNT = P_DISCOUNT + @PD 
	 WHERE P_QOH = P_MIN*2;
	 PRINT '**** UPDATE FINISHED****'
END
EXEC PROC_PROD_DISCOUNT 0.3
GO

-- IF ELSE STATEMENT
SELECT * FROM PRODUCT;

GO
ALTER PROC PROC_PROD_DISCOUNT @PD NUMERIC 
AS 
BEGIN
	 IF @PD <=0 OR @PD >=1
	 PRINT '****ERROR----THE VALUE MUST BE GREATER THAN 0 AND LESS THAN 1****'
	 ELSE 
	 BEGIN
	 UPDATE PRODUCT
	 SET P_DISCOUNT = P_DISCOUNT + @PD 
	 WHERE P_QOH = P_MIN*2;
	 PRINT '**** UPDATE FINISHED****'
	END
END
EXEC PROC_PROD_DISCOUNT 2
GO

--Create stored procedure to find the number of CUSTOMERS and stores it in the output parameter cust_count
GO
CREATE PROC COUNT_CUST @CUST_NUMBER NUMERIC OUTPUT
AS 
BEGIN
-- VALUE FROM COUNT FUNCTION WILL BE STORED IN THE @CUST_NUMBER VARIABLE
	 SELECT @CUST_NUMBER = COUNT(*)
	 FROM CUSTOMER;
END;

DECLARE @COUNT NUMERIC = 0;
EXEC COUNT_CUST @CUST_NUMBER = @COUNT OUTPUT
PRINT 'THE NUMBER OF CUSTOMERS IS : @COUNT'
GO

-- Write a procedure named PRC_INVOICE_ADD to add a new invoice record to the INVOICE table.
-- Use the following values in the new record: (1009, 10011, '30-APR-14')
-- You should execute the procedure and verify that the new customer was added to ensure your code is correct 

GO
CREATE PROC PRC_INVOICE_ADD @N_IN NUMERIC, @N_CC NUMERIC, @N_DATE DATE
AS
BEGIN 
	 INSERT INTO INVOICE VALUES(@N_IN, @N_CC, @N_DATE, NULL, NULL, NULL)
	 -- INSERT INTO INVOICE (INV_NUMBER, CUS_CODE, INV_DATE) VALUES (@N_IN, @N_CC, @N_DATE)
END
GO
EXEC PRC_INVOICE_ADD 1009, 10011, '30-APR-14'

SELECT * FROM INVOICE; 

-- OR THIS METHOD
GO
CREATE PROC PRC_INVOICE_ADD @N_IN NUMERIC, @N_CC NUMERIC, @N_DATE DATE
AS
BEGIN 
	 INSERT INTO INVOICE (INV_NUMBER, CUS_CODE, INV_DATE) VALUES (@N_IN, @N_CC, @N_DATE)
END
GO
EXEC PRC_INVOICE_ADD 1009, 10011, '30-04-2014'

SELECT * FROM INVOICE; 

-- Create simple stored procedure to add a new customer 
SELECT * FROM CUSTOMER;

GO
CREATE PROC PRC_ADD_CUS 
(@C_CODE NUMERIC,
@C_LNA VARCHAR,
@C_FNA VARCHAR,
@C_INI VARCHAR,
@C_AC VARCHAR,
@C_PH VARCHAR)
AS
BEGIN
	INSERT INTO CUSTOMER VALUES(CUS_CODE, CUS_LNAME, CUS_FNAME, CUS_INITIAL, CUS_AREACODE, )
END
GO
EXEC 