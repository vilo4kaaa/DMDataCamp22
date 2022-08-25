alter session set current_schema = DW_DATA;

drop TABLE FCT_ATTENDANCE;

CREATE TABLE FCT_ATTENDANCE(
    ATTENDANCE_ID NUMBER,
    TRANSACTION_DATE       DATE,          
    SHOWING_ID             NUMBER,  
    COUNTRY_CODE           VARCHAR2(10),  
    THEATER_ID             NUMBER, 
    MOVIE_ID               NUMBER,
    SOLD_TICKETS           NUMBER,        
    TICKET_PRICE           NUMBER,
    PROMOTION_ID           NUMBER,   
    TICKETS_REVENUE        NUMBER, 
    CURRENCY_ID            NUMBER,
    CONSTRAINT "PK_T.FCT_ATTENDANCE" PRIMARY KEY(ATTENDANCE_ID),
    CONSTRAINT "FK_FCT_ATTENDANCE_DIM_CURRENCY" FOREIGN KEY (CURRENCY_ID )REFERENCES dim_currency (CURRENCY_ID),
    CONSTRAINT "FK_FCT_ATTENDANCE_DIM_THEATER" FOREIGN KEY (THEATER_ID )REFERENCES dim_theater (THEATER_ID),
    CONSTRAINT "FK_FCT_ATTENDANCE_DIM_SHOWING" FOREIGN KEY (SHOWING_ID )REFERENCES dim_showing (SHOWING_ID),
    CONSTRAINT "FK_FCT_ATTENDANCE_DIM_MOVIE" FOREIGN KEY (MOVIE_ID )REFERENCES dim_movie (MOVIE_ID),
    CONSTRAINT "FK_FCT_ATTENDANCE_DIM_PROMOTION" FOREIGN KEY (PROMOTION_ID )REFERENCES dim_promotion (PROMOTION_ID) 
)
PARTITION BY RANGE (TRANSACTION_DATE)
    subpartition by hash(CURRENCY_ID) subpartitions 4
(
    PARTITION YEAR1_PERIOD VALUES LESS THAN(TO_DATE('09-08-2020','dd-mm-yy'))
    (
      subpartition YEAR1_PERIOD_sub_1,
      subpartition YEAR1_PERIOD_sub_2,
      subpartition YEAR1_PERIOD_sub_3,
      subpartition YEAR1_PERIOD_sub_4
    ),
    PARTITION YEAR2_PERIOD VALUES LESS THAN(TO_DATE('09-08-2021','dd-mm-yy'))
    (
      subpartition YEAR2_PERIOD_sub_1,
      subpartition YEAR2_PERIOD_sub_2,
      subpartition YEAR2_PERIOD_sub_3,
      subpartition YEAR2_PERIOD_sub_4
     ),
     PARTITION YEAR3_PERIOD VALUES LESS THAN(TO_DATE('09-08-2022','dd-mm-yy'))
    (
      subpartition YEAR3_PERIOD_sub_1,
      subpartition YEAR3_PERIOD_sub_2,
      subpartition YEAR3_PERIOD_sub_3,
      subpartition YEAR3_PERIOD_sub_4
    ),
     PARTITION YEAR4_PERIOD VALUES LESS THAN(TO_DATE('09-08-2023','dd-mm-yy'))
    (
      subpartition YEAR4_PERIOD_sub_1,
      subpartition YEAR4_PERIOD_sub_2,
      subpartition YEAR4_PERIOD_sub_3,
      subpartition YEAR4_PERIOD_sub_4
    )
);

CREATE SEQUENCE SEQ_FCT_ATTENDANCE
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

--The below query gives the number of rows in SUBPARTITION
select num_rows, PARTITION_NAME , SUBPARTITION_NAME 
FROM ALL_TAB_SUBPARTITIONS;

SELECT * FROM FCT_ATTENDANCE partition (YEAR2_PERIOD);
