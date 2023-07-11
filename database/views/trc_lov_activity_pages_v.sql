CREATE OR REPLACE FORCE VIEW trc_lov_activity_pages_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$APPLICATION_ID')    AS app_id,
        core.get_item('$PAGE_ID')           AS page_id
    FROM DUAL
)
SELECT
    a.application_id,
    a.page_id,
    RTRIM(a.page_id || ' - ' || p.page_name, ' - ') AS page_name
FROM trc_activity_log_v a
CROSS JOIN x
LEFT JOIN apex_application_pages p
    ON p.application_id = a.application_id
    AND p.page_id       = a.page_id
WHERE 1 = 1
    AND (a.application_id = x.app_id    OR x.app_id IS NULL)
GROUP BY
    a.application_id,
    a.page_id,
    p.page_name;
--
COMMENT ON TABLE trc_lov_activity_pages_v IS '';

