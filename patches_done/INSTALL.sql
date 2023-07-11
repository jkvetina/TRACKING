--
-- INIT
--
@@"../../patches/10_init/01_init.sql"

--
-- TABLES
--
@@"../../database/tables/trc_lov_colors.sql"
@@"../../database/tables/trc_navigation.sql"

--
-- OBJECTS
--
@@"../../database/packages/trc_app.spec.sql"
@@"../../database/views/trc_activity_log_v.sql"
@@"../../database/views/trc_activity_chart_v.sql"
@@"../../database/views/trc_lov_activity_metric_v.sql"
@@"../../database/views/trc_lov_activity_source_v.sql"
@@"../../database/views/trc_lov_activity_apps_v.sql"
@@"../../database/views/trc_lov_activity_pages_v.sql"
@@"../../database/views/trc_lov_activity_users_v.sql"
@@"../../database/packages/trc_app.sql"

--
-- MVIEWS
--
@@"../../database/mviews/trc_navigation_map_mv.sql"
@@"../../database/views/trc_navigation_top_v.sql"

--
-- DATA
--
@@"../../patches/60_data/trc_navigation.sql"
@@"../../patches/60_data/trc_lov_colors.sql"
--
COMMIT;

--
-- FINALLY
--
@@"../../patches/90_finally/98_checks.sql"
@@"../../patches/90_finally/96_stats.sql"
@@"../../patches/90_finally/94_indexes.sql"
@@"../../patches/90_finally/90_recompile.sql"
@@"../../patches/90_finally/92_refresh_mvw.sql"

--
-- APEX
--
@@"../../database/apex/f755/f755.sql"

