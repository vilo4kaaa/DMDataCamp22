/*
DROP VIEW w_localizations;
*/

---------------------------------------------------------------
-- View: w_localizations                                        

CREATE OR REPLACE VIEW u_dw_references.w_localizations AS
SELECT localization_id
     , localization_code
     , localization_desc
     , localization_desc_ens
     , lng_id
     , contry_id
     , is_default
  FROM u_dw_references.t_localizations;

COMMENT ON COLUMN u_dw_references.w_localizations.localization_id IS
'Identificator of Supported References Languages';

COMMENT ON COLUMN u_dw_references.w_localizations.localization_code IS
'Code of Supported References Languages';

COMMENT ON COLUMN u_dw_references.w_localizations.localization_desc IS
'Name of Supported References Languages';

COMMENT ON COLUMN u_dw_references.w_localizations.localization_desc_ens IS
'Endonym Name of  Supported References Languages';

COMMENT ON COLUMN u_dw_references.w_localizations.lng_id IS
'Disabled - FK for Language_Id - Post Mapped by Load PKG';

COMMENT ON COLUMN u_dw_references.w_localizations.contry_id IS
'Disabled - FK for Country_Id - Post Mapped by Load PKG';

COMMENT ON COLUMN u_dw_references.w_localizations.is_default IS
'Default Language for all Application and Members on DataBase';

GRANT SELECT on u_dw_references.w_localizations to PUBLIC;
