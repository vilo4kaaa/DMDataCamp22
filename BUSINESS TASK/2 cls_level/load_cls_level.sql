alter session set current_schema = DW_CL;

BEGIN
    pkg_etl_cls_currency.load_cls_currency;
    pkg_etl_cls_movies.load_cls_movies;
    pkg_etl_cls_theaters.load_cls_theaters;
    pkg_etl_cls_showings.load_cls_showings;
    pkg_etl_cls_promotions.load_cls_promotions;
    pkg_etl_cls_attendance.load_cls_attendance;
END;