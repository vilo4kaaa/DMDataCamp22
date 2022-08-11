alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_cls_promotions
AS  
    PROCEDURE load_cls_promotions;
END pkg_etl_cls_promotions;
/