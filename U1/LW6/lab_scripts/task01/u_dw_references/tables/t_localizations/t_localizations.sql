/*
ALTER TABLE u_dw_references.lc_lng_scopes
   DROP CONSTRAINT FK_LOC2LNG_SCOPES;

ALTER TABLE u_dw_references.lc_lng_types
   DROP CONSTRAINT FK_LOC2LNG_TYPES;

DROP TABLE u_dw_references.t_localizations CASCADE CONSTRAINTS;
*/

----------------------------------------------------------------
-- Table: t_localizations                                       

CREATE TABLE u_dw_references.t_localizations 
(
   localization_id      NUMBER(22,0)         not null,
   localization_code    VARCHAR2(5 CHAR)     not null,
   localization_desc    VARCHAR2(200 CHAR)   not null,
   localization_desc_ens VARCHAR2(200 CHAR)   not null,
   lng_id               NUMBER(22,0),
   contry_id            NUMBER(22,0),
   is_default           INTEGER,
   CONSTRAINT PK_T_LOCALIZATIONS PRIMARY KEY (localization_id)
         USING INDEX TABLESPACE TS_REFERENCES_IDX_01
)
TABLESPACE TS_REFERENCES_DATA_01;

COMMENT ON COLUMN u_dw_references.t_localizations.localization_id is
'Identificator of Supported References Languages';

COMMENT ON COLUMN u_dw_references.t_localizations.localization_code is
'Code of Supported References Languages';

COMMENT ON COLUMN u_dw_references.t_localizations.localization_desc is
'Name of Supported References Languages';

COMMENT ON COLUMN u_dw_references.t_localizations.localization_desc_ens is
'Endonym Name of  Supported References Languages';

COMMENT ON COLUMN u_dw_references.t_localizations.lng_id is
'Disabled - FK for Language_Id - Post Mapped by Load PKG';

COMMENT ON COLUMN u_dw_references.t_localizations.contry_id is
'Disabled - FK for Country_Id - Post Mapped by Load PKG';

COMMENT ON COLUMN u_dw_references.t_localizations.is_default is
'Default Language for all Application and Members on DataBase';

ALTER TABLE u_dw_references.t_localizations
   ADD CONSTRAINT CHK_T_LOCALIZATIONS_IS_DEFAULT CHECK (is_default IS NULL OR (is_default IN (1,0)));
