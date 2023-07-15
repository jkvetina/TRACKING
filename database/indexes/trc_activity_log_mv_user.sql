CREATE INDEX trc_activity_log_mv_user
    ON trc_activity_log_mv (application_id, apex_user, page_view_type)
    COMPUTE STATISTICS
    TABLESPACE "DATA";

