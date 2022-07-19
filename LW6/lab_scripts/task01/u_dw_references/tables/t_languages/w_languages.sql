/*
DROP VIEW u_dw_references.w_languages;
*/

----------------------------------------------------------------
-- View: w_languages                                            

CREATE OR REPLACE VIEW u_dw_references.w_languages AS
SELECT lng_id
     , lng_3c_code
     , lng_2b_code
     , lng_2t_code
     , lng_1c_code
     , lng_scope_id
     , lng_type_id
     , lng_desc
  FROM t_languages;

COMMENT ON COLUMN u_dw_references.w_languages.lng_id is
'Identifier of the Language';

COMMENT ON COLUMN u_dw_references.w_languages.lng_3c_code is
'ISO 639-3 identifier';

COMMENT ON COLUMN u_dw_references.w_languages.lng_2b_code is
'ISO 639-2 identifier of the bibliographic applications';

COMMENT ON COLUMN u_dw_references.w_languages.lng_2t_code is
'ISO 639-2 identifier of the terminology applications code ';

COMMENT ON COLUMN u_dw_references.w_languages.lng_1c_code is
'ISO 639-1 identifier - common standart';

COMMENT ON COLUMN u_dw_references.w_languages.lng_scope_id is
'Idemtificator of Language Scopes - ISO 639-3';

COMMENT ON COLUMN u_dw_references.w_languages.lng_desc is
'Name of Language';

GRANT DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_languages TO u_dw_ext_references;
