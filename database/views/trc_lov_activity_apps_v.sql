CREATE OR REPLACE FORCE VIEW trc_lov_activity_apps_v AS
WITH p AS (
    SELECT /*+ MATERIALIZE */
        p.application_id,
        p.application_name,
        p.workspace
    FROM trc_activity_pages_v p
)
SELECT
    p.application_id,
    RTRIM(p.application_id || ' - ' || p.application_name, ' - ') AS application_name,
    p.workspace || CASE WHEN COUNT(a.page_id) = 0 THEN ' [NOT USED]' END AS workspace
FROM p
LEFT JOIN trc_activity_log_v a
    ON a.application_id     = p.application_id
GROUP BY
    p.application_id,
    p.application_name,
    p.workspace;
--
COMMENT ON TABLE trc_lov_activity_apps_v IS '';

