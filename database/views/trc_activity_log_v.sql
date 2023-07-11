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
FROM trc_activity_log a
--FROM apex_workspace_activity_log a
WHERE 1 = 1
    AND a.application_id    IS NOT NULL
    AND a.page_id           IS NOT NULL;
--
COMMENT ON TABLE trc_activity_log_v IS '';

