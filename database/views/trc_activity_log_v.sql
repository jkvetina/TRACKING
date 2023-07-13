CREATE OR REPLACE FORCE VIEW trc_activity_log_v AS
SELECT
    a.application_id,
    a.page_id,
    a.page_name,
    a.apex_user,
    a.view_date,
    a.elapsed_time,
    a.page_view_type,
    a.view_timestamp,
    a.apex_session_id,
    a.workspace,
    a.application_name
FROM trc_activity_log_mv a;
--
COMMENT ON TABLE trc_activity_log_v IS '';

