CREATE INDEX trc_activity_log_mv_page
    ON trc_activity_log_mv (application_id, page_id, page_view_type)
    COMPUTE STATISTICS
    TABLESPACE "DATA";

