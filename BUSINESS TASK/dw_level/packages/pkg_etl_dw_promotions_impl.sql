alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_promotions
AS  
  PROCEDURE load_dw_promotions
   AS
     BEGIN
     MERGE INTO DW_DATA.dim_promotion A
     USING ( SELECT PROMOTION_NUM, discount FROM DW_CL.cls_t_promotions) B
             ON (a.PROMOTION_NUM = b.PROMOTION_NUM)
             WHEN MATCHED THEN 
                UPDATE SET a.DISCOUNT=b.DISCOUNT
             WHEN NOT MATCHED THEN 
                INSERT (a.PROMOTION_ID, a.PROMOTION_NUM, a.DISCOUNT)
                VALUES (SEQ_PROMOTIONS.NEXTVAL, b.PROMOTION_NUM, b.DISCOUNT);
     COMMIT;
   END load_dw_promotions;
END pkg_etl_dw_promotions;


EXEC pkg_etl_dw_promotions.load_dw_promotions;
SELECT * FROM dim_promotion;
