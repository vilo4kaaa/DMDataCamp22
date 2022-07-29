alter session set current_schema = DW_DATA;

CREATE TABLE DIM_PROMOTION(
    PROMOTION_ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,     
    PROMOTION_NAME           VARCHAR2(50),
    PROMOTION_DESCRIPTION    VARCHAR2(100),
    PROMOTION_MEDIA_TYPE     VARCHAR2(50),
    VALID_FROM               DATE,
    VALID_TO                 DATE,
    CONSTRAINT "PK_T.DIM_PROMOTION" PRIMARY KEY(PROMOTION_ID) 
);