CREATE OR REPLACE FORCE VIEW trc_activity_base_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$APPLICATION_ID')    AS app_id,
        core.get_number_item('$PAGE_ID')    AS page_id,
        core.get_item('$USER_ID')           AS user_id,
        core.get_number_item('$SESSION_ID') AS session_id,
        core.get_item('$METRIC')            AS metric,
        --
        CASE WHEN INSTR(NVL(NULLIF(core.get_item('$SOURCE'), ':'), 'rendering:'), 'rendering:')     > 0 THEN 'Y' END AS count_rendering,
        CASE WHEN INSTR(NVL(NULLIF(core.get_item('$SOURCE'), ':'), 'processing:'), 'processing:')   > 0 THEN 'Y' END AS count_processing,
        CASE WHEN INSTR(NVL(NULLIF(core.get_item('$SOURCE'), ':'), 'ajax:'), 'ajax:')               > 0 THEN 'Y' END AS count_ajax,
        CASE WHEN INSTR(NVL(NULLIF(core.get_item('$SOURCE'), ':'), 'auth:'), 'auth:')               > 0 THEN 'Y' END AS count_auth
    FROM DUAL
)
SELECT /*+ MATERIALIZE */
    a.application_id,
    a.page_id,
    a.page_name,
    TRUNC(a.view_date)      AS view_date,
    a.page_view_type,
    a.elapsed_time,
    a.apex_user,
    a.apex_session_id
FROM trc_activity_log_v a
JOIN x
    ON x.app_id         = a.application_id
    AND (x.page_id      = a.page_id         OR NULLIF(x.page_id, 0) IS NULL)
    AND (x.user_id      = a.apex_user       OR x.user_id IS NULL)
    AND (x.session_id   = a.apex_session_id OR x.session_id IS NULL)
WHERE 1 = 1
    AND (
        (x.count_rendering  = 'Y' AND a.page_view_type = 'Rendering') OR
        (x.count_processing = 'Y' AND a.page_view_type = 'Processing') OR
        (x.count_ajax       = 'Y' AND a.page_view_type = 'Ajax') OR
        (x.count_auth       = 'Y' AND a.page_view_type = 'Authentication Callback')
    );
--
COMMENT ON TABLE trc_activity_base_v IS '';

