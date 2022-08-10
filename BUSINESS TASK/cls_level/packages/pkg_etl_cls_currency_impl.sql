CREATE OR REPLACE PACKAGE body pkg_etl_cls_currency
AS  
  PROCEDURE load_cls_currency
   AS

      CURSOR cursor_cls_currency
      IS
         SELECT DISTINCT CURRENCY_NAME, CURRENCY_COUNTRY_CODE, EXCHANGE_RATE
           FROM SA_CURRENCIES_DATA.SA_T_CURRENCY
           WHERE CURRENCY_NAME IS NOT NULL
           AND CURRENCY_COUNTRY_CODE IS NOT NULL
           AND EXCHANGE_RATE IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_T_CURRENCY';
      FOR i IN cursor_cls_currency LOOP
         INSERT INTO DW_CL.CLS_T_CURRENCY( 
                        CURRENCY_NAME, 
                        CURRENCY_COUNTRY_CODE, 
                        EXCHANGE_RATE)
              VALUES ( 
                i.CURRENCY_NAME, 
                i.CURRENCY_COUNTRY_CODE, 
                i.EXCHANGE_RATE);
         EXIT WHEN cursor_cls_currency%NOTFOUND;
      END LOOP;
      COMMIT;
   END load_cls_currency;
END pkg_etl_cls_currency;

alter session set current_schema = DW_CL;
EXEC pkg_etl_cls_currency.load_cls_currency;

SELECT * FROM cls_t_currency;

