*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_ALV_4_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100' WITH sy-uname.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CREAT_ALV_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE creat_alv_0100 OUTPUT.

  IF go_con IS INITIAL.
    CREATE OBJECT go_con
      EXPORTING
        container_name              = 'MY_CONTROL'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.

    IF sy-subrc = 0.
      CREATE OBJECT go_alv
        EXPORTING
          i_parent          = go_con
        EXCEPTIONS
          error_cntl_create = 1
          error_cntl_init   = 2
          error_cntl_link   = 3
          error_dp_create   = 4
          OTHERS            = 5.

      "layout setting
      gs_layout-cwidth_opt = 'X'.


      "make field catalog
      CLEAR gs_fcat.
      gs_fcat-fieldname = 'COUNTRYFR'.
      gs_fcat-no_out = 'X'.
      APPEND gs_fcat TO gt_fcat.

      CLEAR gs_fcat.
      gs_fcat-fieldname = 'CITYFROM'.
      gs_fcat-no_out = 'X'.
      APPEND gs_fcat TO gt_fcat.

      CLEAR gs_fcat.
      gs_fcat-fieldname = 'AIRPFROM'.
      gs_fcat-no_out = 'X'.
      APPEND gs_fcat TO gt_fcat.

      CLEAR gs_fcat.
      gs_fcat-fieldname = 'COUNTRYTO'.
      gs_fcat-no_out = 'X'.
      APPEND gs_fcat TO gt_fcat.

      CLEAR gs_fcat.
      gs_fcat-fieldname = 'CITYTO'.
      gs_fcat-no_out = 'X'.
      APPEND gs_fcat TO gt_fcat.

      CLEAR gs_fcat.
      gs_fcat-fieldname = 'AIRPTO'.
      gs_fcat-no_out = 'X'.
      APPEND gs_fcat TO gt_fcat.

      CLEAR gs_fcat.
      gs_fcat-fieldname = 'FLTIME'.
      gs_fcat-no_out = 'X'.
      APPEND gs_fcat TO gt_fcat.

      CLEAR gs_fcat.
      gs_fcat-fieldname = 'DEPTIME'.
      gs_fcat-no_out = 'X'.
      APPEND gs_fcat TO gt_fcat.

      CLEAR gs_fcat.
      gs_fcat-fieldname = 'ARRTIME'.
      gs_fcat-no_out = 'X'.
      APPEND gs_fcat TO gt_fcat.

      CLEAR gs_fcat.
      gs_fcat-fieldname = 'DISTANCE'.
      gs_fcat-no_out = 'X'.
      APPEND gs_fcat TO gt_fcat.

      CLEAR gs_fcat.
      gs_fcat-fieldname = 'DISTID'.
      gs_fcat-no_out = 'X'.
      APPEND gs_fcat TO gt_fcat.

      CLEAR gs_fcat.
      gs_fcat-fieldname = 'SUM'.
      gs_fcat-coltext = 'Total'.
      gs_fcat-col_pos = 5.
      gs_fcat-ref_field = 'WAERS'.
      APPEND gs_fcat TO gt_fcat.
      CLEAR gs_fcat.



      CALL METHOD go_alv->set_table_for_first_display
        EXPORTING
*         i_buffer_active  =
*         i_bypassing_buffer            =
*         i_consistency_check           =
          i_structure_name = 'ZTSPFLI_T03'
*         is_variant       =
*         i_save           =
*         i_default        = 'X'
          is_layout        = gs_layout
*         is_print         =
*         it_special_groups             =
*         it_toolbar_excluding          =
*         it_hyperlink     =
*         it_alv_graphics  =
*         it_except_qinfo  =
*         ir_salv_adapter  =
        CHANGING
          it_outtab        = gt_spfli
          it_fieldcatalog  = gt_fcat
*         it_sort          =
*         it_filter        =
*  EXCEPTIONS
*         invalid_parameter_combination = 1
*         program_error    = 2
*         too_many_lines   = 3
*         others           = 4
        .
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.



    ENDIF.
  ELSE.


  ENDIF.

ENDMODULE.
