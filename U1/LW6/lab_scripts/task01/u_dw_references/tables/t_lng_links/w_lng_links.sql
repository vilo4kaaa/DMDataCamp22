/*
DROP VIEW u_dw_references.w_lng_links;
*/

---------------------------------------------------------------
-- View: w_lng_links                                            

CREATE OR REPLACE VIEW u_dw_references.w_lng_links AS
SELECT
   parent_lng_id,
   child_lng_id,
   link_type_id
FROM
   t_lng_links;

COMMENT ON COLUMN u_dw_references.w_lng_links.parent_lng_id IS
'Link: Paranet Object - Languages T_LANGUAGES';

COMMENT ON COLUMN u_dw_references.w_lng_links.child_lng_id IS
'Link: Child Object - Languages T_LANGUAGES';

COMMENT ON COLUMN u_dw_references.w_lng_links.link_type_id IS
'Link Type: 1 - Macrolanguages to Individual Languages';

GRANT DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_lng_links TO u_dw_ext_references;
