/*
ALTER TABLE u_dw_references.lc_lng_types
   DROP CONSTRAINT FK_T_LNG_TYPES2LC_LNG_TYPES;
   
ALTER TABLE u_dw_references.t_languages
    DROP CONSTRAINT FK_T_LNG_TYPES2T_LANGUAGES;

DROP TABLE u_dw_references.t_lng_types CASCADE CONSTRAINTS;
*/

----------------------------------------------------------------
-- Table: t_lng_types                                           

CREATE TABLE u_dw_references.t_lng_types 
(
   lng_type_id          NUMBER(22,0)         not null,
   lng_type_code        VARCHAR2(30 CHAR)    not null,
   CONSTRAINT PK_T_LNG_TYPES PRIMARY KEY (lng_type_id)
)
ORGANIZATION INDEX TABLESPACE TS_REFERENCES_DATA_01;

COMMENT ON COLUMN u_dw_references.t_lng_types.lng_type_id is
'Identificator of Language Types - ISO 639-3';

COMMENT ON COLUMN u_dw_references.t_lng_types.lng_type_code is
'Code of Language Types - ISO 639-3';

ALTER TABLE u_dw_references.t_lng_types
   ADD CONSTRAINT CHK_T_LNG_TYPES_LNG_TYPE_CODE check (lng_type_code = upper(lng_type_code));
