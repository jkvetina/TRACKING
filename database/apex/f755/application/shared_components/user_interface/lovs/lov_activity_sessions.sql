prompt --application/shared_components/user_interface/lovs/lov_activity_sessions
begin
--   Manifest
--     LOV_ACTIVITY_SESSIONS
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>755
,p_default_id_offset=>138245292394615020
,p_default_owner=>'APPS'
);
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(8578536440026808)  -- LOV_ACTIVITY_SESSIONS
,p_lov_name=>'LOV_ACTIVITY_SESSIONS'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'TRC_LOV_ACTIVITY_SESSIONS_V'
,p_return_column_name=>'APEX_SESSION_ID'
,p_display_column_name=>'APEX_SESSION_ID'
,p_default_sort_column_name=>'APEX_SESSION_ID'
,p_default_sort_direction=>'ASC'
);
wwv_flow_imp.component_end;
end;
/
