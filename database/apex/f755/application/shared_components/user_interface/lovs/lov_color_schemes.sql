prompt --application/shared_components/user_interface/lovs/lov_color_schemes
begin
--   Manifest
--     LOV_COLOR_SCHEMES
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
 p_id=>wwv_flow_imp.id(8116205990834229)  -- LOV_COLOR_SCHEMES
,p_lov_name=>'LOV_COLOR_SCHEMES'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DISTINCT name',
'FROM trc_lov_colors;'))
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_return_column_name=>'NAME'
,p_display_column_name=>'NAME'
,p_default_sort_column_name=>'NAME'
,p_default_sort_direction=>'ASC'
);
wwv_flow_imp.component_end;
end;
/
