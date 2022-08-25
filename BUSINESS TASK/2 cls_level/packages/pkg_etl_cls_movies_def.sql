alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_cls_movies
AS  
    PROCEDURE load_cls_movies;
END pkg_etl_cls_movies;
/