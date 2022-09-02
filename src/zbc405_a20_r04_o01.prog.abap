*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_R04_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100'.
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
        container_name = 'MY_CON'.
    IF sy-subrc = 0.
      CREATE OBJECT go_alv
        EXPORTING
          i_parent = go_con.
      IF sy-subrc = 0.

        PERFORM set_layout.
        PERFORM set_sort.
        PERFORM make_catalog.

        CALL METHOD go_alv->register_edit_event
          EXPORTING
            i_event_id = cl_gui_alv_grid=>mc_evt_enter.

        SET HANDLER lcl_handler=>on_doubleclick FOR go_alv.
        SET HANDLER lcl_handler=>on_toolbar FOR go_alv.
        SET HANDLER lcl_handler=>on_usercommand FOR go_alv.
        SET HANDLER lcl_handler=>on_contextmenu FOR go_alv.
        SET HANDLER lcl_handler=>on_data_changed FOR go_alv.


        CALL METHOD go_alv->set_table_for_first_display
          EXPORTING
*           i_buffer_active  =
*           i_bypassing_buffer            =
*           i_consistency_check           =
            i_structure_name = 'ZTSBOOK_A20'
            is_variant       = gs_variant
            i_save           = 'A'
            i_default        = 'X'
            is_layout        = gs_layout
*           is_print         =
*           it_special_groups             =
*           it_toolbar_excluding          =
*           it_hyperlink     =
*           it_alv_graphics  =
*           it_except_qinfo  =
*           ir_salv_adapter  =
          CHANGING
            it_outtab        = gt_sbook
            it_fieldcatalog  = gt_fcat
            it_sort          = gt_sort
*           it_filter        =
          .
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
