CREATE TABLESPACE ts_geo_de
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_geo_de_data_01.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE USER U_GEO_DE
IDENTIFIED BY "%PWD%"
DEFAULT TABLESPACE ts_geo_de;

GRANT CONNECT, RESOURCE, SELECT ANY TABLE TO U_GEO_DE;
ALTER USER U_GEO_DE QUOTA UNLIMITED ON ts_geo_de;

CREATE TABLE U_GEO_DE.t_geo_de AS
WITH temp AS
(  SELECT a.*, b.PARENT_GEO_ID FROM      
    (SELECT GEO_ID, GEO_SYSTEM_ID PART_ID, GEO_SYSTEM_CODE CODE, GEO_SYSTEM_DESC PART_DESC, LOCALIZATION_ID FROM U_DW_REFERENCES.LC_GEO_SYSTEMS
    UNION ALL
    SELECT GEO_ID, PART_ID,  PART_CODE CODE, PART_DESC , LOCALIZATION_ID FROM U_DW_REFERENCES.LC_GEO_PARTS
    UNION ALL
    SELECT GEO_ID, REGION_ID PART_ID,  REGION_CODE CODE,REGION_DESC PART_DESC , LOCALIZATION_ID FROM U_DW_REFERENCES.LC_GEO_REGIONS
    UNION ALL
    SELECT GEO_ID, COUNTRY_ID PART_ID,  COUNTRY_CODE_A3 CODE,COUNTRY_DESC PART_DESC , LOCALIZATION_ID FROM U_DW_REFERENCES.LC_COUNTRIES
    ) a
    left join 
    U_DW_REFERENCES.T_GEO_OBJECT_LINKS b
    on 
    a.GEO_ID = b.CHILD_GEO_ID
)
SELECT sys_connect_by_path(PART_DESC, '-> ') LEVEL1,
        lpad(' ', level*3, ' ')|| PART_DESC LEVEL2, 
        decode(level , 1, 'WORLD', 2, 'CONTINENT',3, 'REGION','COUNTRY') TYPE FROM temp
CONNECT BY PRIOR GEO_ID = PARENT_GEO_ID
START WITH PARENT_GEO_ID IS NULL;
     
SELECT * FROM U_GEO_DE.t_geo_de;



CREATE TABLE U_GEO_DE.t_geo_hierarchy
AS        
    SELECT LPAD(' ', 2 * lvl, ' ') || geos.geo_id AS geo_id,
       parent_geo_id,
       DECODE(( SELECT COUNT(*) FROM u_dw_references.t_geo_object_links links WHERE links.parent_geo_id = geos.geo_id), 0, NULL,
                  ( SELECT COUNT(*) FROM u_dw_references.t_geo_object_links links WHERE links.parent_geo_id = geos.geo_id)) AS child_count,
                  lvl, id_type, path, syst.geo_system_code
    FROM (
        SELECT geo_id,
                parent_geo_id,
                LEVEL AS lvl,
                DECODE(LEVEL, 1, 'ROOT', 4, 'LEAF', 'BRANCH') AS id_type,
                SYS_CONNECT_BY_PATH(geo_id, '->') AS path,
                REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(geo_id, '->'), '->(\d+)', 1, 1, NULL, 1) AS geo_sys_id,
                REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(geo_id, '->'), '->(\d+)', 1, 2, NULL, 1) AS geo_part_id,
                REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(geo_id, '->'), '->(\d+)', 1, 3, NULL, 1) AS geo_reg_id,
                REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(geo_id, '->'), '->(\d+)', 1, 4, NULL, 1) AS geo_country_id
         FROM (
                  SELECT * FROM u_dw_references.t_geo_objects
                  LEFT OUTER JOIN u_dw_references.t_geo_object_links ON child_geo_id = geo_id
              )
         START WITH parent_geo_id IS NULL
         CONNECT BY PRIOR geo_id = parent_geo_id
         ORDER SIBLINGS BY geo_id
     )  geos
         LEFT OUTER JOIN u_dw_references.lc_geo_systems syst ON syst.geo_id = geo_sys_id
         LEFT OUTER JOIN u_dw_references.lc_geo_parts prt on prt.geo_id = geo_part_id
         LEFT OUTER JOIN u_dw_references.lc_geo_regions rg on rg.geo_id = geo_reg_id
         LEFT OUTER JOIN u_dw_references.lc_countries cnt on cnt.geo_id = geo_country_id;
    
SELECT * FROM U_GEO_DE.t_geo_hierarchy;