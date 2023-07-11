prompt --application/pages/page_groups
begin
--   Manifest
--     PAGE GROUPS: 755
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>755
,p_default_id_offset=>138245292394615020
,p_default_owner=>'APPS'
);
wwv_flow_imp_page.create_page_group(
 p_id=>wwv_flow_imp.id(132348269214004593)  -- ADMIN
,p_group_name=>'ADMIN'
);
wwv_flow_imp_page.create_page_group(
 p_id=>wwv_flow_imp.id(132348093459004139)  -- MAIN
,p_group_name=>'MAIN'
);
wwv_flow_imp.component_end;
end;
/
