*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_R01_O01
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

  IF go_container_car IS INITIAL.
    CREATE OBJECT go_container_car
      EXPORTING
*       parent         =
        container_name = 'C_AIR'
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

    CREATE OBJECT go_alv_grid_car
      EXPORTING
*       i_shellstyle      = 0
*       i_lifetime        =
        i_parent = go_container_car
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

    CALL METHOD go_alv_grid_car->set_table_for_first_display
      EXPORTING
*       i_buffer_active  =
*       i_bypassing_buffer            =
*       i_consistency_check           =
        i_structure_name = 'SCARR'
*       is_variant       =
*       i_save           =
*       i_default        = 'X'
*       is_layout        =
*       is_print         =
*       it_special_groups             =
*       it_toolbar_excluding          =
*       it_hyperlink     =
*       it_alv_graphics  =
*       it_except_qinfo  =
*       ir_salv_adapter  =
      CHANGING
        it_outtab        = gt_scarr
*       it_fieldcatalog  = gt_scarr
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

  IF go_container_con IS INITIAL.
    CREATE OBJECT go_container_con
      EXPORTING
*       parent         =
        container_name = 'C_CON'
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

    CREATE OBJECT go_alv_grid_con
      EXPORTING
*       i_shellstyle      = 0
*       i_lifetime        =
        i_parent = go_container_con
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

    CALL METHOD go_alv_grid_con->set_table_for_first_display
      EXPORTING
*       i_buffer_active  =
*       i_bypassing_buffer            =
*       i_consistency_check           =
        i_structure_name = 'SPFLI'
*       is_variant       =
*       i_save           =
*       i_default        = 'X'
*       is_layout        =
*       is_print         =
*       it_special_groups             =
*       it_toolbar_excluding          =
*       it_hyperlink     =
*       it_alv_graphics  =
*       it_except_qinfo  =
*       ir_salv_adapter  =
      CHANGING
        it_outtab        = gt_spfli
*       it_fieldcatalog  = gt_scarr
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

  IF go_container_fld IS INITIAL.
    CREATE OBJECT go_container_fld
      EXPORTING
*       parent         =
        container_name = 'C_FLD'
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

    CREATE OBJECT go_alv_grid_fld
      EXPORTING
*       i_shellstyle      = 0
*       i_lifetime        =
        i_parent = go_container_fld
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

    CALL METHOD go_alv_grid_fld->set_table_for_first_display
      EXPORTING
*       i_buffer_active  =
*       i_bypassing_buffer            =
*       i_consistency_check           =
        i_structure_name = 'SFLIGHT'
*       is_variant       =
*       i_save           =
*       i_default        = 'X'
*       is_layout        =
*       is_print         =
*       it_special_groups             =
*       it_toolbar_excluding          =
*       it_hyperlink     =
*       it_alv_graphics  =
*       it_except_qinfo  =
*       ir_salv_adapter  =
      CHANGING
        it_outtab        = gt_sflight
*       it_fieldcatalog  = gt_scarr
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
