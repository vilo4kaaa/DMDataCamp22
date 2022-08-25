alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_promotions
AS  
  PROCEDURE load_dw_promotions
   AS
     BEGIN
     EXECUTE IMMEDIATE 'TRUNCATE TABLE DIM_PROMOTION';
     MERGE INTO DW_DATA.dim_promotion A
     USING ( SELECT PROMOTION_NUM, discount, valid_from, valid_to, is_active FROM DW_CL.cls_t_promotions) B
             ON (a.PROMOTION_NUM = b.PROMOTION_NUM)
             WHEN MATCHED THEN 
                UPDATE SET a.DISCOUNT=b.DISCOUNT, a.VALID_FROM = b.VALID_FROM, a.VALID_TO = b.VALID_TO, a.IS_ACTIVE = b.IS_ACTIVE
             WHEN NOT MATCHED THEN 
                INSERT (a.PROMOTION_ID, a.PROMOTION_NUM, a.DISCOUNT, a.VALID_FROM, a.VALID_TO, a.IS_ACTIVE)
                VALUES (SEQ_PROMOTIONS.NEXTVAL, b.PROMOTION_NUM, b.DISCOUNT, b.VALID_FROM, b.VALID_TO, b.IS_ACTIVE);
     COMMIT;
   END load_dw_promotions;
END pkg_etl_dw_promotions;


EXEC pkg_etl_dw_promotions.load_dw_promotions;
SELECT count(*) FROM dim_promotion;
