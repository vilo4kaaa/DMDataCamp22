alter session set current_schema = DW_CL;

CREATE TABLE CLS_T_CURRENCY(
    CURRENCY_NAME VARCHAR(20),
    CURRENCY_COUNTRY_CODE VARCHAR2(10),
    EXCHANGE_RATE  DECIMAL(5,2)
);


-- drop table CLS_T_CURRENCY;

GRANT SELECT ON CLS_T_CURRENCY TO DW_DATA;

select * from CLS_T_CURRENCY;