/*
ALTER TABLE u_dw_references.lc_lng_types
   DROP CONSTRAINT FK_LOC2LNG_TYPES;
ALTER TABLE u_dw_references.lc_lng_types
   DROP CONSTRAINT FK_T_LNG_TYPES2LC_LNG_TYPES;
   
DROP TABLE u_dw_references.lc_lng_types CASCADE CONSTRAINTS;
*/
----------------------------------------------------------------
-- Table: lc_lng_types                                          

CREATE TABLE u_dw_references.lc_lng_types 
(
   lng_type_id          NUMBER(22,0)         not null,
   lng_type_code        VARCHAR2(30 CHAR)    not null,
   lng_type_desc        VARCHAR2(200 CHAR)   not null,
   localization_id      NUMBER(22,0)         not null,
   CONSTRAINT PK_LC_LNG_TYPES PRIMARY KEY (lng_type_id, localization_id)
         USING INDEX TABLESPACE TS_REFERENCES_IDX_01
)
TABLESPACE TS_REFERENCES_DATA_01;

COMMENT ON COLUMN u_dw_references.lc_lng_types.lng_type_id is
'Identificator of Language Types - ISO 639-3';

COMMENT ON COLUMN u_dw_references.lc_lng_types.lng_type_code is
'Code of Language Types - ISO 639-3';

COMMENT ON COLUMN u_dw_references.lc_lng_types.lng_type_desc is
'Description of Language Types - ISO 639-3';

COMMENT ON COLUMN u_dw_references.lc_lng_types.localization_id is
'Identificator of Supported References Languages';

ALTER TABLE u_dw_references.lc_lng_types
   ADD CONSTRAINT CHK_LC_LNG_TYPES_LNG_TYPE_CODE CHECK (lng_type_code = UPPER(lng_type_code));

ALTER TABLE u_dw_references.lc_lng_types
   ADD CONSTRAINT FK_LOC2LNG_TYPES FOREIGN KEY (localization_id)
      REFERENCES u_dw_references.t_localizations (localization_id)
      ON DELETE CASCADE;

ALTER TABLE u_dw_references.lc_lng_types
   ADD CONSTRAINT FK_T_LNG_TYPES2LC_LNG_TYPES FOREIGN KEY (lng_type_id)
      REFERENCES u_dw_references.t_lng_types (lng_type_id)
      ON DELETE CASCADE;