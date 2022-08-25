CREATE OR REPLACE PACKAGE body pkg_etl_cls_showings
AS  
  PROCEDURE load_cls_showings
   AS

      CURSOR cursor_cls_showings
      IS
         SELECT DISTINCT SHOWING_ID, THEATER_ID, MOVIE_ID, SHOWING_TYPE, SHOWING_CAPACITY, TICKET_PRICE
           FROM SA_THEATER_DATA.SA_T_SHOWINGS
           WHERE THEATER_ID IS NOT NULL
           AND MOVIE_ID IS NOT NULL
           AND SHOWING_CAPACITY IS NOT NULL
           AND TICKET_PRICE  IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_T_SHOWINGS';
      FOR i IN cursor_cls_showings LOOP
         INSERT INTO DW_CL.CLS_T_SHOWINGS( 
            SHOWING_ID, THEATER_ID, MOVIE_ID, SHOWING_TYPE, SHOWING_CAPACITY, TICKET_PRICE)
              VALUES (
              i.SHOWING_ID,
              i.THEATER_ID, 
              i.MOVIE_ID, 
              i.SHOWING_TYPE, 
              i.SHOWING_CAPACITY, 
              i.TICKET_PRICE);
         EXIT WHEN cursor_cls_showings%NOTFOUND;
      END LOOP;
      COMMIT;
   END load_cls_showings;
END pkg_etl_cls_showings;

alter session set current_schema = DW_CL;
EXEC pkg_etl_cls_showings.load_cls_showings;

SELECT * FROM cls_t_showings;
