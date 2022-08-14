alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_attendance
AS  
    PROCEDURE load_dw_attendance;
END pkg_etl_dw_attendance;
/