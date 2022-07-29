--DROP TABLESPACE  INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
SELECT * from dba_data_files ;

-- Storage level
CREATE TABLESPACE ts_sa_ext_ref_data_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_sa_ext_ref_data_01.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO;
 
CREATE TABLESPACE ts_sa_currencies_data_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_sa_currencies_data_01.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO;
 
CREATE TABLESPACE ts_sa_theater_data_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_sa_theater_data_01.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_sa_promotion_data_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_sa_promotion_data_01.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_sa_date_data_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_sa_date_data_01.dat'
SIZE 150M
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
 
-- Data warehouse Start Level and Data Marts
CREATE TABLESPACE ts_dm_attendance_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_dm_attendance_01.dat'
SIZE 150M reuse
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 
CREATE TABLESPACE ts_dm_marketing_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_dm_marketing_01.dat'
SIZE 150M reuse
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 
CREATE TABLESPACE ts_dm_workload_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_dm_workload_01.dat'
SIZE 150M reuse
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 
CREATE TABLESPACE ts_dm_revenue_01
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_qpt_dm_revenue_01.dat'
SIZE 150M reuse
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;