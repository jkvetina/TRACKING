CREATE OR REPLACE FORCE VIEW trc_activity_pages_v AS
SELECT
    p.workspace,
    p.application_id,
    p.application_name,
    p.page_id,
    p.page_name,
    p.page_alias,
    p.page_group
FROM apex_application_pages p
WHERE 1 = 1
    AND p.application_name  IS NOT NULL
    AND p.workspace         != 'INTERNAL'
    AND p.page_id           > 0;
--
COMMENT ON TABLE trc_activity_pages_v IS '';

