ALTER USER SA_PROMOTION_DATA quota unlimited on ts_sa_promotion_data_01;
alter session set current_schema = SA_PROMOTION_DATA;

-- DROP TABLE SA_T_PROMOTIONS;

CREATE TABLE SA_T_PROMOTIONS(
    PROMOTION_NUM NUMBER,    
    DISCOUNT DECIMAL(3,2),
    VALID_FROM DATE,
    VALID_TO DATE,
    IS_ACTIVE CHAR(1) CHECK (IS_ACTIVE IN ('Y','N'))
);

INSERT INTO SA_T_PROMOTIONS (
SELECT rownum AS  PROMOTION_NUM, TRUNC(DBMS_RANDOM.VALUE(0, 0.5),2) as DISCOUNT,
TRUNC(TO_DATE( '09/08/2020', 'DD/MM/YYYY' )+ TRUNC(DBMS_RANDOM.VALUE( 1, 31))) AS VALID_FROM,
TO_DATE ( '01/01/2999', 'DD/MM/YYYY' ) AS VALID_TO, 'Y' AS IS_ACTIVE
FROM dual
CONNECT BY level <= 100
);

SELECT * FROM SA_PROMOTION_DATA.SA_T_PROMOTIONS;
SELECT COUNT(*) FROM SA_T_PROMOTIONS;

GRANT SELECT ON SA_T_PROMOTIONS TO SA_THEATER_DATA;
GRANT SELECT ON SA_T_PROMOTIONS TO DW_CL;