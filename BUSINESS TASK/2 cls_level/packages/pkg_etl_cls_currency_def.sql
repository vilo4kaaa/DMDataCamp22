alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_cls_currency
AS  
    PROCEDURE load_cls_currency;
END pkg_etl_cls_currency;
/