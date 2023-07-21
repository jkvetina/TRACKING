CREATE OR REPLACE FORCE VIEW trc_lov_activity_users_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_item('$APPLICATION_ID')    AS app_id,
        core.get_item('$PAGE_ID')           AS page_id
    FROM DUAL
),
a AS (
    SELECT /*+ MATERIALIZE */
        a.apex_user,
        COUNT(*)        AS count_
    FROM trc_activity_log_v a
    CROSS JOIN x
    WHERE 1 = 1
        AND (a.application_id = x.app_id    OR x.app_id IS NULL)
        AND (a.page_id = x.page_id          OR x.page_id IS NULL)
    GROUP BY
        a.apex_user
)
SELECT
    'All'               AS group_name,
    a.apex_user,
    ROW_NUMBER() OVER(ORDER BY a.apex_user DESC) AS order#
FROM a
UNION ALL
SELECT
    ' Top 10'           AS group_name,
    a.apex_user,
    a.r#
FROM (
    SELECT
        a.apex_user,
        ROW_NUMBER() OVER(ORDER BY a.count_ DESC) AS r#
    FROM a
) a
WHERE a.r# <= 10;


