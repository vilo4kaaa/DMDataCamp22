/*
ALTER TABLE u_dw_references.lc_lng_scopes
   DROP CONSTRAINT FK_T_LNG_SCOPES2LC_LNG_SCOPES;

ALTER TABLE u_dw_references.t_languages
   DROP CONSTRAINT FK_T_LNG_SCOPES2T_LANGUAGES;

DROP TABLE u_dw_references.t_lng_scopes CASCADE CONSTRAINTS;

*/
----------------------------------------------------------------
-- Table: t_lng_scopes                                          

CREATE TABLE u_dw_references.t_lng_scopes 
(
   lng_scope_id         NUMBER(22,0)         not null,
   lng_scope_code       VARCHAR2(1 CHAR)     not null,
   CONSTRAINT PK_T_LNG_SCOPES PRIMARY KEY (lng_scope_id)
)
ORGANIZATION INDEX TABLESPACE TS_REFERENCES_DATA_01;

COMMENT ON COLUMN u_dw_references.t_lng_scopes.lng_scope_id is
'Idemtificator of Language Scopes - ISO 639-3';

COMMENT ON COLUMN u_dw_references.t_lng_scopes.lng_scope_code is
'Code of Languages Scopes - ISO 639-3';
