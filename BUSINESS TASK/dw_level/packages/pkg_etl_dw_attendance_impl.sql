alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_attendance
AS  
  PROCEDURE load_dw_attendance
    IS
        TYPE attenndance_rows_t IS TABLE OF dw_data.FCT_ATTENDANCE%ROWTYPE;
        attenndance attenndance_rows_t;

        CURSOR c IS
          SELECT 1,
                    cl.TRANSACTION_DATE,
                    sh.SHOWING_ID,
                    th.COUNTRY_CODE,
                    th.THEATER_ID,
                    mov.MOVIE_ID,
                    cl.SOLD_TICKETS,
                    cl.TICKET_PRICE,
                    prom.PROMOTION_ID,
                    cl.TICKETS_REVENUE,
                    cur.CURRENCY_ID
	          FROM (SELECT DISTINCT * FROM dw_cl.CLS_T_ATTENDANCE) cl
                    LEFT JOIN DW_DATA.DIM_MOVIE mov
                     ON (cl.movie_name = mov.movie_name)
                    LEFT JOIN DW_DATA.DIM_THEATER th
                     ON (cl.theater_name = th.theater_name AND cl.country_code = th.country_code)
                     LEFT JOIN DW_DATA.dim_currency cur
                     ON (cl.currency = cur.currency_name AND cl.country_code = cur.currency_country_code)
                     JOIN DW_DATA.DIM_SHOWING sh
                     ON (cl.showing_id = sh.showing_id)
                    JOIN DW_DATA.dim_promotion prom
                        ON (cl.discount = prom.discount);
    
    BEGIN
        OPEN c;
        LOOP
            FETCH c
            BULK COLLECT INTO attenndance;
            FORALL i in 1 .. attenndance.COUNT()
                INSERT INTO dw_data.FCT_ATTENDANCE
                            (
                               ATTENDANCE_ID,
                               TRANSACTION_DATE,
                               SHOWING_ID,
                               COUNTRY_CODE,
                               THEATER_ID,
                               MOVIE_ID,
                               SOLD_TICKETS,
                               TICKET_PRICE,
                               PROMOTION_ID,
                               TICKETS_REVENUE,CURRENCY_ID
                            )
                    VALUES 
                        (
                            SEQ_FCT_ATTENDANCE.NEXTVAL,
                            attenndance(i).TRANSACTION_DATE,
                            attenndance(i).SHOWING_ID,
                            attenndance(i).COUNTRY_CODE,
                            attenndance(i).THEATER_ID,
                            attenndance(i).MOVIE_ID,
                            attenndance(i).SOLD_TICKETS,
                            attenndance(i).TICKET_PRICE,
                            attenndance(i).PROMOTION_ID,
                            attenndance(i).TICKETS_REVENUE,
                            attenndance(i).CURRENCY_ID
                        );
            EXIT WHEN c%NOTFOUND;
        END LOOP;
        CLOSE c;
   END load_dw_attendance;
END pkg_etl_dw_attendance;

alter session set current_schema = DW_DATA;
EXEC pkg_etl_dw_attendance.load_dw_attendance;

select count(*) from dw_data.FCT_ATTENDANCE;
select * from dw_data.FCT_ATTENDANCE;

truncate table dw_data.FCT_ATTENDANCE;


