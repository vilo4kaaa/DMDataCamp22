alter session set current_schema = DW_DATA;

CREATE TABLE DIM_LOCATION(
    LOCATION_ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,     
    COUNTRY                       VARCHAR2(50),
    REGION                        VARCHAR2(50),
    CITY                          VARCHAR2(50),
    DISTRICT                      VARCHAR2(50),
    CURRENT_TIME_ZONE             VARCHAR2(10),
    CONSTRAINT "PK_T.DIM_LOCATION" PRIMARY KEY(LOCATION_ID) 
);