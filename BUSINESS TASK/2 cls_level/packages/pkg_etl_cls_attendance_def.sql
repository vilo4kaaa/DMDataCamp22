alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_cls_attendance
AS  
    PROCEDURE load_cls_attendance;
END pkg_etl_cls_attendance;
/