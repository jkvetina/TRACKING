prompt --application/shared_components/logic/build_options
begin
--   Manifest
--     BUILD OPTIONS: 755
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>755
,p_default_id_offset=>138245292394615020
,p_default_owner=>'APPS'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(101866716812096551)
,p_build_option_name=>'NEVER'
,p_build_option_status=>'EXCLUDE'
,p_on_upgrade_keep_status=>true
,p_build_option_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Alternative for server side condition = NEVER',
'so we can keep what is set there'))
);
wwv_flow_imp.component_end;
end;
/
