prompt --application/user_interfaces
begin
--   Manifest
--     USER INTERFACES: 755
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>755
,p_default_id_offset=>138245292394615020
,p_default_owner=>'APPS'
);
wwv_flow_imp_shared.create_user_interface(
 p_id=>wwv_flow_imp.id(755)
,p_theme_id=>700
,p_home_url=>'f?p=&APP_ID.:HOME:&APP_SESSION.::&DEBUG.:::'
,p_login_url=>'f?p=&APP_ID.:LOGIN:&APP_SESSION.::&DEBUG.:::'
,p_theme_style_by_user_pref=>false
,p_built_with_love=>false
,p_global_page_id=>0
,p_navigation_list_position=>'TOP'
,p_navigation_list_template_id=>wwv_flow_imp.id(124361563495403329)
,p_nav_list_template_options=>'#DEFAULT#:js-tabLike'
,p_css_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#WORKSPACE_FILES#master_fonts#MIN#.css?version=#APP_VERSION#',
'#WORKSPACE_FILES#master_menu_top#MIN#.css?version=#APP_VERSION#',
'#WORKSPACE_FILES#master_app#MIN#.css?version=#APP_VERSION#',
'#APP_FILES#app#MIN#.css?version=#APP_VERSION#'))
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#WORKSPACE_FILES#master_app#MIN#.js?version=#APP_VERSION#',
'#APP_FILES#app#MIN#.js?version=#APP_VERSION#'))
,p_nav_bar_type=>'LIST'
,p_nav_bar_list_id=>wwv_flow_imp.id(88850119760794967)
,p_nav_bar_list_template_id=>wwv_flow_imp.id(89567869122805182)
,p_nav_bar_template_options=>'#DEFAULT#'
);
wwv_flow_imp.component_end;
end;
/
