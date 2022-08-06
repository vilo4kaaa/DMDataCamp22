alter session set current_schema = DW_DATA;

CREATE TABLE FCT_ATTENDANCE(
    ATTENDANCE_ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    DATE_ID                  DATE, 
    LOCATION_ID              NUMBER,
    CURRENCY_ID              NUMBER,
    THEATER_ID               NUMBER,
    SHOWING_ID               NUMBER,
    MOVIE_ID                 NUMBER,
    PROMOTION_ID             NUMBER,
    PERIOD_ID                NUMBER,
    NUMBER_OAF_ALL_TICKETS   NUMBER,
    NUMBER_OF_SOLD_TICKETS   NUMBER,
    NUMBER_OF_PROM_TICKETS   NUMBER,
    SHOWING_COST             DECIMAL(9,2),
    SHOWING_REVENUE          DECIMAL(9,2),
    ATTENADANCE_RATE         DECIMAL(1,5),
    CONSTRAINT "PK_T.FCT_ATTENDANCE" PRIMARY KEY(ATTENDANCE_ID),
    CONSTRAINT "FK_FCT_ATTENDANCE_DIM_DATE" FOREIGN KEY (DATE_ID )REFERENCES dim_date (DATE_ID),
    CONSTRAINT "FK_FCT_ATTENDANCE_DIM_LOCATION" FOREIGN KEY (LOCATION_ID )REFERENCES dim_location (LOCATION_ID),
    CONSTRAINT "FK_FCT_ATTENDANCE_DIM_CURRENCY" FOREIGN KEY (CURRENCY_ID )REFERENCES dim_currency (CURRENCY_ID),
    CONSTRAINT "FK_FCT_ATTENDANCE_DIM_THEATER" FOREIGN KEY (THEATER_ID )REFERENCES dim_theater (THEATER_ID),
    CONSTRAINT "FK_FCT_ATTENDANCE_DIM_SHOWING" FOREIGN KEY (SHOWING_ID )REFERENCES dim_showing (SHOWING_ID),
    CONSTRAINT "FK_FCT_ATTENDANCE_DIM_MOVIE" FOREIGN KEY (MOVIE_ID )REFERENCES dim_movie (MOVIE_ID),
    CONSTRAINT "FK_FCT_ATTENDANCE_DIM_PROMOTION" FOREIGN KEY (PROMOTION_ID )REFERENCES dim_promotion (PROMOTION_ID),
    CONSTRAINT "FK_FCT_ATTENDANCE_DIM_PERIOD" FOREIGN KEY (PERIOD_ID )REFERENCES dim_period (PERIOD_ID)   
)
PARTITION BY RANGE (DATE_ID)
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

