ALTER USER SA_EXT_REF_DATA quota unlimited on ts_sa_ext_ref_data_01;
alter session set current_schema = SA_EXT_REF_DATA;

drop table SA_T_MOVIE;

CREATE TABLE SA_T_MOVIE(
    MOVIE_ID NUMBER,     
    MOVIE_NAME VARCHAR2 (100),
    MOVIE_YEAR VARCHAR2(4),
    MOVIE_GENRE VARCHAR2(50),
    MOVIE_DURATION NUMBER
);

SELECT * FROM SA_T_MOVIE;