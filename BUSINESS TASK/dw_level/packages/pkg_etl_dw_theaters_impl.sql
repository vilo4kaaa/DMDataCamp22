CREATE OR REPLACE PACKAGE body pkg_etl_dw_theaters
AS  
  PROCEDURE load_dw_theaters
   AS
     BEGIN
      DECLARE
	   TYPE CURSOR_VARCHAR IS TABLE OF varchar2(110);
       TYPE CURSOR_NUMBER IS TABLE OF NUMBER;
       TYPE BIG_CURSOR IS REF CURSOR ;
	   ALL_INF BIG_CURSOR;
       
        COUNTRY_CODE CURSOR_VARCHAR;             
        CITY CURSOR_VARCHAR;                    
        THEATER_NAME CURSOR_VARCHAR;              
        THEATER_ADDRESS CURSOR_VARCHAR;        
        THEATER_PHONE CURSOR_VARCHAR;
        THEATER_NAME_stage CURSOR_VARCHAR;
        CITY_stage CURSOR_VARCHAR;
        THEATER_ID CURSOR_NUMBER;
       
	BEGIN
	   OPEN ALL_INF FOR
	       SELECT 
                source_CL.COUNTRY_CODE AS  COUNTRY_CODE_source_CL,
                source_CL.CITY AS CITY_source_CL,
                source_CL.THEATER_NAME AS THEATER_NAME_source_CL,
                source_CL.THEATER_ADDRESS AS  THEATER_ADDRESS_source_CL,
                source_CL.THEATER_PHONE AS THEATER_PHONE_source_CL,
                stage.THEATER_NAME AS THEATER_NAME_stage,
                stage.CITY AS CITY_stage,
                stage.THEATER_ID AS  THEATER_ID
	          FROM (SELECT DISTINCT * FROM DW_CL.CLS_T_THEATERS) source_CL
                     LEFT JOIN DW_DATA.dim_theater stage
                     ON (source_CL.THEATER_NAME = stage.THEATER_NAME AND source_CL.CITY = stage.CITY);
	   FETCH ALL_INF
	   BULK COLLECT INTO
                    COUNTRY_CODE,
                    CITY,
                    THEATER_NAME,
                    THEATER_ADDRESS,
                    THEATER_PHONE,
                    THEATER_NAME_stage,
                    CITY_stage, 
                    THEATER_ID;
	   CLOSE ALL_INF;
	FOR i IN THEATER_ID.FIRST .. THEATER_ID.LAST LOOP
       IF ( THEATER_ID ( i ) IS NULL ) THEN
          INSERT INTO DW_DATA.dim_theater ( 
                                            THEATER_ID,
                                            COUNTRY_CODE,
                                            CITY,
                                            THEATER_NAME,
                                            THEATER_ADDRESS,
                                            THEATER_PHONE)
               VALUES ( SEQ_THEATERS.NEXTVAL,
                        COUNTRY_CODE(i),
                        CITY(i),
                        THEATER_NAME(i),
                        THEATER_ADDRESS(i),
                        THEATER_PHONE(i));
          COMMIT;
          
          ELSE UPDATE DW_DATA.dim_theater
         SET 
            COUNTRY_CODE = COUNTRY_CODE(i),
            CITY = CITY(i),
            THEATER_NAME = THEATER_NAME(i),
            THEATER_ADDRESS = THEATER_ADDRESS(i),
            THEATER_PHONE = THEATER_PHONE(i)
         WHERE theater_id = theater_id(i);
          COMMIT; 
       END IF;
    END LOOP;
   
	END;
   END load_dw_theaters;
END pkg_etl_dw_theaters;


EXEC pkg_etl_dw_theaters.load_dw_theaters;
SELECT * FROM dim_theater;