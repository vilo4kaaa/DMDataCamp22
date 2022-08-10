DROP TABLE movie_objects;

CREATE TABLE movie_objects(
    object_item VARCHAR2(100),
    object_parent_item VARCHAR2(100)
) TABLESPACE ts_sa_ext_ref_data_01;

INSERT INTO movie_objects(object_item, object_parent_item)
    SELECT movie_level1 || ' Category', null 
 FROM SA_EXT_REF_DATA.SA_T_MOVIE
GROUP BY movie_level1;

INSERT INTO movie_objects (object_item, object_parent_item)
    SELECT movie_level2|| ' Type', movie_level1 || ' Category'
    FROM SA_EXT_REF_DATA.SA_T_MOVIE
    GROUP BY movie_level2 || ' Type', movie_level1 || ' Category';

INSERT INTO movie_objects(object_item, object_parent_item)
    SELECT movie_level3 || ' Subtype', movie_level2 || ' Type'
        FROM SA_EXT_REF_DATA.SA_T_MOVIE
    GROUP BY  movie_level3 || ' Subtype', movie_level2 || ' Type';

INSERT INTO movie_objects(object_item, object_parent_item)
    SELECT movie_name,
       movie_level3 || 'Subtype'
    FROM SA_EXT_REF_DATA.SA_T_MOVIE;

SELECT * FROM movie_objects;


CREATE TABLE t_movie_de
AS
    SELECT LPAD(' ', 2 * LEVEL, ' ') || object_item AS object,
       DECODE(( SELECT COUNT(*)FROM movie_objects links WHERE links.object_parent_item = objects.object_item),0,NULL,
            ( SELECT COUNT(*) FROM movie_objects links WHERE links.object_parent_item= objects.object_item)) AS child_count,
       DECODE(LEVEL, 1, 'ROOT', 4, 'LEAF', 'BRANCH') AS id_type,
       LEVEL as lvl,
       CONNECT_BY_ROOT(object_item) AS root,
       SYS_CONNECT_BY_PATH(object_item, '->') AS path,
       REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(object_item, '->'), '->([^(->)]+)', 1, 1,  NULL, 1) AS Level1,
       REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(object_item, '->'), '->([^(->)]+)', 1, 2, NULL, 1) AS Level2,
       REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(object_item, '->'), '->([^(->)]+)', 1,3, NULL, 1) AS Level3
    FROM movie_objects objects
    START WITH object_parent_item IS NULL
    CONNECT BY PRIOR object_item = object_parent_item;
   -- ORDER SIBLINGS BY object_item;


SELECT * FROM t_movie_de;

DROP TABLE t_movie_de;
