/*
drop view u_dw_references.vl_lng_scopes;
*/

----------------------------------------------------------------
-- View: vl_lng_scopes                                          

CREATE OR REPLACE VIEW u_dw_references.vl_lng_scopes AS
SELECT lng_scope_id
     , lng_scope_code
     , lng_scope_desc
     , localization_id
  FROM lc_lng_scopes;

COMMENT ON COLUMN u_dw_references.vl_lng_scopes.lng_scope_id IS
'Idemtificator of Language Scopes - ISO 639-3';

COMMENT ON COLUMN u_dw_references.vl_lng_scopes.lng_scope_code IS
'Code of Languages Scopes - ISO 639-3';

COMMENT ON COLUMN u_dw_references.vl_lng_scopes.lng_scope_desc IS
'Description of Language Scopes - ISO 639-3';

COMMENT ON COLUMN u_dw_references.vl_lng_scopes.localization_id IS
'Identificator of Supported References Languages';

GRANT DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_lng_scopes TO u_dw_ext_references;