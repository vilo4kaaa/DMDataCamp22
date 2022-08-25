alter session set current_schema = SA_THEATER_DATA;

-- DROP MATERIALIZED VIEW movie_showings_model;

CREATE MATERIALIZED VIEW movie_showings_model
BUILD IMMEDIATE
REFRESH COMPLETE NEXT SYSDATE + 1/1440
AS
   SELECT MOVIE_NAME AS MOVIE, COUNTRY_CODE, SOLD_TICKETS
    FROM transactions
    WHERE TRUNC ( TRANSACTION_DATE, 'mm' ) = TO_DATE ( '06.01.21', 'MM.DD.YY' ) AND COUNTRY_CODE = 'BLR'
    group by CUBE( COUNTRY_CODE, MOVIE_NAME ) 
    HAVING MOVIE_NAME IS NOT NULL
    and COUNTRY_CODE IS NOT NULL
    MODEL
      DIMENSION BY ( MOVIE_NAME, COUNTRY_CODE)
      MEASURES ( SUM(SOLD_TICKETS) SOLD_TICKETS)
       RULES
            ( SOLD_TICKETS ['total', 
                 FOR COUNTRY_CODE IN ('BLR')] = 
                SUM ( SOLD_TICKETS)[any, cv(COUNTRY_CODE)]
                );
            
SELECT * FROM movie_showings_model order by 2,3 DESC;

UPDATE transactions
SET SOLD_TICKETS = SOLD_TICKETS*2
WHERE MOVIE_NAME = '1917';
COMMIT;

SELECT * FROM movie_showings_model order by 2,3 DESC;