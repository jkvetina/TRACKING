BEGIN
    DBMS_UTILITY.EXEC_DDL_STATEMENT('DROP MATERIALIZED VIEW TRC_ACTIVITY_LOG_MV');
    DBMS_OUTPUT.PUT_LINE('--');
    DBMS_OUTPUT.PUT_LINE('-- MATERIALIZED VIEW TRC_ACTIVITY_LOG_MV DROPPED');
    DBMS_OUTPUT.PUT_LINE('--');
EXCEPTION
WHEN OTHERS THEN
    NULL;
END;
/
--
CREATE MATERIALIZED VIEW trc_activity_log_mv
TABLESPACE "DATA"
BUILD IMMEDIATE
REFRESH FORCE ON DEMAND
AS
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
FROM apex_workspace_activity_log a
WHERE 1 = 1
    AND a.application_id    IS NOT NULL
    AND a.application_name  IS NOT NULL     -- to remove other workspaces
    AND a.page_id           > 0;
--

