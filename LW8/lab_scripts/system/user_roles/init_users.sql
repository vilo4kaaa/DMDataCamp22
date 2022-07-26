-- Storage level

-- User: SA_MOVIES
CREATE USER SA_MOVIES
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_movies_data_01;

GRANT CONNECT,RESOURCE TO SA_MOVIES;

-- User: SA_ATTENDANCE
CREATE USER SA_ATTENDANCE
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_attendance_data_01;

GRANT CONNECT,RESOURCE TO SA_ATTENDANCE;

-- User: SA_CURRENCIES
CREATE USER SA_CURRENCIES
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_currencies_data_01;

GRANT CONNECT,RESOURCE TO SA_CURRENCIES;



-- Data warehouse Cleansing Level
-- User: DW_CL
CREATE USER DW_CL
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dw_cl_01;
    
GRANT CONNECT,CREATE VIEW,RESOURCE TO DW_CL;


-- Data warehouse Level
-- User: DW_DATA
CREATE USER DW_DATA
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dw_data_01;

GRANT CONNECT,CREATE VIEW,RESOURCE TO DW_DATA;


-- DW Prepare Star Cleansing Level
-- User: SAL_DW_CL
CREATE USER SAL_DW_CL
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dw_star_cls_01;

GRANT CONNECT,CREATE VIEW,RESOURCE TO SAL_DW_CL;

-- STAR Cleansing
-- User: SAL_CL
CREATE USER SAL_CL
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sal_cl_01;

GRANT CONNECT,CREATE VIEW,RESOURCE TO SAL_CL;



-- Data warehouse Start Level and Data Marts
-- User: DM_DATE
CREATE USER DM_DATE
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_dim_date_01;

GRANT CONNECT,CREATE VIEW,RESOURCE TO DM_DATE;

-- User: DM_LOCATION
CREATE USER DM_LOCATION
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_dim_location_01;

GRANT CONNECT,CREATE VIEW,RESOURCE TO DM_LOCATION;

-- User: DM_CURRENCY
CREATE USER DM_CURRENCY
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_dim_currency_01;

GRANT CONNECT,CREATE VIEW,RESOURCE TO DM_CURRENCY;

-- User: DM_THEATER
CREATE USER DM_THEATER
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_dim_theater_01;

GRANT CONNECT,CREATE VIEW,RESOURCE TO DM_THEATER;

-- User: DM_SHOWING
CREATE USER DM_SHOWING
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_dim_showing_01;

GRANT CONNECT,CREATE VIEW,RESOURCE TO DM_SHOWING;

-- User: DM_MOVIE
CREATE USER DM_MOVIE
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_dim_movie_01;

GRANT CONNECT,CREATE VIEW,RESOURCE TO DM_MOVIE;

-- User: DM_PROMOTION
CREATE USER DM_PROMOTION
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_dim_promotion_01;

GRANT CONNECT,CREATE VIEW,RESOURCE TO DM_PROMOTION;

-- User: DM_PERIOD
CREATE USER DM_PERIOD
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_dim_period_01;

GRANT CONNECT,CREATE VIEW,RESOURCE TO DM_PERIOD;

-- User: FCT_ATTENDANCE
CREATE USER FCT_ATTENDANCE
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_fct_attendance_01;

GRANT CONNECT,CREATE VIEW,RESOURCE TO FCT_ATTENDANCE;
