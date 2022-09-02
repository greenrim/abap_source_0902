*&---------------------------------------------------------------------*
*& Report ZBC405_A20_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zbc405_a20_alv_top                      .    " Global Data

* INCLUDE ZBC405_A20_ALV_O01                      .  " PBO-Modules
* INCLUDE ZBC405_A20_ALV_I01                      .  " PAI-Modules
* INCLUDE ZBC405_A20_ALV_F01                      .  " FORM-Routines
INCLUDE zbc405_a20_alv_class                      .  "Class

AT SELECTION-SCREEN.


AT SELECTION-SCREEN ON VALUE-REQUEST FOR pa_lv.

  gs_variant-report = sy-cprog. "F4기능을 사용할 때만 해당 구문을 탐

  CALL FUNCTION 'LVC_VARIANT_SAVE_LOAD'
    EXPORTING
*     I_TITLE         =
*     I_SCREEN_START_COLUMN       = 0
*     I_SCREEN_START_LINE         = 0
*     I_SCREEN_END_COLUMN         = 0
*     I_SCREEN_END_LINE           = 0
      i_save_load     = 'F'     "S,F,L
*     I_TOOL          = 'LT'
*     I_TABNAME       = '1'
*     I_USER_SPECIFIC = ' '
*     I_DEFAULT       = 'X'
*     I_NO_REPTEXT_OPTIMIZE       = 'X'
*     I_DIALOG        = 'X'
*     IR_TO_CL_ALV_BDS            =
*     IR_TO_CL_ALV_VARIANT        =
*     I_BYPASSING_BUFFER          =
*     I_BUFFER_ACTIVE =
*     I_FCAT_COMPLETE =
*   IMPORTING
*     ES_SELFIELD     =
*     E_BDS_SAVE      =
*     E_GRAPHICS_SAVE =
*     E_EXIT          =
*   TABLES
*     IT_DATA         =
    CHANGING
      cs_variant      = gs_variant
*     CS_LAYOUT       =
*     CT_FIELDCAT     =
*     CT_DEFAULT_FIELDCAT         =
*     CT_SORT         =
*     CT_FILTER       =
*     CT_GROUPLEVELS_FILTER       =
*     C_SUMLEVEL      =
    EXCEPTIONS
      not_found       = 1
      wrong_input     = 2
      fc_not_complete = 3
      OTHERS          = 4.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ELSE.
    pa_lv = gs_variant-variant.
  ENDIF.

START-OF-SELECTION.

  PERFORM Get_Data.


  CALL SCREEN 100.

*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100' EXCLUDING 'EXIT'.
  SET TITLEBAR 'T100' WITH sy-datum sy-uname.
ENDMODULE.


*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK'.
      SET SCREEN 0.
      LEAVE SCREEN.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'CANC'.
      LEAVE TO SCREEN 0.


  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CREATE_AND_TRANSFER OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE create_and_transfer OUTPUT.


  "CONTAINER 생성
  IF go_container IS INITIAL.
    CREATE OBJECT go_container
      EXPORTING
*       parent         =
        container_name = 'MY_CONTROL_AREA'
*       style          =
*       lifetime       = lifetime_default
*       repid          =
*       dynnr          =
*       no_autodef_progid_dynnr     =
      EXCEPTIONS
*       cntl_error     = 1
*       cntl_system_error           = 2
*       create_error   = 3
*       lifetime_error = 4
*       lifetime_dynpro_dynpro_link = 5
        OTHERS         = 6.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.


    "GRID 생성

    CREATE OBJECT go_alv_grid
      EXPORTING
*       i_shellstyle      = 0
*       i_lifetime        =
        i_parent = go_container
*       i_appl_events     = SPACE
*       i_parentdbg       =
*       i_applogparent    =
*       i_graphicsparent  =
*       i_name   =
*       i_fcat_complete   = SPACE
*       o_previous_sral_handler =
      EXCEPTIONS
