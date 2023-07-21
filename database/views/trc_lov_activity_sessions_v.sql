CREATE OR REPLACE FORCE VIEW trc_lov_activity_sessions_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$APPLICATION_ID')    AS app_id,
        core.get_number_item('$PAGE_ID')    AS page_id,
        core.get_item('$USER_ID')           AS user_id
    FROM DUAL
)
SELECT
    TRUNC(a.view_date) AS view_date,
    a.apex_session_id
FROM trc_activity_log_v a
CROSS JOIN x
WHERE 1 = 1
    AND (a.application_id = x.app_id    OR x.app_id IS NULL)
    AND (a.page_id = x.page_id          OR x.page_id IS NULL)
    AND (a.apex_user = x.user_id        OR x.user_id IS NULL)
GROUP BY
    TRUNC(a.view_date),
    a.apex_session_id;
--
COMMENT ON TABLE trc_lov_activity_sessions_v IS '';

