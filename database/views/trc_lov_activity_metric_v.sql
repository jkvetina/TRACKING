CREATE OR REPLACE FORCE VIEW trc_lov_activity_metric_v AS
SELECT
    t.metric_code   AS id,
    t.metric_name   AS name,
    t.order#        AS order#
FROM trc_lov_metrics t;
--
COMMENT ON TABLE trc_lov_activity_metric_v IS '';

