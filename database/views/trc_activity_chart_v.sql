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
        NVL(m.color_name, 'COLOR_' || core.get_item('$METRIC')) AS color,
        trc_app.get_offset() AS day_offset  -- to align with week days
    FROM DUAL
    LEFT JOIN trc_lov_metrics m
        ON m.metric_code = core.get_item('$METRIC')
),
p AS (
    SELECT /*+ MATERIALIZE */
        p.application_id,
        p.page_id,
        p.page_name
    FROM trc_activity_pages_v p
    JOIN x
        ON (x.app_id        = p.application_id  OR x.app_id IS NULL)
        AND (x.page_id      = p.page_id         OR x.page_id IS NULL)
    GROUP BY
        p.application_id,
        p.page_id,
        p.page_name
),
a AS (
    SELECT /*+ MATERIALIZE */
        a.application_id,
        a.page_id,
        a.page_name,
        TRUNC(a.view_date)      AS view_date,
        a.page_view_type,
        a.elapsed_time,
        a.apex_user,
        a.apex_session_id,
        x.metric,
        x.day_offset
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
        p.application_id,
        p.page_id,
        p.page_name,
        a.view_date,
        --
        CASE a.metric
            WHEN 'ACTIVITY'     THEN COUNT(*)
            WHEN 'USERS'        THEN COUNT(DISTINCT a.apex_user)
            WHEN 'SESSIONS'     THEN COUNT(DISTINCT a.apex_session_id)
            WHEN 'AVG_TIME'     THEN ROUND(AVG(a.elapsed_time), 2)
            WHEN 'MEDIAN_TIME'  THEN ROUND(MIN(a.elapsed_time), 2)
            WHEN 'MIN_TIME'     THEN ROUND(MIN(a.elapsed_time), 2)
            WHEN 'MAX_TIME'     THEN ROUND(MAX(a.elapsed_time), 2)
            END AS value
    FROM p
    LEFT JOIN a
        ON a.application_id     = p.application_id
        AND a.page_id           = p.page_id
    GROUP BY
        p.application_id,
        p.page_id,
        p.page_name,
        a.view_date,
        a.metric
),
t AS (
    SELECT
        s.application_id,
        s.page_id,
        s.page_name,
        --
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today      + day_offset THEN s.value END, 0)), 0) AS t00,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today -  1 + day_offset THEN s.value END, 0)), 0) AS t01,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today -  2 + day_offset THEN s.value END, 0)), 0) AS t02,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today -  3 + day_offset THEN s.value END, 0)), 0) AS t03,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today -  4 + day_offset THEN s.value END, 0)), 0) AS t04,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today -  5 + day_offset THEN s.value END, 0)), 0) AS t05,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today -  6 + day_offset THEN s.value END, 0)), 0) AS t06,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today -  7 + day_offset THEN s.value END, 0)), 0) AS t07,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today -  8 + day_offset THEN s.value END, 0)), 0) AS t08,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today -  9 + day_offset THEN s.value END, 0)), 0) AS t09,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 10 + day_offset THEN s.value END, 0)), 0) AS t10,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 11 + day_offset THEN s.value END, 0)), 0) AS t11,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 12 + day_offset THEN s.value END, 0)), 0) AS t12,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 13 + day_offset THEN s.value END, 0)), 0) AS t13,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 14 + day_offset THEN s.value END, 0)), 0) AS t14,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 15 + day_offset THEN s.value END, 0)), 0) AS t15,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 16 + day_offset THEN s.value END, 0)), 0) AS t16,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 17 + day_offset THEN s.value END, 0)), 0) AS t17,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 18 + day_offset THEN s.value END, 0)), 0) AS t18,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 19 + day_offset THEN s.value END, 0)), 0) AS t19,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 20 + day_offset THEN s.value END, 0)), 0) AS t20,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 21 + day_offset THEN s.value END, 0)), 0) AS t21,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 22 + day_offset THEN s.value END, 0)), 0) AS t22,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 23 + day_offset THEN s.value END, 0)), 0) AS t23,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 24 + day_offset THEN s.value END, 0)), 0) AS t24,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 25 + day_offset THEN s.value END, 0)), 0) AS t25,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 26 + day_offset THEN s.value END, 0)), 0) AS t26,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 27 + day_offset THEN s.value END, 0)), 0) AS t27,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 28 + day_offset THEN s.value END, 0)), 0) AS t28,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 29 + day_offset THEN s.value END, 0)), 0) AS t29,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 30 + day_offset THEN s.value END, 0)), 0) AS t30,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 31 + day_offset THEN s.value END, 0)), 0) AS t31,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 32 + day_offset THEN s.value END, 0)), 0) AS t32,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 33 + day_offset THEN s.value END, 0)), 0) AS t33,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 34 + day_offset THEN s.value END, 0)), 0) AS t34,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 35 + day_offset THEN s.value END, 0)), 0) AS t35,
        NULLIF(SUM(NVL(CASE WHEN s.view_date = x.today - 36 + day_offset THEN s.value END, 0)), 0) AS t36
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
    --
    t.t00, t.t01, t.t02, t.t03, t.t04, t.t05, t.t06, t.t07, t.t08, t.t09,
    t.t10, t.t11, t.t12, t.t13, t.t14, t.t15, t.t16, t.t17, t.t18, t.t19,
    t.t20, t.t21, t.t22, t.t23, t.t24, t.t25, t.t26, t.t27, t.t28, t.t29,
    t.t30, t.t31, t.t32, t.t33, t.t34, t.t35, t.t36,
    --
    trc_app.get_value_color(x.color, t.t00) AS t00_color,   trc_app.get_value_color(x.color, t.t00, 'Y') AS t00_text,
    trc_app.get_value_color(x.color, t.t01) AS t01_color,   trc_app.get_value_color(x.color, t.t01, 'Y') AS t01_text,
    trc_app.get_value_color(x.color, t.t02) AS t02_color,   trc_app.get_value_color(x.color, t.t02, 'Y') AS t02_text,
    trc_app.get_value_color(x.color, t.t03) AS t03_color,   trc_app.get_value_color(x.color, t.t03, 'Y') AS t03_text,
    trc_app.get_value_color(x.color, t.t04) AS t04_color,   trc_app.get_value_color(x.color, t.t04, 'Y') AS t04_text,
    trc_app.get_value_color(x.color, t.t05) AS t05_color,   trc_app.get_value_color(x.color, t.t05, 'Y') AS t05_text,
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
    trc_app.get_value_color(x.color, t.t30) AS t30_color,   trc_app.get_value_color(x.color, t.t30, 'Y') AS t30_text,
    trc_app.get_value_color(x.color, t.t31) AS t31_color,   trc_app.get_value_color(x.color, t.t31, 'Y') AS t31_text,
    trc_app.get_value_color(x.color, t.t32) AS t32_color,   trc_app.get_value_color(x.color, t.t32, 'Y') AS t32_text,
    trc_app.get_value_color(x.color, t.t33) AS t33_color,   trc_app.get_value_color(x.color, t.t33, 'Y') AS t33_text,
    trc_app.get_value_color(x.color, t.t34) AS t34_color,   trc_app.get_value_color(x.color, t.t34, 'Y') AS t34_text,
    trc_app.get_value_color(x.color, t.t35) AS t35_color,   trc_app.get_value_color(x.color, t.t35, 'Y') AS t35_text,
    trc_app.get_value_color(x.color, t.t36) AS t36_color,   trc_app.get_value_color(x.color, t.t36, 'Y') AS t36_text
FROM t
CROSS JOIN x;
--
COMMENT ON TABLE trc_activity_chart_v IS '';

