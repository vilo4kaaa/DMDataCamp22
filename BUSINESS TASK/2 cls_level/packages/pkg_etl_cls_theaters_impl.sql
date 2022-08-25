CREATE OR REPLACE PACKAGE body pkg_etl_cls_theaters
AS  
  PROCEDURE load_cls_theaters
   AS

      CURSOR cursor_cls_theaters
      IS
         SELECT DISTINCT COUNTRY_CODE, CITY, THEATER_NAME, THEATER_ADDRESS, THEATER_PHONE 
           FROM SA_EXT_REF_DATA.SA_T_THEATERS
           WHERE COUNTRY_CODE IS NOT NULL
           AND CITY IS NOT NULL
           AND THEATER_NAME IS NOT NULL
           AND THEATER_ADDRESS IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_T_THEATERS';
      FOR i IN cursor_cls_theaters LOOP
         INSERT INTO DW_CL.CLS_T_THEATERS( 
                        COUNTRY_CODE, 
                        CITY, 
                        THEATER_NAME, 
                        THEATER_ADDRESS, 
                        THEATER_PHONE )
              VALUES ( 
                i.COUNTRY_CODE, 
                i.CITY, 
                i.THEATER_NAME, 
                i.THEATER_ADDRESS, 
                i.THEATER_PHONE );
         EXIT WHEN cursor_cls_theaters%NOTFOUND;
      END LOOP;
      COMMIT;
   END load_cls_theaters;
END pkg_etl_cls_theaters;

alter session set current_schema = DW_CL;
EXEC pkg_etl_cls_theaters.load_cls_theaters;

SELECT * FROM cls_t_theaters;

