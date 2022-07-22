SELECT OWNER, object_name, object_type FROM ALL_OBJECTS 
WHERE object_type IN ('TABLE', 'VIEW') AND
 OWNER IN ('U_DW_DATA', 'U_DW_EXT_REFERENCES', 'U_DW_PERSONS', 'U_DW_REFERENCES','U_DW_STR_CLS', 'U_STR_DATA', 'U_DW_COMMON')
ORDER BY CREATED ASC;

ALTER SESSION SET current_schema=u_dw_references;
SELECT * FROM t_localizations;
SELECT * FROM cu_languages;
SELECT * FROM w_lng_links;
SELECT * FROM cu_lng_scopes;
SELECT * FROM cu_lng_types;

