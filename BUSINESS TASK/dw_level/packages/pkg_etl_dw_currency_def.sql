alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_currency
AS  
    PROCEDURE load_dw_currency;
END pkg_etl_dw_currency;
/