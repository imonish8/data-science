USE EMPDB;

DELIMITER //

CREATE PROCEDURE GET_SALARY (INOUT  VAR1 INT)
BEGIN
	SELECT SALARY FROM EMP WHERE EID = VAR1;
END //
DELIMITER ;

# 3033

SET @M = 3033;
CALL GET_SALARY(@M);
SELECT @M;

DELIMITER //

CREATE PROCEDURE GET_ENAME1 (INOUT VAR1 INT)
BEGIN
	SELECT ENAME FROM EMP WHERE EID = VAR1;
END //
DELIMITER ;
SET @M = "Josh";
CALL GET_ENAME(@M);
SELECT @M;



DELIMITER //

CREATE PROCEDURE GET_ENAME1 (INOUT VAR1 INT)
BEGIN
	SELECT ENAME FROM EMP WHERE EID = VAR1;
END //
DELIMITER ;
SET @M = "3033";
CALL GET_ENAME1(@M);
SELECT @M;
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE TESTCAL(TID INT AUTO_INCREMENT, FULLDATE DATE UNIQUE, DAY TINYINT NOT NULL, MONTH TINYINT NOT NULL, YEAR INT NOT NULL, PRIMARY KEY (TID));
DESCRIBE TESTCAL;
 
DELIMITER $$
CREATE PROCEDURE INSERT_CAL(DT DATE)
BEGIN 
		#INSERT INTO TESTCAL(FULLDATE, DAY, MONTH YEAR) VALUES
        INSERT INTO TESTCAL(FULLDATE, DAY, MONTH, YEAR ) VALUES (DT, EXTRACT(DAY FROM DT), EXTRACT(MONTH FROM DT), EXTRACT(YEAR FROM DT));
END $$
DELIMITER ;
CALL  INSERT_CAL("2024-09-21");
SELECT * FROM TESTCAL;

DROP PROCEDURE INSERT_CAL;

-- ------------------------------------------------------------------------------------------------------------------------------------

DELIMITER $$
CREATE PROCEDURE INSERT_VAL(IN DT DATE )
BEGIN 
		-- DECLARE DAY  date;
        -- DECLARE MONTH  date;
        -- DECLARE YEAR  date;
        DECLARE COUNT_DAYS INT;
        
        SET COUNT_DAYS = 0;
		
		INSERT_LOOP: LOOP
			-- SETTING THE DATE TO NEW DATE
            SET DT = DATE_ADD(DT, INTERVAL 1 DAY);
            
            INSERT INTO TESTCAL (fulldate, day, month, year) values
			(DT, EXTRACT(DAY FROM DT), EXTRACT(MONTH FROM DT), EXTRACT(YEAR FROM DT));
            SET COUNT_DAYS = COUNT_DAYS + 1;
			IF(COUNT_DAYS = 10) THEN
				LEAVE INSERT_LOOP;
			END IF;
			END LOOP INSERT_LOOP;

END $$
DELIMITER  $$
CALL INSERT_VAL("2024-05-01");
SELECT * FROM TESTCAL;

DROP PROCEDURE INSERT_VAL;

TRUNCATE TABLE TESTCAL;
#DESC TESTCAL;


DELIMITER $$
CREATE PROCEDURE DO_REPEAT(A INT )
BEGIN 
		
        #DECLARE TEMP INT DEFAULT 0;
        SET @X = 0;
        
        REPEAT
			SET @X = @X + 1;
		UNTIL @X > A END REPEAT;
        #SET X = A;
	
END $$
DELIMITER  ;
CALL DO_REPEAT(2);

DROP PROCEDURE DO_REPEAT;



