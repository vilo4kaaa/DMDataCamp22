CREATE OR REPLACE VIEW u_dw_references.w_weeks AS
    SELECT WEEK_ID, CALENDAR_WEEK_NUMBER, WEEK_ENDING_DATE   
    FROM t_weeks;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_weeks to u_dw_ext_references;