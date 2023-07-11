CREATE OR REPLACE FORCE VIEW trc_lov_activity_source_v AS
SELECT 'rendering:' AS id,      'Rendering' AS name         FROM DUAL UNION ALL
SELECT 'processing:',           'Processing'                FROM DUAL UNION ALL
SELECT 'processing:rendering:', 'Processing + Rendering'    FROM DUAL UNION ALL
SELECT 'ajax:',                 'AJAX'                      FROM DUAL UNION ALL
SELECT 'auth:',                 'Auth Callback'             FROM DUAL UNION ALL
SELECT NULL,                    'Any'                       FROM DUAL;
--
COMMENT ON TABLE trc_lov_activity_source_v IS '';

