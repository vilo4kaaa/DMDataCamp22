alter session set current_schema=u_dw_references;

SELECT OWNER, object_name, object_type FROM ALL_OBJECTS 
WHERE object_type IN ('TABLE', 'VIEW') AND
 OWNER IN ('U_DW_DATA', 'U_DW_EXT_REFERENCES', 'U_DW_PERSONS', 'U_DW_REFERENCES','U_DW_STR_CLS', 'U_STR_DATA', 'U_DW_COMMON')
ORDER BY CREATED DESC;

SELECT * FROM t_addresses;
SELECT * FROM t_address_types;

SELECT * FROM t_cntr_group_systems;
SELECT * FROM lc_cntr_group_systems;

SELECT * FROM t_cntr_groups;
SELECT * FROM lc_cntr_groups;

SELECT * FROM t_cntr_sub_groups;
SELECT * FROM lc_cntr_sub_groups;

SELECT * FROM t_countries;
SELECT * FROM lc_countries;

SELECT * FROM t_geo_object_links;

SELECT * FROM t_geo_objects;

SELECT * FROM t_geo_parts;
SELECT * FROM lc_geo_parts;

SELECT * FROM t_geo_regions;
SELECT * FROM lc_geo_regions;

SELECT * FROM t_geo_systems;
SELECT * FROM lc_geo_systems;

select * from t_geo_types;
