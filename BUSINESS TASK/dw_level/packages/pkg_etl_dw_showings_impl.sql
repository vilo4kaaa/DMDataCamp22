alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_showings
AS  
  PROCEDURE load_dw_showings
   AS
     BEGIN
     MERGE INTO DW_DATA.dim_showing A
     USING ( SELECT SHOW_NUM,THEATER_ID, MOVIE_ID, SHOWING_TYPE , SHOWING_CAPACITY, TICKET_PRICE  FROM DW_CL.cls_t_showings) B
             ON (a.SHOWING_NUM = b.SHOW_NUM)
             WHEN MATCHED THEN 
                UPDATE SET  a.SHOWING_CAPACITY = b.SHOWING_CAPACITY
             WHEN NOT MATCHED THEN 
                INSERT (a.SHOWING_ID, a.SHOWING_NUM, a.THEATER_ID, a.MOVIE_ID, a.SHOWING_TYPE , a.SHOWING_CAPACITY, a.TICKET_PRICE)
                VALUES (SEQ_SHOWINGS.NEXTVAL,b.SHOW_NUM, b.THEATER_ID, b.MOVIE_ID, b.SHOWING_TYPE , b.SHOWING_CAPACITY, b.TICKET_PRICE);
     COMMIT;
   END load_dw_showings;
END pkg_etl_dw_showings;


EXEC pkg_etl_dw_showings.load_dw_showings;
SELECT * FROM dim_showing;

