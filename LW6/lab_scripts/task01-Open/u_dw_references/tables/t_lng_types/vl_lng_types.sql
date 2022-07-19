/*
DROP VIEW u_dw_references.vl_lng_types;
*/

---------------------------------------------------------------
-- View: vl_lng_types                                           

CREATE OR REPLACE VIEW u_dw_references.vl_lng_types AS
SELECT lng_type_id
     , lng_type_code
     , lng_type_desc
     , localization_id
  FROM lc_lng_types;

COMMENT ON COLUMN u_dw_references.vl_lng_types.lng_type_id IS
'Identificator of Language Types - ISO 639-3';

COMMENT ON COLUMN u_dw_references.vl_lng_types.lng_type_code IS
'Code of Language Types - ISO 639-3';

COMMENT ON COLUMN u_dw_references.vl_lng_types.lng_type_desc IS
'Description of Language Types - ISO 639-3';

COMMENT ON COLUMN u_dw_references.vl_lng_types.localization_id IS
'Identificator of Supported References Languages';

GRANT DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_lng_types TO u_dw_ext_references;
