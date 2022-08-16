GRANT ON COMMIT REFRESH to DW_DATA;

-- DROP MATERIALIZED VIEW movie_showings_daily;
  
CREATE MATERIALIZED VIEW movie_showings_daily
BUILD IMMEDIATE
REFRESH ON COMMIT
AS
SELECT transaction_date, movie_id, COUNT(*) AS movie_showing, SUM(SOLD_TICKETS) AS tickets
FROM fct_attendance
GROUP BY transaction_date, movie_id;
            
SELECT * FROM movie_showings_daily ORDER BY 1,4;

DELETE FROM DW_DATA.FCT_ATTENDANCE
WHERE transaction_date < to_date('11/08/2020', 'dd/mm/yyyy');
COMMIT;

SELECT * FROM movie_showings_daily ORDER BY 1,4;