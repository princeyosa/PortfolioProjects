--#SET TERMINATOR @
CREATE PROCEDURE TRANSACTION_JAMES

LANGUAGE SQL 
MODIFIES SQL DATA 

BEGIN 

		DECLARE SQLCODE INTEGER DEFAULT 0;
		DECLARE retcode INTEGER DEFAULT 0;
		DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
		SET retcode = SQLCODE;
		
		UPDATE BankAccounts
		SET Balance = Balance-(4*300)
		WHERE AccountName = 'James';
		
		UPDATE BankAccounts
		SET Balance = Balance+(4*300)
		WHERE AccountName = 'Shoe Shop';
		
		UPDATE ShoeShop
		SET Stock = Stock + 4
		WHERE Product = 'Trainers';
		
		UPDATE BankAccounts
		SET Balance = Balance-150
		WHERE AccountName = 'James';
		
		IF retcode < 0 THEN 
			ROLLBACK WORK;
		
		ELSE 
			COMMIT WORK;
		END IF; 
		
		
END
@ 