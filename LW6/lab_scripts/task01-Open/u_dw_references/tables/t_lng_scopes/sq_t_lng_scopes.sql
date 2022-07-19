/* 
DROP SEQUENCE u_dw_references.sq_lng_scopes_t_id;
*/

CREATE SEQUENCE u_dw_references.sq_lng_scopes_t_id
START WITH 4;

GRANT SELECT ON u_dw_references.sq_lng_scopes_t_id TO u_dw_ext_references;

