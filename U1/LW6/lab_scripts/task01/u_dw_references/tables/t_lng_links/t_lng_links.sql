/*
ALTER TABLE u_dw_references.t_lng_links
   DROP CONSTRAINT FK_T_LANGUAGES2T_LNG_LINKS_C;

ALTER TABLE u_dw_references.t_lng_links
   DROP CONSTRAINT FK_T_LANGUAGES2T_LNG_LINKS_P;

DROP table u_dw_references.t_lng_links CASCADE CONSTRAINTS;

*/

---------------------------------------------------------------
-- Table: t_lng_links                                           

CREATE TABLE u_dw_references.t_lng_links 
(
   parent_lng_id        NUMBER(22,0)         not null,
   child_lng_id         NUMBER(22,0)         not null,
   link_type_id         NUMBER(3,0)          not null,
   CONSTRAINT PK_T_LNG_LINKS PRIMARY KEY (parent_lng_id, child_lng_id, link_type_id)
   USING INDEX LOCAL TABLESPACE TS_REFERENCES_IDX_01
)
TABLESPACE TS_REFERENCES_DATA_01
 PARTITION BY LIST
 (link_type_id)
 (PARTITION p_Macro2Individ VALUES (1) NOCOMPRESS);

COMMENT ON COLUMN u_dw_references.t_lng_links.parent_lng_id is
'Link: Paranet Object - Languages T_LANGUAGES';

COMMENT ON COLUMN u_dw_references.t_lng_links.child_lng_id is
'Link: Child Object - Languages T_LANGUAGES';

COMMENT ON COLUMN u_dw_references.t_lng_links.link_type_id is
'Link Type: 1 - Macrolanguages to Individual Languages';

ALTER TABLE u_dw_references.t_lng_links
   ADD CONSTRAINT FK_T_LANGUAGES2T_LNG_LINKS_C FOREIGN KEY (child_lng_id)
      REFERENCES u_dw_references.t_languages (lng_id);

ALTER TABLE u_dw_references.t_lng_links
   ADD CONSTRAINT FK_T_LANGUAGES2T_LNG_LINKS_P FOREIGN KEY (parent_lng_id)
      REFERENCES u_dw_references.t_languages (lng_id);
