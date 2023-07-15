CREATE TABLE trc_lov_metrics (
    metric_code                     VARCHAR2(32)    NOT NULL,
    metric_name                     VARCHAR2(32)    NOT NULL,
    color_name                      VARCHAR2(32),
    order#                          NUMBER(4,0),
    --
    CONSTRAINT pk_trc_lov_metrics
        PRIMARY KEY (metric_code)
);
--
COMMENT ON TABLE trc_lov_metrics IS '';
--
COMMENT ON COLUMN trc_lov_metrics.metric_code   IS '';
COMMENT ON COLUMN trc_lov_metrics.metric_name   IS '';
COMMENT ON COLUMN trc_lov_metrics.color_name    IS '';
COMMENT ON COLUMN trc_lov_metrics.order#        IS '';

