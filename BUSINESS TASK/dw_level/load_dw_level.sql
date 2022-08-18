alter session set current_schema = DW_DATA;

BEGIN
    pkg_etl_dw_currency.load_dw_currency;
    pkg_etl_dw_movie.load_dw_movie;
    pkg_etl_dw_theaters.load_dw_theaters;
    pkg_etl_dw_showings.load_dw_showings;
    --pkg_etl_dw_promotions.load_dw_promotions;
    pkg_etl_dw_attendance.load_dw_attendance;
END;

select count(*) from fct_attendance;