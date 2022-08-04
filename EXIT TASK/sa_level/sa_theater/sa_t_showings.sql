ALTER USER SA_THEATER_DATA quota unlimited on ts_sa_theater_data_01;
alter session set current_schema = SA_THEATER_DATA;

drop table SA_T_SHOWINGS;

CREATE TABLE SA_T_SHOWINGS(
    SHOWING_ID NUMBER,    
    THEATER_ID NUMBER,
    MOVIE_ID NUMBER,
    SHOWING_TYPE VARCHAR2(10),
    SHOWING_CAPACITY NUMBER,
    TICKET_PRICE NUMBER
);


INSERT INTO SA_T_SHOWINGS (
SELECT rownum AS  SHOWING_ID, TRUNC(DBMS_RANDOM.VALUE( 1,41)) as THEATER_ID, TRUNC(DBMS_RANDOM.VALUE( 1,51)) as MOVIE_ID, 
       CASE round(dbms_random.value(1,4)) 
            WHEN 1 THEN 'morning' 
            WHEN 2 THEN 'afternoon' 
            WHEN 3 THEN 'evening' 
            WHEN 4 THEN 'night' 
       END AS SHOWING_TYPE, TRUNC(DBMS_RANDOM.VALUE( 20,101)) as SHOWING_CAPACITY, TRUNC(DBMS_RANDOM.VALUE( 1,10)) AS  TICKET_PRICE 
FROM dual
CONNECT BY level <= 1000
);

SELECT * FROM SA_T_SHOWINGS;

alter session set current_schema = SA_THEATER_DATA;
GRANT SELECT ON SA_T_SHOWINGS  TO SA_EXT_REF_DATA;
alter session set current_schema = SA_EXT_REF_DATA;
select * from SA_THEATER_DATA.SA_T_SHOWINGS;