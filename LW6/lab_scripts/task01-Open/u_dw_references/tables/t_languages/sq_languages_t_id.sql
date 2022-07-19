/*
DROP SEQUENCE u_dw_references.sq_languages_t_id;
*/

CREATE SEQUENCE u_dw_references.sq_languages_t_id;

GRANT SELECT on u_dw_references.sq_languages_t_id TO u_dw_ext_references;
