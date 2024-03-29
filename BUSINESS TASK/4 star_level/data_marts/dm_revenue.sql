alter session set current_schema = DM_REVENUE;

drop view DM_REVENUE.V_REVENUE;

CREATE OR REPLACE VIEW DM_REVENUE.V_REVENUE AS
SELECT  fct.ATTENDANCE_ID, 
        fct.TRANSACTION_DATE,
        fct.COUNTRY_CODE,
        fct.SOLD_TICKETS,
        fct.TICKET_PRICE,
        prom.DISCOUNT, 
        fct.TICKETS_REVENUE, 
        cur.CURRENCY_NAME
  FROM (SELECT DISTINCT * FROM DW_DATA.FCT_ATTENDANCE) fct
  LEFT JOIN DW_DATA.DIM_CURRENCY cur ON (fct.CURRENCY_ID = cur.CURRENCY_ID)
  LEFT JOIN DW_DATA.DIM_PROMOTION prom ON (fct.PROMOTION_ID = prom.PROMOTION_ID);

alter session set current_schema = DW_DATA;
GRANT DELETE,INSERT,UPDATE,SELECT on FCT_ATTENDANCE TO DM_REVENUE;
GRANT DELETE,INSERT,UPDATE,SELECT on DIM_CURRENCY TO DM_REVENUE;
GRANT DELETE,INSERT,UPDATE,SELECT on DIM_PROMOTION TO DM_REVENUE;


select * from DM_REVENUE.V_REVENUE order by 2;

CREATE OR REPLACE VIEW DM_REVENUE.V_CURRENCY AS
SELECT  * FROM DW_DATA.DIM_CURRENCY;
  
select * from DM_REVENUE.V_CURRENCY;
