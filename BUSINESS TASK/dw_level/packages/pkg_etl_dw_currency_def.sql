alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_currency
AS  
    --PROCEDURE load_dw_currency;
    --PROCEDURE load_dw_currency_ref_cursor;
    PROCEDURE load_dw_currency_num_cursor;
END pkg_etl_dw_currency;
/