*       error_cntl_create = 1
*       error_cntl_init   = 2
*       error_cntl_link   = 3
*       error_dp_create   = 4
        OTHERS   = 5.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.



    PERFORM make_layout.

    PERFORM make_variant.

    PERFORM make_sort.

    PERFORM make_fieldcatalog.


    "class의 attribute를 직접 참조할때 => 사용
    APPEND cl_gui_alv_grid=>mc_fc_filter TO gt_exct.
    APPEND cl_gui_alv_grid=>mc_fc_info TO gt_exct.

*    APPEND cl_gui_alv_grid=>mc_fc_excl_all TO gt_exct.


    SET HANDLER lcl_handler=>on_double_click FOR go_alv_grid.
    SET HANDLER lcl_handler=>on_hotspot FOR go_alv_grid.
    SET HANDLER lcl_handler=>on_toolbar FOR go_alv_grid.
    SET HANDLER lcl_handler=>on_user_command FOR go_alv_grid.
    SET HANDLER lcl_handler=>on_button_click FOR go_alv_grid.

    "METHOD 호출
    CALL METHOD go_alv_grid->set_table_for_first_display
      EXPORTING
*       i_buffer_active               =
*       i_bypassing_buffer            =
*       i_consistency_check           =
        i_structure_name              = 'SFLIGHT'
        is_variant                    = gs_variant
        i_save                        = gv_save    "X, A,
        i_default                     = 'X'
        is_layout                     = gs_layout
*       is_print                      =
*       it_special_groups             =
        it_toolbar_excluding          = gt_exct
*       it_hyperlink                  =
*       it_alv_graphics               =
*       it_except_qinfo               =
*       ir_salv_adapter               =
      CHANGING
        it_outtab                     = gt_flt
        it_fieldcatalog               = gt_fcat
        it_sort                       = gt_sort
*       it_filter                     =
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

  ELSE.
    gv_soft_refresh = 'X'.
    gs_stable-row = 'X'.
    gs_stable-col = 'X'.

    CALL METHOD go_alv_grid->refresh_table_display
      EXPORTING
        is_stable      = gs_stable
        i_soft_refresh = gv_soft_refresh
*  EXCEPTIONS
*       finished       = 1
*       others         = 2
      .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Form Get_Data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM Get_Data .
  SELECT *
    FROM sflight INNER JOIN saplane
    ON sflight~planetype = saplane~planetype
    INTO CORRESPONDING FIELDS OF TABLE gt_flt
    WHERE carrid IN so_car
    AND connid IN so_con
  AND fldate IN so_dat.

  LOOP AT gt_flt INTO gs_flt.
    IF gs_flt-seatsocc < 5.
      gs_flt-light = 1. "red
    ELSEIF gs_flt-seatsocc < 100.
      gs_flt-light = 2. "Yellow
    ELSE.
      gs_flt-light = 3. "Green
    ENDIF.

    IF gs_flt-fldate+4(2) = sy-datum+4(2).
      gs_flt-row_color = 'C511'.
    ENDIF.

    IF gs_flt-planetype = '747-400'.
      gs_color-fname = 'PLANETYPE'.
      gs_color-color-col = col_total.
      gs_color-color-int = '1'.
      gs_color-color-inv = '0'.
      APPEND gs_color TO gs_flt-it_color.
    ENDIF.

    IF gs_flt-seatsOCC_b = 0.
      gs_color-fname = 'SEATSOCC_B'.
      gs_color-color-col = col_negative.
      gs_color-color-int = '1'.
      gs_color-color-inv = '0'.
      APPEND gs_color TO gs_flt-it_color.
    ENDIF.

    IF gs_flt-fldate < p_date.
      gs_flt-changes_possible = icon_space.

    ELSE.
      gs_flt-changes_possible = icon_okay.

    ENDIF.


