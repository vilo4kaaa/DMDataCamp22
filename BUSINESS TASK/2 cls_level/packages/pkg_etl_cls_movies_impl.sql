CREATE OR REPLACE PACKAGE body pkg_etl_cls_movies
AS  
  PROCEDURE load_cls_movies
   AS

      CURSOR cursor_cls_movies
      IS
         SELECT DISTINCT MOVIE_NAME, MOVIE_YEAR, MOVIE_LEVEL1, MOVIE_LEVEL2, MOVIE_LEVEL3, MOVIE_DURATION
           FROM SA_EXT_REF_DATA.SA_T_MOVIE
           WHERE MOVIE_NAME IS NOT NULL
           AND MOVIE_YEAR IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_T_MOVIE';
      FOR i IN cursor_cls_movies LOOP
         INSERT INTO DW_CL.CLS_T_MOVIE( 
                       MOVIE_NAME,
                       MOVIE_YEAR,
                       MOVIE_LEVEL1,
                       MOVIE_LEVEL2,
                       MOVIE_LEVEL3,
                       MOVIE_DURATION)
              VALUES ( 
                i.MOVIE_NAME,
                i.MOVIE_YEAR,
                i.MOVIE_LEVEL1,
                i.MOVIE_LEVEL2,
                i.MOVIE_LEVEL3,
                i.MOVIE_DURATION);
         EXIT WHEN cursor_cls_movies%NOTFOUND;
      END LOOP;
      COMMIT;
   END load_cls_movies;
END pkg_etl_cls_movies;

alter session set current_schema = DW_CL;
EXEC pkg_etl_cls_movies.load_cls_movies;

SELECT * FROM cls_t_movie;
