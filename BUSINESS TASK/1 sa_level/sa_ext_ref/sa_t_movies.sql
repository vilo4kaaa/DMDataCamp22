ALTER USER SA_EXT_REF_DATA quota unlimited on ts_sa_ext_ref_data_01;
alter session set current_schema = SA_EXT_REF_DATA;

drop table SA_T_MOVIE;

CREATE TABLE SA_T_MOVIE(
    MOVIE_ID NUMBER,     
    MOVIE_NAME VARCHAR2 (100),
    MOVIE_YEAR VARCHAR2(4),
    MOVIE_GENRE VARCHAR2(50),
    MOVIE_LEVEL1 VARCHAR2(50),
    MOVIE_LEVEL2 VARCHAR2(50),
    MOVIE_LEVEL3 VARCHAR2(50),
    MOVIE_DURATION NUMBER
);

SELECT COUNT(*) FROM SA_T_MOVIE;
SELECT * FROM SA_T_MOVIE;

GRANT SELECT ON SA_T_THEATERS TO SA_THEATER_DATA;
GRANT SELECT ON SA_T_MOVIE TO SA_THEATER_DATA;
GRANT SELECT ON SA_T_MOVIE TO DW_CL;