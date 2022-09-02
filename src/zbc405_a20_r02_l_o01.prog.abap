*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_R02_L_O01
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
*& Module SET_ALV_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE set_alv_0100 OUTPUT.

  IF go_con_1 IS INITIAL.
    CREATE OBJECT go_con_1
      EXPORTING
*       parent         =
        container_name = 'C_MAIN'
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
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

    CREATE OBJECT go_grid_1
      EXPORTING
*       i_shellstyle      = 0
*       i_lifetime        =
        i_parent = go_con_1
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
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.


    SET HANDLER lcl_handler=>on_double_click FOR go_grid_1.
    SET HANDLER lcl_handler=>on_tool_bar FOR go_grid_1.
    SET HANDLER lcl_handler=>on_ucomm FOR go_grid_1.
    SET HANDLER lcl_handler=>on_context FOR go_grid_1.

    CALL METHOD go_grid_1->set_table_for_first_display
      EXPORTING
*       i_buffer_active      =
*       i_bypassing_buffer   =
*       i_consistency_check  =
        i_structure_name     = 'SFLIGHT'
        is_variant           = gs_variant
        i_save               = gv_save
        i_default            = 'X'
        is_layout            = gs_layout_1
*       is_print             =
*       it_special_groups    =
        it_toolbar_excluding = gt_excluded_functions
*       it_hyperlink         =
*       it_alv_graphics      =
*       it_except_qinfo      =
*       ir_salv_adapter      =
      CHANGING
        it_outtab            = gt_sflight
        it_fieldcatalog      = gt_fcat
*       it_sort              =
*       it_filter            =
      EXCEPTIONS
*       invalid_parameter_combination = 1
*       program_error        = 2
*       too_many_lines       = 3
        OTHERS               = 4.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.


  ELSE.
    gv_soft_refresh = 'X'.
    gs_stable-row = 'X'.
    gs_stable-col = 'X'.

    CALL METHOD go_grid_1->refresh_table_display
      EXPORTING
        is_stable      = gs_stable
        i_soft_refresh = gv_soft_refresh
*  EXCEPTIONS
*       finished       = 1
*       others         = 2
      .
  ENDIF.



  IF go_con_2 IS INITIAL.
    CREATE OBJECT go_con_2
      EXPORTING
*       parent         =
        container_name = 'C_SUB'
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
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

    CREATE OBJECT go_grid_2
      EXPORTING
*       i_shellstyle      = 0
*       i_lifetime        =
        i_parent = go_con_2
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
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

    CALL METHOD go_grid_2->set_table_for_first_display
      EXPORTING
*       i_buffer_active  =
*       i_bypassing_buffer            =
*       i_consistency_check           =
        i_structure_name = 'SFLIGHT'
*       is_variant       = gs_variant
*       i_save           = gv_save
*       i_default        = 'X'
        is_layout        = gs_layout_2
*       is_print         =
*       it_special_groups             =
*       it_toolbar_excluding          =
*       it_hyperlink     =
*       it_alv_graphics  =
*       it_except_qinfo  =
*       ir_salv_adapter  =
      CHANGING
        it_outtab        = gt_sub
       it_fieldcatalog  = gt_fcat
*       it_sort          =
*       it_filter        =
      EXCEPTIONS
*       invalid_parameter_combination = 1
*       program_error    = 2
*       too_many_lines   = 3
        OTHERS           = 4.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.
  ENDIF.
ENDMODULE.
