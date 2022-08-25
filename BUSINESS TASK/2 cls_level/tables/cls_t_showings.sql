alter session set current_schema = DW_CL;

DROP TABLE CLS_T_SHOWINGS;

CREATE TABLE CLS_T_SHOWINGS(  
    SHOWING_ID NUMBER,
    THEATER_ID NUMBER,
    MOVIE_ID NUMBER,
    SHOWING_TYPE VARCHAR2(10),
    SHOWING_CAPACITY NUMBER,
    TICKET_PRICE NUMBER
);

SELECT * FROM CLS_T_SHOWINGS;

GRANT SELECT ON CLS_T_SHOWINGS TO DW_DATA;


 