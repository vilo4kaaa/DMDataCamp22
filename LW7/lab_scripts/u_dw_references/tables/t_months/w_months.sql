CREATE OR REPLACE VIEW u_dw_references.w_months AS
    SELECT month_id, calendar_month_number, days_in_cal_month, end_of_cal_month, calendar_month_name
    FROM t_months;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_months to u_dw_ext_references;
