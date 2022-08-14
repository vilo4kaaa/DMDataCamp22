alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_showings
AS  
    PROCEDURE load_dw_showings;
END pkg_etl_dw_showings;
/