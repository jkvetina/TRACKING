CREATE OR REPLACE FORCE VIEW trc_lov_activity_users_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$APPLICATION_ID')    AS app_id,
        core.get_item('$PAGE_ID')           AS page_id
    FROM DUAL
)
SELECT
    a.apex_user
FROM trc_activity_log_v a
CROSS JOIN x
WHERE 1 = 1
    AND (a.application_id = x.app_id    OR x.app_id IS NULL)
    AND (a.page_id = x.page_id          OR x.page_id IS NULL)
GROUP BY
    a.apex_user;
--
COMMENT ON TABLE trc_lov_activity_users_v IS '';

