CREATE OR REPLACE PACKAGE body pkg_etl_cls_attendance
AS  
  PROCEDURE load_cls_attendance
   AS

      CURSOR cursor_cls_attendance
      IS
         SELECT DISTINCT SHOWING_ID, TRANSACTION_DATE, COUNTRY_CODE, THEATER_NAME, MOVIE_NAME, 
            SOLD_TICKETS, TICKET_PRICE,PROMOTION_NUM, DISCOUNT, TICKETS_REVENUE, CURRENCY
           FROM SA_THEATER_DATA.TRANSACTIONS
           WHERE TRANSACTION_DATE IS NOT NULL
           AND THEATER_NAME IS NOT NULL
           AND MOVIE_NAME IS NOT NULL
           AND PROMOTION_NUM IS NOT NULL
           AND SOLD_TICKETS IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_T_ATTENDANCE';
      FOR i IN cursor_cls_attendance LOOP
         INSERT INTO DW_CL.CLS_T_ATTENDANCE( 
                       SHOWING_ID,
                       TRANSACTION_DATE,
                       COUNTRY_CODE, 
                       THEATER_NAME, 
                       MOVIE_NAME, 
                       SOLD_TICKETS, 
                       TICKET_PRICE,
                       PROMOTION_NUM,
                       DISCOUNT, 
                       TICKETS_REVENUE, 
                       CURRENCY)
              VALUES ( 
                    i.SHOWING_ID,
                    i.TRANSACTION_DATE, 
                    i.COUNTRY_CODE, 
                    i.THEATER_NAME, 
                    i.MOVIE_NAME, 
                    i.SOLD_TICKETS, 
                    i.TICKET_PRICE, 
                    i.PROMOTION_NUM,
                    i.DISCOUNT, 
                    i.TICKETS_REVENUE, 
                    i.CURRENCY);
         EXIT WHEN cursor_cls_attendance%NOTFOUND;
      END LOOP;
      COMMIT;
   END load_cls_attendance;
END pkg_etl_cls_attendance;

alter session set current_schema = DW_CL;
EXEC pkg_etl_cls_attendance.load_cls_attendance;

SELECT count(*) FROM cls_t_attendance;

SELECT * FROM cls_t_attendance;