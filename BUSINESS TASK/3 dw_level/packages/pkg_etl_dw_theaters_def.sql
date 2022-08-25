alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_theaters
AS  
    PROCEDURE load_dw_theaters;
END pkg_etl_dw_theaters;
/