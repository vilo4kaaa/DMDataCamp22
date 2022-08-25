alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_movie
AS  
    PROCEDURE load_dw_movie;
END pkg_etl_dw_movie;
/