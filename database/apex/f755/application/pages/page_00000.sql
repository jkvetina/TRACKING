prompt --application/pages/page_00000
begin
--   Manifest
--     PAGE: 00000
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>755
,p_default_id_offset=>138245292394615020
,p_default_owner=>'APPS'
);
wwv_flow_imp_page.create_page(
 p_id=>0
,p_name=>'Global Page'
,p_step_title=>'Global Page'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'D'
,p_page_component_map=>'14'
,p_last_updated_by=>'DEV'
,p_last_upd_yyyymmddhh24miss=>'20220101000000'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(101451276724354798)
,p_plug_name=>'ITEMS'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(124230858007403243)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BEFORE_FOOTER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(138335978870168570)
,p_plug_name=>'JS'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(124230858007403243)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BEFORE_FOOTER'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<script>',
'',
'//',
'// WAIT FOR ELEMENT TO EXIST',
'//',
'var wait_for_element = function(search, start, fn, disconnect) {',
'    var ob  = new MutationObserver(function(mutations) {',
'        if ($(search).length) {',
'            fn(search, start);',
'            if (disconnect) {',
'                observer.disconnect();  // keep observing',
'            }',
'        }',
'    });',
'    //',
'    ob.observe(document.getElementById(start), {',
'        childList: true,',
'        subtree: true',
'    });',
'};',
'',
'//',
'// HIDE SUCCESS MESSAGE',
'//',
'var hide_success_message = function(search, start) {',
'    var $start = $(''#'' + start);',
'    //',
'    setTimeout(function() {',
'        apex.message.hidePageSuccess();  // hide message',
'        var content = $start.text().trim();',
'        if (content.length) {',
'            console.log(''MESSAGE CLOSED:'', content);',
'        }',
'        $start.html('''').removeClass(''u-visible'');  // clean APEX mess',
'    }, 2000);',
'};',
'',
'</script>',
''))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(152736229183326842)
,p_plug_name=>'CSS'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(124230858007403243)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BEFORE_FOOTER'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<style>',
'',
'ul.DASH_LIST {',
'  list-style-type: none;',
'  margin: 0.5rem 0 0.5rem 3rem;',
'}',
'ul.DASH_LIST li:before {',
'  content: ''\2014'';',
'  position: absolute;',
'  margin: 0 3rem 0 -1.5rem;',
'}',
'',
'</style>',
''))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(101451383421354799)
,p_name=>'P0_ROLE_2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(101451276724354798)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(101451536405354800)
,p_name=>'P0_ROLE_7'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(101451276724354798)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(101451629957354801)
,p_name=>'P0_ROLE_8'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(101451276724354798)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(101451698407354802)
,p_name=>'P0_ROLE_1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(101451276724354798)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(101451854635354803)
,p_name=>'P0_ROLE_4'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(101451276724354798)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(101451934584354804)
,p_name=>'P0_ROLE_5'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(101451276724354798)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(101452002612354805)
,p_name=>'P0_ROLE_6'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(101451276724354798)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(101452075761354806)
,p_name=>'P0_ROLE_3'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(101451276724354798)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(84147753665111573)
,p_name=>'AUTOHIDE_SUCCESS'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(84147786881111574)
,p_event_id=>wwv_flow_imp.id(84147753665111573)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.theme42.util.configAPEXMsgs({',
'    autoDismiss : true,',
'    duration    : 2000',
'});'))
);
wwv_flow_imp.component_end;
end;
/
