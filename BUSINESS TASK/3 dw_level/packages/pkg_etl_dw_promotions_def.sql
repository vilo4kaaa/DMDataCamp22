alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_promotions
AS  
    PROCEDURE load_dw_promotions;
END pkg_etl_dw_promotions;
/