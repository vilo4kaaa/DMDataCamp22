-- LW2 monthly report from CLS level
alter session set current_schema = DW_CL;

SELECT DECODE(GROUPING(movie_name), 1, 'total', movie_name) AS movie_name, COUNTRY_CODE, SUM(SOLD_TICKETS) AS tickets
FROM cls_t_attendance
WHERE TRUNC ( TRANSACTION_DATE, 'mm' ) = TO_DATE ( '06.01.21', 'MM.DD.YY' ) AND COUNTRY_CODE = 'BLR'
GROUP BY GROUPING SETS(
    (TRUNC(transaction_date, 'MM'), movie_name, COUNTRY_CODE),
    (TRUNC(transaction_date, 'MM')))
ORDER BY SUM(SOLD_TICKETS) DESC;


-- LW5 monthly report from CLS level with model clause
alter session set current_schema = DW_CL;

SELECT  MOVIE_NAME AS MOVIE, COUNTRY_CODE, SOLD_TICKETS as tickets
    FROM cls_t_attendance
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
    ORDER BY SOLD_TICKETS desc;

    
-- LW11 monthly report from star
alter session set current_schema = DW_DATA;

SET AUTOTRACE ON
SELECT /*+ gather_plan_statistics */ TRUNC(transaction_date, 'MM') AS month, DECODE(GROUPING(movie_name), 1, 'All movies', movie_name) AS movie_name,  SUM(SOLD_TICKETS) AS tickets
 FROM (SELECT DISTINCT * FROM DW_DATA.FCT_ATTENDANCE) fct
  LEFT JOIN DW_DATA.DIM_MOVIE mov ON (fct.MOVIE_ID = mov.MOVIE_ID)
WHERE TRUNC ( TRANSACTION_DATE, 'mm' ) = TO_DATE ( '06.01.21', 'MM.DD.YY' ) AND COUNTRY_CODE = 'BLR'
GROUP BY GROUPING SETS(
 (TRUNC(transaction_date, 'MM'), movie_name),
  (TRUNC(transaction_date, 'MM')))
ORDER BY SUM(SOLD_TICKETS) DESC;


