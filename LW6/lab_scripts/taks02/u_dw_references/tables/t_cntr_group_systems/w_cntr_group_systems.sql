--drop view u_dw_references.w_cntr_group_systems;

--==============================================================
-- View: w_cntr_group_systems                                   
--==============================================================
create or replace view u_dw_references.w_cntr_group_systems as
SELECT geo_id
     , grp_system_id     
  FROM t_cntr_group_systems;

 comment on table u_dw_references.w_cntr_group_systems is
'Work View: T_GEO_TYPES';

comment on column u_dw_references.w_cntr_group_systems.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.w_cntr_group_systems.grp_system_id is
'ID Code of Grouping System Specifications';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_cntr_group_systems to u_dw_ext_references;
