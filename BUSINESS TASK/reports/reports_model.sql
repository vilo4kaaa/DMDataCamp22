alter session set current_schema = SA_THEATER_DATA;

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
                )
    ORDER BY COUNTRY_CODE, SOLD_TICKETS desc;
    
    
    
SELECT THEATER_NAME AS THEATER, COUNTRY_CODE, SOLD_TICKETS
    FROM transactions
    WHERE TRUNC ( TRANSACTION_DATE, 'mm' ) = TO_DATE ( '06.01.21', 'MM.DD.YY' ) AND COUNTRY_CODE = 'POL' 
    group by CUBE( COUNTRY_CODE, THEATER_NAME ) 
    HAVING THEATER_NAME IS NOT NULL
    and COUNTRY_CODE IS NOT NULL 
    MODEL
      DIMENSION BY ( THEATER_NAME, COUNTRY_CODE)
      MEASURES ( SUM(SOLD_TICKETS) SOLD_TICKETS)
       RULES
            ( SOLD_TICKETS ['total', 
                FOR COUNTRY_CODE IN ('POL')] = 
                SUM ( SOLD_TICKETS)[any, cv(COUNTRY_CODE)]
                )
    ORDER BY THEATER_NAME, SOLD_TICKETS desc;
    
