alter session set current_schema = DW_DATA;

DROP TABLE DIM_PROMOTION;

CREATE TABLE DIM_PROMOTION(
    PROMOTION_ID NUMBER NOT NULL, 
    PROMOTION_NUM NUMBER NOT NULL, 
    DISCOUNT DECIMAL(3,2),
    CONSTRAINT "PK_T.DIM_PROMOTION" PRIMARY KEY(PROMOTION_ID) 
);

CREATE SEQUENCE SEQ_PROMOTIONS
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;