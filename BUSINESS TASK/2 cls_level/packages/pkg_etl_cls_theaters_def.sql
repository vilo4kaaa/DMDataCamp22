alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_cls_theaters
AS  
    PROCEDURE load_cls_theaters;
END pkg_etl_cls_theaters;
/