alter session set current_schema = DW_DATA;

GRANT create table, create MATERIALIZED VIEW to DW_DATA;

-- DROP MATERIALIZED VIEW movie_showings_month;

CREATE MATERIALIZED VIEW movie_showings_month
BUILD DEFERRED
REFRESH COMPLETE ON DEMAND
AS 
SELECT TRUNC(transaction_date, 'MM') AS month, DECODE(GROUPING(movie_id), 1, 'All movies', movie_id) AS movie_id, 
    COUNT(*) AS movie_showing, SUM(SOLD_TICKETS) AS tickets
FROM fct_attendance
WHERE transaction_date < (TO_DATE( '01/01/2022', 'DD/MM/YYYY' )) AND transaction_date > (TO_DATE( '01/01/2021', 'DD/MM/YYYY' ))
GROUP BY GROUPING SETS(
    (TRUNC(transaction_date, 'MM'), movie_id),
    (TRUNC(transaction_date, 'MM')));

EXECUTE DBMS_MVIEW.REFRESH('movie_showings_month');

SELECT * FROM  movie_showings_month;

