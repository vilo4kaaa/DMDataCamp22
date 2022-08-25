alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_cls_showings
AS  
    PROCEDURE load_cls_showings;
END pkg_etl_cls_showings;
/