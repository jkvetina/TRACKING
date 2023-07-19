CREATE OR REPLACE FORCE VIEW trc_activity_pages_v AS
SELECT
    p.workspace,
    p.application_id,
    p.application_name,
    p.page_id,
    p.page_name
FROM apex_application_pages p
WHERE 1 = 1
    AND p.application_name  IS NOT NULL
    AND p.workspace         != 'INTERNAL'
GROUP BY
    p.workspace,
    p.application_id,
    p.application_name,
    p.page_id,
    p.page_name;
--
COMMENT ON TABLE trc_activity_pages_v IS '';

