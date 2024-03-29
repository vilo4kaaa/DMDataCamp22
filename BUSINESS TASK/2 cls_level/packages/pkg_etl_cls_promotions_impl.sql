CREATE OR REPLACE PACKAGE body pkg_etl_cls_promotions
AS  
  PROCEDURE load_cls_promotions
   AS

      CURSOR cursor_cls_promotions
      IS
         SELECT DISTINCT PROMOTION_NUM,DISCOUNT, VALID_FROM, VALID_TO, IS_ACTIVE
           FROM SA_PROMOTION_DATA.SA_T_PROMOTIONS
           WHERE DISCOUNT IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_T_PROMOTIONS';
      FOR i IN cursor_cls_promotions LOOP
         INSERT INTO DW_CL.CLS_T_PROMOTIONS( PROMOTION_NUM, DISCOUNT, VALID_FROM, VALID_TO, IS_ACTIVE )
              VALUES ( i.PROMOTION_NUM, i.DISCOUNT, i.VALID_FROM, i.VALID_TO, i.IS_ACTIVE);
         EXIT WHEN cursor_cls_promotions%NOTFOUND;
      END LOOP;
      COMMIT;
   END load_cls_promotions;
END pkg_etl_cls_promotions;


alter session set current_schema = DW_CL;
EXEC pkg_etl_cls_promotions.load_cls_promotions;

SELECT * FROM cls_t_promotions;