*    IF gs_flt-carrid IS NOT INITIAL.
*      gs_flt-btn_carr = 'Name'.
*
*      gs_styl-fieldname = 'BTN_CARR'.
*      gs_styl-style = cl_gui_alv_grid=>mc_style_button.
*      APPEND gs_styl TO gs_flt-it_styl.
*    ENDIF.

    CLEAR gs_styl.

    IF gs_flt-seatsmax_b = gs_flt-seatsocc_b.
      gs_flt-btn_text = 'FullSeats!'.

      gs_styl-fieldname = 'BTN_TEXT'.
      gs_styl-style = cl_gui_alv_grid=>mc_style_button.
      APPEND gs_styl TO gs_flt-it_styl.
    ENDIF.

    MODIFY gt_flt FROM gs_flt.

  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_variant
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_variant .

  gs_variant-variant = pa_lv.
  gs_variant-report = sy-cprog.
  gv_save = 'A'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_layout .

  "layout setting
  gs_layout-zebra = 'X'. "행 번갈아가면서 다른 색상
  gs_layout-cwidth_opt = 'X'. "화면에 보이는 최대 길이로 맞춰서 column이 압축됨
  gs_layout-sel_mode = 'D'.

  gs_layout-excp_fname = 'LIGHT'.
  gs_layout-excp_led = 'X'. "1개 짜리 신호등이 나옴

  gs_layout-info_fname = 'ROW_COLOR'. "LINE 색상 담당 필드 설정

  gs_layout-ctab_fname = 'IT_COLOR'.

  gs_layout-stylefname = 'IT_STYL'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_sort
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_sort .

  "wa가 중복되어 append될 때에는 항상 clear하자
  CLEAR gs_sort.
  gs_sort-fieldname = 'CARRID'.
  gs_sort-up = 'X'.
  gs_sort-spos = 1.
  APPEND gs_sort TO gt_sort.

  CLEAR gs_sort.
  gs_sort-fieldname = 'CONNID'.
  gs_sort-up = 'X'.
  gs_sort-spos = 2.
  APPEND gs_sort TO gt_sort.

  CLEAR gs_sort.
  gs_sort-fieldname = 'FLDATE'.
  gs_sort-down = 'X'.
  gs_sort-spos = 3.
  APPEND gs_sort TO gt_sort.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_fieldcatalog
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_fieldcatalog .
  CLEAR gs_fcat.
  gs_fcat-fieldname = 'CARRID'.
*  gs_fcat-hotspot = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'LIGHT'.
  gs_fcat-coltext = 'Info'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'PRICE'.
*  gs_fcat-no_out = 'X'. "화면에 안보이게 함
  gs_fcat-emphasize = 'C610'.
  gs_fcat-col_opt = 'X'.
*  gs_fcat-edit = 'X'.           "입력 가능
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'CHANGES_POSSIBLE'.
  gs_fcat-coltext = 'Chang.Poss'.
*  gs_fcat-icon = 'X'.
  gs_fcat-col_pos = 5. "몇번째 column에 위치할지
  gs_fcat-col_opt = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'BTN_TEXT'.
  gs_fcat-coltext = 'Status'.
  gs_fcat-col_pos = 10.         "몇번째 column에 위치할지
  APPEND gs_fcat TO gt_fcat.

*  CLEAR gs_fcat.
*  gs_fcat-fieldname = 'BTN_CARR'.
*  gs_fcat-coltext = 'AIRLINE NAME'.
*  gs_fcat-col_pos = 3.         "몇번째 column에 위치할지
*  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'TANKCAP'.
  gs_fcat-coltext = 'TANKCAP'.
  gs_fcat-col_pos = 5.         "몇번째 column에 위치할지
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'CAP_UNIT'.
  gs_fcat-coltext = 'CAP_UNIT'.
  gs_fcat-col_pos = 6.         "몇번째 column에 위치할지
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'WEIGHT'.
  gs_fcat-coltext = 'WEIGHT'.
  gs_fcat-col_pos = 7.         "몇번째 column에 위치할지
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'WEI_UNIT'.
  gs_fcat-coltext = 'WEI_UNIT'.
  gs_fcat-col_pos = 8.         "몇번째 column에 위치할지
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
ENDFORM.
