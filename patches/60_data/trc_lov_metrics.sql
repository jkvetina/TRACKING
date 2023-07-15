BEGIN
    DBMS_OUTPUT.PUT_LINE('--');
    DBMS_OUTPUT.PUT_LINE('-- MERGE ' || UPPER('trc_lov_metrics'));
    DBMS_OUTPUT.PUT_LINE('--');
END;
/
--
DELETE FROM trc_lov_metrics;
--
MERGE INTO trc_lov_metrics t
USING (
    SELECT 'ACTIVITY' AS metric_code, 'Activity' AS metric_name, 'COLOR_ACTIVITY' AS color_name, 10 AS order# FROM DUAL UNION ALL
    SELECT 'AVG_TIME' AS metric_code, 'Average Time' AS metric_name, 'COLOR_TIME' AS color_name, 40 AS order# FROM DUAL UNION ALL
    SELECT 'MAX_TIME' AS metric_code, 'Max Time' AS metric_name, 'COLOR_TIME' AS color_name, 70 AS order# FROM DUAL UNION ALL
    SELECT 'MEDIAN_TIME' AS metric_code, 'Median Time' AS metric_name, 'COLOR_TIME' AS color_name, 50 AS order# FROM DUAL UNION ALL
    SELECT 'MIN_TIME' AS metric_code, 'Min Time' AS metric_name, 'COLOR_TIME' AS color_name, 60 AS order# FROM DUAL UNION ALL
    SELECT 'SESSIONS' AS metric_code, 'Sessions' AS metric_name, 'COLOR_ACTIVITY' AS color_name, 30 AS order# FROM DUAL UNION ALL
    SELECT 'USERS' AS metric_code, 'Users' AS metric_name, 'COLOR_USERS' AS color_name, 20 AS order# FROM DUAL
) s
ON (
    t.metric_code = s.metric_code
)
--WHEN MATCHED THEN
--    UPDATE SET
--        t.metric_name = s.metric_name,
--        t.color_name = s.color_name,
--        t.order# = s.order#
WHEN NOT MATCHED THEN
    INSERT (
        t.metric_code,
        t.metric_name,
        t.color_name,
        t.order#
    )
    VALUES (
        s.metric_code,
        s.metric_name,
        s.color_name,
        s.order#
    );
