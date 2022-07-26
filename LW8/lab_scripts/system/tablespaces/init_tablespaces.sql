SELECT * from dba_data_files ;

-- Storage level
CREATE TABLESPACE ts_sa_movies_data_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_sa_movies_data_01.dat'
SIZE 150M reuse
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_sa_attendance_data_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_sa_attendance_data_01.dat'
SIZE 150M reuse
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_sa_currencies_data_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_sa_currencies_data_01.dat'
SIZE 50M reuse
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO;


-- Data warehouse Cleansing Level
CREATE TABLESPACE ts_dw_cl_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_dw_cl_01.dat'
SIZE 150M reuse
 AUTOEXTEND ON NEXT 100M
 SEGMENT SPACE MANAGEMENT AUTO;
 
-- Data warehouse Level
CREATE TABLESPACE ts_dw_data_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_dw_data_01.dat'
SIZE 150M reuse
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 
-- DW Prepare Star Cleansing Level
CREATE TABLESPACE ts_dw_star_cls_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_dw_star_cls_01.dat'
SIZE 150M reuse
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 
-- STAR Cleansing
CREATE TABLESPACE ts_sal_cl_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_sal_cl_01.dat'
SIZE 150M reuse
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 

-- Data warehouse Start Level and Data Marts*
CREATE TABLESPACE ts_sa_dim_date_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_dm_date_01.dat'
SIZE 150M 
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO;
 
CREATE TABLESPACE ts_sa_dim_location_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_dm_location_01.dat'
SIZE 150M 
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_sa_dim_currency_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_dm_currency_01.dat'
SIZE 150M 
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO;
 
CREATE TABLESPACE ts_sa_dim_theater_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_dm_theater_01.dat'
SIZE 150M 
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO; 
 
CREATE TABLESPACE ts_sa_dim_showing_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_dm_showing_01.dat'
SIZE 150M 
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO; 
 
CREATE TABLESPACE ts_sa_dim_movie_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_dm_movie_01.dat'
SIZE 150M 
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO; 
 
CREATE TABLESPACE ts_sa_dim_promotion_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_dm_promotion_01.dat'
SIZE 150M 
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO; 
 
CREATE TABLESPACE ts_sa_dim_period_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_dm_period_01.dat'
SIZE 150M 
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO; 

CREATE TABLESPACE ts_sa_fct_attendance_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_fct_attendance_01.dat'
SIZE 150M 
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO; 