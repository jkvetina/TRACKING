CREATE OR REPLACE FORCE VIEW trc_lov_activity_pages_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$APPLICATION_ID')    AS app_id,
        core.get_number_item('$PAGE_ID')    AS page_id,
        core.get_item('$PAGE_GROUP')        AS page_group
    FROM DUAL
),
p AS (
    SELECT /*+ MATERIALIZE */
        p.application_id,
        p.page_id,
        p.page_name,
        p.page_group
    FROM trc_activity_pages_v p
    CROSS JOIN x
    WHERE 1 = 1
        AND p.application_id = x.app_id
        --AND (p.application_id = x.app_id    OR x.app_id IS NULL)
        AND (p.page_id      = x.page_id     OR NULLIF(x.page_id, 0) IS NULL)
        AND (p.page_group   = x.page_group  OR x.page_group IS NULL)
)
SELECT
    TO_CHAR(x.app_id)   AS group_name,
    TO_NUMBER(NULL)     AS page_id,
    'All pages'         AS page_name
FROM x
UNION ALL
SELECT
    TO_CHAR(x.app_id)   AS group_name,
    0                   AS page_id,
    'Used pages only'   AS page_name
FROM x
UNION ALL
SELECT
    p.application_id ||
    CASE
        WHEN x.app_id IS NOT NULL THEN NVL(RTRIM(' - ' || p.page_group, ' - '), ' [NO GROUP]')
        END ||
    CASE
        WHEN COUNT(a.page_id) = 0 THEN ' [NOT USED]'
        END AS group_name,
    --
    p.page_id,
    RTRIM(p.page_id || ' - ' || p.page_name, ' - ') AS page_name
FROM p
CROSS JOIN x
LEFT JOIN trc_activity_log_v a
    ON a.application_id     = p.application_id
    AND a.page_id           = p.page_id
GROUP BY
    x.app_id,
    p.application_id,
    p.page_id,
    p.page_name,
    p.page_group;
--
COMMENT ON TABLE trc_lov_activity_pages_v IS '';

