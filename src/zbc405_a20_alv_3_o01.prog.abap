*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_ALV_3_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  IF pa_edit = 'X'.
    SET PF-STATUS 'S100'.
  ELSE.
    SET PF-STATUS 'S100' EXCLUDING 'SAVE'.
  ENDIF.
  SET TITLEBAR 'T100' WITH sy-datum sy-uname.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CREAT_ALV_OBJECT OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE creat_alv_object OUTPUT.
  IF go_container IS INITIAL.
    "Container 생성
    CREATE OBJECT go_container
      EXPORTING
        container_name = 'MY_CONTROL_AREA'.

    IF sy-subrc = 0.
      "ALV CONTRAOL 생성
      CREATE OBJECT go_alv
        EXPORTING
          i_parent = go_container.

      IF sy-subrc = 0.
        "layout 설정
        PERFORM set_layout.
        "SORT 설정
        PERFORM set_sort.

        "toolbar 버튼 숨기기
        APPEND cl_gui_alv_grid=>mc_fc_filter TO gt_exct.
        APPEND cl_gui_alv_grid=>mc_fc_filter TO gt_exct.
        "edit 관련 버튼
        APPEND cl_gui_alv_grid=>mc_fc_loc_append_row TO gt_exct.
        APPEND cl_gui_alv_grid=>mc_fc_loc_copy_row TO gt_exct.

        "field catalog 설정
        PERFORM make_fieldcatalog.

        "값이 변경되는 시점 setting 이게 있어야 data changed를
        CALL METHOD go_alv->register_edit_event
          EXPORTING
            i_event_id = cl_gui_alv_grid=>mc_evt_modified.  "변경되는 순간 반영
        " mc_evt_enter.    "enter치는 순간 반영

        PERFORM SET_DROPDOWN.

        "trigger
        SET HANDLER lcl_handler=>on_doubleclick FOR go_alv.
        SET HANDLER lcl_handler=>on_toolbar FOR go_alv.
        SET HANDLER lcl_handler=>on_USERCOMMAND FOR go_alv.
        SET HANDLER lcl_handler=>on_data_changed FOR go_alv.
        SET HANDLER lcl_handler=>on_data_changed_finish FOR go_alv.

        "TABLE 생성
        CALL METHOD go_alv->set_table_for_first_display
          EXPORTING
*           i_buffer_active      =
*           i_bypassing_buffer   =
*           i_consistency_check  =
            i_structure_name     = 'ZTSBOOK_A20'
            is_variant           = gs_variant
            i_save               = gv_save
*            i_default            = ''
            is_layout            = gs_layout
*           is_print             =
*           it_special_groups    =
            it_toolbar_excluding = gt_exct
*           it_hyperlink         =
*           it_alv_graphics      =
*           it_except_qinfo      =
*           ir_salv_adapter      =
          CHANGING
            it_outtab            = gt_sbook
            it_fieldcatalog      = gt_fcat
            it_sort              = gt_sort
*           it_filter            =
*  EXCEPTIONS
*           invalid_parameter_combination = 1
*           program_error        = 2
*           too_many_lines       = 3
*           others               = 4
          .
        IF sy-subrc <> 0.
* Implement suitable error handling here
        ENDIF.
      ENDIF.
    ENDIF.

  ELSE.
    "REFRESH ALV METHOD
    gv_soft_refresh = 'X'.
    gs_stable-row = 'X'.
    gs_stable-col = 'X'.
    CALL METHOD go_alv->refresh_table_display
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
