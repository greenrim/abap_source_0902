*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_EXAM01_O01
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
*& Module CREATE_ALV_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE create_alv_0100 OUTPUT.

  IF go_con IS INITIAL.
    CREATE OBJECT go_con
      EXPORTING
        container_name = 'MY_CONTROL'.
    IF sy-subrc = 0.
      CREATE OBJECT go_alv
        EXPORTING
          i_parent = go_con.

      IF sy-subrc = 0.
        PERFORM set_layout_and_Variant.
        PERFORM make_fieldcatalog.

        APPEND cl_gui_alv_grid=>mc_fc_check TO gt_excp.
        APPEND cl_gui_alv_grid=>mc_fc_loc_cut TO gt_excp.
        APPEND cl_gui_alv_grid=>mc_fc_loc_copy TO gt_excp.
        APPEND cl_gui_alv_grid=>mc_mb_paste TO gt_excp.
        APPEND cl_gui_alv_grid=>mc_fc_loc_undo TO gt_excp.
        APPEND cl_gui_alv_grid=>mc_fc_loc_append_row TO gt_excp.
        APPEND cl_gui_alv_grid=>mc_fc_loc_insert_row TO gt_excp.
        APPEND cl_gui_alv_grid=>mc_fc_loc_delete_row TO gt_excp.
        APPEND cl_gui_alv_grid=>mc_fc_loc_copy_row TO gt_excp.

        CALL METHOD go_alv->register_edit_event
          EXPORTING
            i_event_id = cl_gui_alv_grid=>mc_evt_enter.

        SET HANDLER lcl_handler=>on_toolbar FOR go_alv.
        SET HANDLER lcl_handler=>on_usercommand FOR go_alv.
        SET HANDLER lcl_handler=>on_doubleclick FOR go_alv.
        SET HANDLER lcl_handler=>on_data_changed FOR go_alv.
        SET HANDLER lcl_handler=>on_data_changed_finished FOR go_alv.


        CALL METHOD go_alv->set_table_for_first_display
          EXPORTING
*           i_buffer_active      =
*           i_bypassing_buffer   =
*           i_consistency_check  =
            i_structure_name     = 'ZTSPFLI_A20'
            is_variant           = gs_variant
            i_save               = 'A'
            i_default            = 'X'
            is_layout            = gs_layout
*           is_print             =
*           it_special_groups    =
            it_toolbar_excluding = gt_excp
*           it_hyperlink         =
*           it_alv_graphics      =
*           it_except_qinfo      =
*           ir_salv_adapter      =
          CHANGING
            it_outtab            = gt_spfli
            it_fieldcatalog      = gt_fcat
*           it_sort              =
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
