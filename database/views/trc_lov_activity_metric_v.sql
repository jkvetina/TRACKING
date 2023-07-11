CREATE OR REPLACE FORCE VIEW trc_lov_activity_metric_v AS
SELECT 'ACTIVITY' AS id,    'Activity'  AS name FROM DUAL UNION ALL
SELECT 'USERS',             'Users'             FROM DUAL UNION ALL
SELECT 'SESSIONS',          'Sessions'          FROM DUAL UNION ALL
SELECT 'AVG_TIME',          'AVG Time'          FROM DUAL UNION ALL
SELECT 'MAX_TIME',          'MAX Time'          FROM DUAL;
--
COMMENT ON TABLE trc_lov_activity_metric_v IS '';

