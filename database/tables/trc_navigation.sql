CREATE TABLE trc_navigation (
    page_id                         NUMBER(8,0)     CONSTRAINT nn_trc_navigation_page_id NOT NULL,
    parent_id                       NUMBER(8,0),
    is_hidden                       CHAR(1),
    is_reset                        CHAR(1),
    order#                          NUMBER(4,0),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT ch_trc_navigation_is_hidden
        CHECK (is_hidden = 'Y' OR is_hidden IS NULL),
    --
    CONSTRAINT ch_trc_navigation_is_reset
        CHECK (is_reset = 'Y' OR is_reset IS NULL),
    --
    CONSTRAINT pk_trc_navigation
        PRIMARY KEY (page_id),
    --
    CONSTRAINT fk_trc_navigation_parent
        FOREIGN KEY (parent_id)
        REFERENCES trc_navigation (page_id)
        DEFERRABLE INITIALLY DEFERRED
);
--
COMMENT ON TABLE trc_navigation IS '';
--
COMMENT ON COLUMN trc_navigation.page_id        IS '';
COMMENT ON COLUMN trc_navigation.parent_id      IS '';
COMMENT ON COLUMN trc_navigation.is_hidden      IS '';
COMMENT ON COLUMN trc_navigation.is_reset       IS '';
COMMENT ON COLUMN trc_navigation.order#         IS '';

