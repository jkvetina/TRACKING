CREATE OR REPLACE FORCE VIEW trc_activity_chart_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        TRUNC(SYSDATE)                      AS today,
        core.get_item('$APPLICATION_ID')    AS app_id,
        core.get_item('$PAGE_ID')           AS page_id,
        core.get_item('$USER_ID')           AS user_id,
        core.get_item('$METRIC')            AS metric,
        --
        CASE WHEN INSTR(NVL(NULLIF(core.get_item('$SOURCE'), ':'), 'rendering:'), 'rendering:')     > 0 THEN 'Y' END AS count_rendering,
        CASE WHEN INSTR(NVL(NULLIF(core.get_item('$SOURCE'), ':'), 'processing:'), 'processing:')   > 0 THEN 'Y' END AS count_processing,
        CASE WHEN INSTR(NVL(NULLIF(core.get_item('$SOURCE'), ':'), 'ajax:'), 'ajax:')               > 0 THEN 'Y' END AS count_ajax,
        CASE WHEN INSTR(NVL(NULLIF(core.get_item('$SOURCE'), ':'), 'auth:'), 'auth:')               > 0 THEN 'Y' END AS count_auth,
        --
        'COLOR_' || core.get_item('$METRIC') AS color
    FROM DUAL
),
a AS (
    SELECT /*+ MATERIALIZE */
        a.application_id,
        a.page_id,
        NULL                    AS page_name,
        TRUNC(a.view_date)      AS view_date,
        a.page_view_type,
        a.elapsed_time,
        a.apex_user,
        a.apex_session_id,
        x.metric
    FROM trc_activity_log_v a
    JOIN x
        ON x.app_id         = a.application_id
        AND (x.page_id      = a.page_id         OR x.page_id IS NULL)
        AND (x.user_id      = a.apex_user       OR x.user_id IS NULL)
    WHERE 1 = 1
        AND (
            (x.count_rendering  = 'Y' AND a.page_view_type = 'Rendering') OR
            (x.count_processing = 'Y' AND a.page_view_type = 'Processing') OR
            (x.count_ajax       = 'Y' AND a.page_view_type = 'Ajax') OR
            (x.count_auth       = 'Y' AND a.page_view_type = 'Authentication Callback')
        )
),
s AS (
    SELECT /*+ MATERIALIZE */
        a.application_id,
        a.page_id,
        NULL            AS page_name,
        a.view_date,
        --
        CASE a.metric
            WHEN 'ACTIVITY' THEN COUNT(*)
            WHEN 'USERS'    THEN COUNT(DISTINCT a.apex_user)
            WHEN 'SESSIONS' THEN COUNT(DISTINCT a.apex_session_id)
            WHEN 'AVG_TIME' THEN ROUND(AVG(a.elapsed_time), 2)
            WHEN 'MAX_TIME' THEN ROUND(MAX(a.elapsed_time), 2)
            END AS value
    FROM a
    GROUP BY
        a.application_id,
        a.page_id,
        a.view_date,
        a.metric
),
t AS (
    SELECT
        s.application_id,
        s.page_id,
        s.page_name,
        --
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today      THEN s.value END, 0)), 0) AS today,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today -  1 THEN s.value END, 0)), 0) AS t01,       -- yesterday
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today -  2 THEN s.value END, 0)), 0) AS t02,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today -  3 THEN s.value END, 0)), 0) AS t03,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today -  4 THEN s.value END, 0)), 0) AS t04,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today -  5 THEN s.value END, 0)), 0) AS t05,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today -  6 THEN s.value END, 0)), 0) AS t06,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today -  7 THEN s.value END, 0)), 0) AS t07,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today -  8 THEN s.value END, 0)), 0) AS t08,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today -  9 THEN s.value END, 0)), 0) AS t09,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 10 THEN s.value END, 0)), 0) AS t10,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 11 THEN s.value END, 0)), 0) AS t11,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 12 THEN s.value END, 0)), 0) AS t12,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 13 THEN s.value END, 0)), 0) AS t13,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 14 THEN s.value END, 0)), 0) AS t14,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 15 THEN s.value END, 0)), 0) AS t15,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 16 THEN s.value END, 0)), 0) AS t16,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 17 THEN s.value END, 0)), 0) AS t17,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 18 THEN s.value END, 0)), 0) AS t18,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 19 THEN s.value END, 0)), 0) AS t19,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 20 THEN s.value END, 0)), 0) AS t20,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 21 THEN s.value END, 0)), 0) AS t21,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 22 THEN s.value END, 0)), 0) AS t22,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 23 THEN s.value END, 0)), 0) AS t23,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 24 THEN s.value END, 0)), 0) AS t24,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 25 THEN s.value END, 0)), 0) AS t25,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 26 THEN s.value END, 0)), 0) AS t26,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 27 THEN s.value END, 0)), 0) AS t27,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 28 THEN s.value END, 0)), 0) AS t28,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 29 THEN s.value END, 0)), 0) AS t29,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 30 THEN s.value END, 0)), 0) AS t30
    FROM s
    CROSS JOIN x
    GROUP BY
        s.application_id,
        s.page_id,
        s.page_name
)
SELECT
    t.application_id,
    t.page_id,
    t.page_name,
    t.today,
    t.t01,
    t.t02,
    t.t03,
    t.t04,
    t.t05,
    t.t06,
    t.t07,
    t.t08,
    t.t09,
    t.t10,
    t.t11,
    t.t12,
    t.t13,
    t.t14,
    t.t15,
    t.t16,
    t.t17,
    t.t18,
    t.t19,
    t.t20,
    t.t21,
    t.t22,
    t.t23,
    t.t24,
    t.t25,
    t.t26,
    t.t27,
    t.t28,
    t.t29,
    t.t30,
    --
    trc_app.get_value_color(x.color, t.t01) AS t01_color,   trc_app.get_value_color(x.color, t.t01, 'Y') AS t01_text,
    trc_app.get_value_color(x.color, t.t02) AS t02_color,   trc_app.get_value_color(x.color, t.t02, 'Y') AS t02_text,
    trc_app.get_value_color(x.color, t.t03) AS t03_color,   trc_app.get_value_color(x.color, t.t03, 'Y') AS t03_text,
    trc_app.get_value_color(x.color, t.t04) AS t04_color,   trc_app.get_value_color(x.color, t.t04, 'Y') AS t04_text,
    trc_app.get_value_color(x.color, t.t04) AS t05_color,   trc_app.get_value_color(x.color, t.t04, 'Y') AS t05_text,
    trc_app.get_value_color(x.color, t.t06) AS t06_color,   trc_app.get_value_color(x.color, t.t06, 'Y') AS t06_text,
    trc_app.get_value_color(x.color, t.t07) AS t07_color,   trc_app.get_value_color(x.color, t.t07, 'Y') AS t07_text,
    trc_app.get_value_color(x.color, t.t08) AS t08_color,   trc_app.get_value_color(x.color, t.t08, 'Y') AS t08_text,
    trc_app.get_value_color(x.color, t.t09) AS t09_color,   trc_app.get_value_color(x.color, t.t09, 'Y') AS t09_text,
    trc_app.get_value_color(x.color, t.t10) AS t10_color,   trc_app.get_value_color(x.color, t.t10, 'Y') AS t10_text,
    trc_app.get_value_color(x.color, t.t11) AS t11_color,   trc_app.get_value_color(x.color, t.t11, 'Y') AS t11_text,
    trc_app.get_value_color(x.color, t.t12) AS t12_color,   trc_app.get_value_color(x.color, t.t12, 'Y') AS t12_text,
    trc_app.get_value_color(x.color, t.t13) AS t13_color,   trc_app.get_value_color(x.color, t.t13, 'Y') AS t13_text,
    trc_app.get_value_color(x.color, t.t14) AS t14_color,   trc_app.get_value_color(x.color, t.t14, 'Y') AS t14_text,
    trc_app.get_value_color(x.color, t.t15) AS t15_color,   trc_app.get_value_color(x.color, t.t15, 'Y') AS t15_text,
    trc_app.get_value_color(x.color, t.t16) AS t16_color,   trc_app.get_value_color(x.color, t.t16, 'Y') AS t16_text,
    trc_app.get_value_color(x.color, t.t17) AS t17_color,   trc_app.get_value_color(x.color, t.t17, 'Y') AS t17_text,
    trc_app.get_value_color(x.color, t.t18) AS t18_color,   trc_app.get_value_color(x.color, t.t18, 'Y') AS t18_text,
    trc_app.get_value_color(x.color, t.t19) AS t19_color,   trc_app.get_value_color(x.color, t.t19, 'Y') AS t19_text,
    trc_app.get_value_color(x.color, t.t20) AS t20_color,   trc_app.get_value_color(x.color, t.t20, 'Y') AS t20_text,
    trc_app.get_value_color(x.color, t.t21) AS t21_color,   trc_app.get_value_color(x.color, t.t21, 'Y') AS t21_text,
    trc_app.get_value_color(x.color, t.t22) AS t22_color,   trc_app.get_value_color(x.color, t.t22, 'Y') AS t22_text,
    trc_app.get_value_color(x.color, t.t23) AS t23_color,   trc_app.get_value_color(x.color, t.t23, 'Y') AS t23_text,
    trc_app.get_value_color(x.color, t.t24) AS t24_color,   trc_app.get_value_color(x.color, t.t24, 'Y') AS t24_text,
    trc_app.get_value_color(x.color, t.t25) AS t25_color,   trc_app.get_value_color(x.color, t.t25, 'Y') AS t25_text,
    trc_app.get_value_color(x.color, t.t26) AS t26_color,   trc_app.get_value_color(x.color, t.t26, 'Y') AS t26_text,
    trc_app.get_value_color(x.color, t.t27) AS t27_color,   trc_app.get_value_color(x.color, t.t27, 'Y') AS t27_text,
    trc_app.get_value_color(x.color, t.t28) AS t28_color,   trc_app.get_value_color(x.color, t.t28, 'Y') AS t28_text,
    trc_app.get_value_color(x.color, t.t29) AS t29_color,   trc_app.get_value_color(x.color, t.t29, 'Y') AS t29_text,
    trc_app.get_value_color(x.color, t.t30) AS t30_color,   trc_app.get_value_color(x.color, t.t30, 'Y') AS t30_text
FROM t
CROSS JOIN x
ORDER BY
    t.application_id,
    t.page_id;
--
COMMENT ON TABLE trc_activity_chart_v IS '';

