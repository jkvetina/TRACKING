prompt --application/shared_components/user_interface/themes
begin
--   Manifest
--     THEME: 755
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>755
,p_default_id_offset=>138245292394615020
,p_default_owner=>'APPS'
);
wwv_flow_imp_shared.create_theme(
 p_id=>wwv_flow_imp.id(124371338697403346)
,p_theme_id=>700
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_reference_id=>38080028704322422
,p_is_locked=>false
,p_default_page_template=>wwv_flow_imp.id(89271646027804949)
,p_default_dialog_template=>wwv_flow_imp.id(124210788196403229)
,p_error_template=>wwv_flow_imp.id(124200790766403223)
,p_printer_friendly_template=>wwv_flow_imp.id(124216019482403232)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_imp.id(124200790766403223)
,p_default_button_template=>wwv_flow_imp.id(124368330622403335)
,p_default_region_template=>wwv_flow_imp.id(124229450469403242)
,p_default_chart_template=>wwv_flow_imp.id(124295458531403284)
,p_default_form_template=>wwv_flow_imp.id(124295458531403284)
,p_default_reportr_template=>wwv_flow_imp.id(124295458531403284)
,p_default_tabform_template=>wwv_flow_imp.id(124295458531403284)
,p_default_wizard_template=>wwv_flow_imp.id(124295458531403284)
,p_default_menur_template=>wwv_flow_imp.id(124307902387403291)
,p_default_listr_template=>wwv_flow_imp.id(124295458531403284)
,p_default_irr_template=>wwv_flow_imp.id(124285680602403279)
,p_default_report_template=>wwv_flow_imp.id(124333367602403309)
,p_default_label_template=>wwv_flow_imp.id(124365926097403332)
,p_default_menu_template=>wwv_flow_imp.id(124369945226403337)
,p_default_calendar_template=>wwv_flow_imp.id(124370053364403338)
,p_default_list_template=>wwv_flow_imp.id(124349734632403320)
,p_default_nav_list_template=>wwv_flow_imp.id(124361563495403329)
,p_default_top_nav_list_temp=>wwv_flow_imp.id(124361563495403329)
,p_default_side_nav_list_temp=>wwv_flow_imp.id(124356225941403325)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_imp.id(124232306915403246)
,p_default_dialogr_template=>wwv_flow_imp.id(124229450469403242)
,p_default_option_label=>wwv_flow_imp.id(124365926097403332)
,p_default_required_label=>wwv_flow_imp.id(124367190409403333)
,p_default_navbar_list_template=>wwv_flow_imp.id(124355783810403324)
,p_file_prefix => nvl(wwv_flow_application_install.get_static_theme_file_prefix(700),'#APEX_FILES#themes/theme_42/22.2/')
,p_files_version=>64
,p_icon_library=>'FONTAPEX'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#APEX_FILES#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#THEME_FILES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_FILES#css/Core#MIN#.css?v=#APEX_VERSION#'
);
wwv_flow_imp.component_end;
end;
/
