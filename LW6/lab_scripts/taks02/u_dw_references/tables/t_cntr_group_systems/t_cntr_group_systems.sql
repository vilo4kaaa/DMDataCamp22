--drop trigger u_dw_references.bi_t_cntr_group_systems
--/
--
--alter table u_dw_references.t_cntr_group_systems
--   drop constraint FK_T_GEO_OBJECTS2CNTR_G_SYSTEM
--/
--
--drop table u_dw_references.t_cntr_group_systems cascade constraints
--/

--==============================================================
-- Table: t_cntr_group_systems                                  
--==============================================================
create table u_dw_references.t_cntr_group_systems 
(
   geo_id               NUMBER(22,0)         not null,
   grp_system_id        NUMBER(22,0)         not null,
   constraint PK_T_CNTR_GROUP_SYSTEMS primary key (geo_id)
)
organization index tablespace TS_REFERENCES_DATA_01
/

comment on table u_dw_references.t_cntr_group_systems is
'Referense store:  Grouping Systems of Countries'
/

comment on column u_dw_references.t_cntr_group_systems.geo_id is
'Unique ID for All Geography objects'
/

comment on column u_dw_references.t_cntr_group_systems.grp_system_id is
'ID Code of Grouping System Specifications'
/

alter table u_dw_references.t_cntr_group_systems
   add constraint FK_T_GEO_OBJECTS2CNTR_G_SYSTEM foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade
      deferrable
/


create trigger u_dw_references.bi_t_cntr_group_systems before insert
on u_dw_references.t_cntr_group_systems for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    lc_geo_id      NUMBER := 0;
BEGIN
   IF :new.geo_id IS NOT NULL THEN
      raise_application_error ( -20000
                              , 'Geo_id have to be ''NULL''. New Values will be generated by triger.' );
   END IF;

   INSERT INTO w_geo_objects ( geo_id
                             , geo_type_id
                             , geo_code_id )
        VALUES ( sq_geo_t_id.NEXTVAL
               , 50 --GROUPING SYSTEMS
               , :new.grp_system_id )
     RETURNING geo_id
          INTO :new.geo_id;
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/
