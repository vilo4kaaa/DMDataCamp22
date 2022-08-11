CREATE OR REPLACE PACKAGE body pkg_etl_dw_movie
AS  
  PROCEDURE load_dw_movie
   AS
     BEGIN
      DECLARE
	   TYPE CURSOR_VARCHAR IS TABLE OF varchar2(50);
       TYPE CURSOR_NUMBER IS TABLE OF number(10); 
       TYPE CURSOR_DATE IS TABLE OF DATE;
	   TYPE BIG_CURSOR IS REF CURSOR ;
	
	   ALL_INF BIG_CURSOR;
       
       
       
       MOVIE_NAME CURSOR_VARCHAR;
       MOVIE_YEAR CURSOR_VARCHAR;
       MOVIE_LEVEL1 CURSOR_VARCHAR;
       MOVIE_LEVEL2 CURSOR_VARCHAR;
       MOVIE_LEVEL3 CURSOR_VARCHAR;
       MOVIE_DURATION CURSOR_NUMBER;
       MOVIE_NAME_stage CURSOR_VARCHAR;
       MOVIE_YEAR_stage CURSOR_VARCHAR;
       MOVIE_ID CURSOR_NUMBER;
       
	BEGIN
	   OPEN ALL_INF FOR
	       SELECT 
                source_CL.MOVIE_NAME AS  MOVIE_NAME_source_CL,
                source_CL.MOVIE_YEAR AS MOVIE_YEAR_source_CL,
                source_CL.MOVIE_LEVEL1 AS MOVIE_LEVEL1_source_CL,
                source_CL.MOVIE_LEVEL2 AS MOVIE_LEVEL2_source_CL,
                source_CL.MOVIE_LEVEL3 AS MOVIE_LEVEL3_source_CL,
                source_CL.MOVIE_DURATION AS MOVIE_DURATION_source_CL,
                stage.MOVIE_NAME AS MOVIE_NAME_stage,
                stage.MOVIE_YEAR AS MOVIE_YEAR_stage,
                stage.MOVIE_ID AS  MOVIE_ID
	          FROM (SELECT DISTINCT * FROM DW_CL.CLS_T_MOVIE) source_CL
                     LEFT JOIN DW_DATA.dim_movie stage
                     ON (source_CL.MOVIE_NAME = stage.MOVIE_NAME AND source_CL.MOVIE_YEAR = stage.MOVIE_YEAR);
	   FETCH ALL_INF
	   BULK COLLECT INTO
                    MOVIE_NAME,
                    MOVIE_YEAR,
                    MOVIE_LEVEL1,
                    MOVIE_LEVEL2,
                    MOVIE_LEVEL3,
                    MOVIE_DURATION,
                    MOVIE_NAME_stage,
                    MOVIE_YEAR_stage,
                    MOVIE_ID;
	   CLOSE ALL_INF;
	FOR i IN MOVIE_ID.FIRST .. MOVIE_ID.LAST LOOP
       IF ( MOVIE_ID ( i ) IS NULL ) THEN
          INSERT INTO DW_DATA.dim_movie ( 
                                            MOVIE_ID,
                                            MOVIE_NAME,
                                            MOVIE_YEAR,
                                            MOVIE_LEVEL1,
                                            MOVIE_LEVEL2,
                                            MOVIE_LEVEL3,
                                            MOVIE_DURATION)
               VALUES ( SEQ_MOVIE.NEXTVAL,
                        MOVIE_NAME(i),
                        MOVIE_YEAR(i),
                        MOVIE_LEVEL1(i),
                        MOVIE_LEVEL2(i),
                        MOVIE_LEVEL3(i),
                        MOVIE_DURATION(i));
          COMMIT;
          
          ELSE UPDATE DW_DATA.dim_movie
         SET 
            movie_name = MOVIE_NAME(i),
            movie_year = MOVIE_YEAR(i),
            movie_level1 = MOVIE_LEVEL1(i),
            movie_level2 =  MOVIE_LEVEL2(i),
            movie_level3 =  MOVIE_LEVEL3(i),
            movie_duration = MOVIE_DURATION(i)
         WHERE movie_id = movie_id(i);
          COMMIT; 
       END IF;
    END LOOP;
   
	END;
   END load_dw_movie;
END pkg_etl_dw_movie;


EXEC pkg_etl_dw_movie.load_dw_movie;
SELECT * FROM dim_movie;