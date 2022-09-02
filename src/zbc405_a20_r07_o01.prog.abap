*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_R07_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.

  CASE pa_edit.
    WHEN 'X'.
      SET PF-STATUS 'S100'.
    WHEN OTHERS.
      SET PF-STATUS 'S100' EXCLUDING 'SAVE'.
  ENDCASE.
  SET TITLEBAR 'T100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CREATE_ALV_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE create_alv_0100 OUTPUT.


  CREATE OBJECT go_con
    EXPORTING
      container_name = 'MY_CON'.


  CREATE OBJECT go_alv
    EXPORTING
      i_parent = go_con.

  "set layout
  gs_layout-zebra = 'X'.
  gs_layout-excp_fname = 'LIGHT'.
  gs_layout-info_fname = 'ROWCOL'.
  gs_layout-ctab_fname = 'CELLCOL'.
  gs_layout-cwidth_opt ='X'.
  gs_layout-stylefname = 'STYLE'.


  "make fieldcatalog
  CLEAR gs_fcat.
  gs_fcat-fieldname = 'CUSTOMID'.
  gs_fcat-edit = pa_edit.
  gs_fcat-col_pos = 5.
  APPEND gs_fcat TO gt_fcat.
  CLEAR gs_fcat.

  gs_fcat-fieldname = 'NAME'.
  gs_fcat-coltext = 'Cust. Name'.
  gs_fcat-ref_table = 'ZTSCUSTOM_A20'.
  gs_fcat-ref_field = 'NAME'.
  gs_fcat-col_pos = 6.
  APPEND gs_fcat TO gt_fcat.
  CLEAR gs_fcat.

  gs_fcat-fieldname = 'TELEPHONE'.
  gs_fcat-coltext = 'Cust. PHONE'.
  gs_fcat-ref_table = 'ZTSCUSTOM_A20'.
  gs_fcat-ref_field = 'TELEPHONE'.
  gs_fcat-col_pos = 7.
  APPEND gs_fcat TO gt_fcat.
  CLEAR gs_fcat.

  gs_fcat-fieldname = 'EMAIL'.
  gs_fcat-coltext = 'Cust. EMAIL'.
  gs_fcat-ref_table = 'ZTSCUSTOM_A20'.
  gs_fcat-ref_field = 'EMAIL'.
  gs_fcat-col_pos = 8.
  APPEND gs_fcat TO gt_fcat.
  CLEAR gs_fcat.

  gs_fcat-fieldname = 'MODIFIED'.
  gs_fcat-coltext = 'MODIFIED'.
  gs_fcat-col_pos = 4.
  APPEND gs_fcat TO gt_fcat.
  CLEAR gs_fcat.

  SET HANDLER lcl_handler=>on_Data_changed FOR go_alv.
  SET HANDLER lcl_handler=>on_Data_chnaged_finished FOR go_alv.

  CALL METHOD go_alv->register_edit_event
    EXPORTING
      i_event_id = cl_gui_alv_grid=>mc_evt_modified.  "변경되는 순간 반영
*  " mc_evt_enter.    "enter치는 순간 반영

  CALL METHOD go_alv->set_table_for_first_display
    EXPORTING
*     i_buffer_active  =
*     i_bypassing_buffer            =
*     i_consistency_check           =
      i_structure_name = 'ZTSBOOK_A20'
*     is_variant       =
*     i_save           =
*     i_default        = 'X'
      is_layout        = gs_layout
*     is_print         =
*     it_special_groups             =
*     it_toolbar_excluding          =
*     it_hyperlink     =
*     it_alv_graphics  =
*     it_except_qinfo  =
*     ir_salv_adapter  =
    CHANGING
      it_outtab        = gt_sbook
      it_fieldcatalog  = gt_fcat
*     it_sort          =
*     it_filter        =
*  EXCEPTIONS
*     invalid_parameter_combination = 1
*     program_error    = 2
*     too_many_lines   = 3
*     others           = 4
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.




ENDMODULE.
