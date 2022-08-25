alter session set current_schema = DW_CL;

CREATE TABLE CLS_T_ATTENDANCE(
    SHOWING_ID             NUMBER, 
    TRANSACTION_DATE       DATE,          
    COUNTRY_CODE           VARCHAR2(10),  
    THEATER_NAME           VARCHAR2(100), 
    MOVIE_NAME             VARCHAR2(100), 
    SOLD_TICKETS           NUMBER,        
    TICKET_PRICE           NUMBER, 
    PROMOTION_NUM          NUMBER,
    DISCOUNT               NUMBER(3,2),
    TICKETS_REVENUE        NUMBER,        
    CURRENCY               VARCHAR2(20) 
);


drop table CLS_T_ATTENDANCE;

GRANT SELECT ON CLS_T_ATTENDANCE TO DW_DATA;

select count(*) from DW_CL.CLS_T_ATTENDANCE;

select * from DW_CL.CLS_T_ATTENDANCE order by 2;