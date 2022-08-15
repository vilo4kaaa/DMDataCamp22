CREATE OR REPLACE PACKAGE body pkg_etl_dw_currency
AS  
  PROCEDURE load_dw_currency
   AS
     BEGIN
      DECLARE
	   TYPE CURSOR_VARCHAR IS TABLE OF varchar2(20);
       TYPE CURSOR_NUMBER IS TABLE OF number(10); 
       TYPE CURSOR_DECIMAL IS TABLE OF decimal(5,2); 
	   TYPE BIG_CURSOR IS REF CURSOR ;
	
	   ALL_INF BIG_CURSOR;
       
       CURRENCY_NAME CURSOR_VARCHAR;
       CURRENCY_COUNTRY_CODE CURSOR_VARCHAR;
       EXCHANGE_RATE  CURSOR_DECIMAL;
       CURRENCY_NAME_stage CURSOR_VARCHAR;
       CURRENCY_ID CURSOR_NUMBER;

	BEGIN
	   OPEN ALL_INF FOR
	       SELECT 
                source_CL.CURRENCY_NAME AS  CURRENCY_NAME_source_CL,
                source_CL.CURRENCY_COUNTRY_CODE AS CURRENCY_COUNTRY_CODE_source_CL,
                source_CL.EXCHANGE_RATE AS  EXCHANGE_RATE_source_CL,
                stage.CURRENCY_NAME AS CURRENCY_NAME_stage,
                stage.CURRENCY_ID AS  CURRENCY_ID
	          FROM (SELECT DISTINCT * FROM DW_CL.CLS_T_CURRENCY) source_CL
                     LEFT JOIN DW_DATA.dim_currency stage
                     ON (source_CL.CURRENCY_NAME = stage.CURRENCY_NAME);
	   FETCH ALL_INF
	   BULK COLLECT INTO
                    CURRENCY_NAME,
                    CURRENCY_COUNTRY_CODE,
                    EXCHANGE_RATE,
                    CURRENCY_NAME_stage,
                    CURRENCY_ID;
	   CLOSE ALL_INF;
	
    FOR i IN CURRENCY_ID.FIRST .. CURRENCY_ID.LAST LOOP
       IF ( CURRENCY_ID ( i ) IS NULL ) THEN
          INSERT INTO DW_DATA.dim_currency ( 
                                            CURRENCY_ID,
                                            CURRENCY_NAME,
                                            CURRENCY_COUNTRY_CODE,
                                            EXCHANGE_RATE)
               VALUES ( SEQ_CURRENCY.NEXTVAL,
                        CURRENCY_NAME(i),
                        CURRENCY_COUNTRY_CODE(i),
                        EXCHANGE_RATE(i));
          COMMIT;
          
          ELSE UPDATE DW_DATA.dim_currency
         SET 
            currency_name = CURRENCY_NAME(i),
            currency_country_code = CURRENCY_COUNTRY_CODE(i),
            exchange_rate = EXCHANGE_RATE(i)
         WHERE currency_id = currency_id(i);
	
	         COMMIT;
       END IF;
    END LOOP;
	  
	END;
   END load_dw_currency;
   
   
   
PROCEDURE load_dw_currency_ref_cursor
   AS
     BEGIN 
     DECLARE 
       cursor_id NUMBER (25);
       cur_count NUMBER (38);
       quary_cur VARCHAR2(2000);
       TYPE ref_crsr IS REF CURSOR;
       ref_cursor ref_crsr;
       TYPE type_rec IS RECORD
	   (    CURRENCY_NAME VARCHAR(20),
            CURRENCY_COUNTRY_CODE VARCHAR2(10),
            EXCHANGE_RATE  DECIMAL(5,2),
            CURRENCY_ID NUMBER);
       one_record type_rec;
       
     BEGIN 
     EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_DATA.dim_currency CASCADE';
     quary_cur:= 'SELECT CURRENCY_NAME, CURRENCY_NAME, EXCHANGE_RATE, CURRENCY_ID FROM
                        (SELECT source.CURRENCY_NAME AS CURRENCY_NAME,
                        source.CURRENCY_COUNTRY_CODE AS CURRENCY_COUNTRY_CODE, 
                         source. EXCHANGE_RATE AS  EXCHANGE_RATE,
                         stage.CURRENCY_ID AS CURRENCY_ID
                  FROM DW_CL.CLS_T_CURRENCY source
                  LEFT JOIN DW_DATA.dim_currency stage
                  ON (source.CURRENCY_NAME = stage.CURRENCY_NAME))';
                  
      cursor_id:=DBMS_SQL.open_cursor;
      
      DBMS_SQL.PARSE(cursor_id, quary_cur, DBMS_SQL.NATIVE);
      
      cur_count:= DBMS_SQL.EXECUTE(cursor_id);
      
      ref_cursor:= DBMS_SQL.TO_REFCURSOR(cursor_id);
      
      LOOP
      FETCH ref_cursor INTO one_record;
      EXIT WHEN ref_cursor%NOTFOUND;
      IF (one_record.CURRENCY_ID IS NULL) THEN
                INSERT INTO DW_DATA.dim_currency(   CURRENCY_ID,
                                                    CURRENCY_NAME,
                                                    CURRENCY_COUNTRY_CODE,
                                                    EXCHANGE_RATE )
                VALUES (SEQ_CURRENCY.NEXTVAL,
                        one_record.CURRENCY_NAME, 
                        one_record.CURRENCY_NAME,
                        one_record.EXCHANGE_RATE
                        ); 
      END IF;
      END LOOP;
    COMMIT;
    END;
   END load_dw_currency_ref_cursor;
   
END pkg_etl_dw_currency;


--EXEC pkg_etl_dw_currency.load_dw_currency;
--EXEC pkg_etl_dw_currency.load_dw_currency_ref_cursor;
EXEC pkg_etl_dw_currency.load_dw_currency_num_cursor;
SELECT * FROM dim_currency;

DROP TABLE dim_currency CASCADE CONSTRAINTS;

