CREATE TABLE trc_lov_colors (
    name                            VARCHAR2(32),
    treshold                        NUMBER,
    color_bg                        VARCHAR2(8),
    color_text                      VARCHAR2(8),
    --
    CONSTRAINT pk_trc_lov_colors
        PRIMARY KEY (name, treshold)
);
--
COMMENT ON TABLE trc_lov_colors IS '';
--
COMMENT ON COLUMN trc_lov_colors.name           IS '';
COMMENT ON COLUMN trc_lov_colors.treshold       IS '';
COMMENT ON COLUMN trc_lov_colors.color_bg       IS '';
COMMENT ON COLUMN trc_lov_colors.color_text     IS '';

