*&---------------------------------------------------------------------*
*& Report ZBC405_A20_R06
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zbc405_a20_r06_top                      .    " Global Data

* INCLUDE ZBC405_A20_R06_O01                      .  " PBO-Modules
* INCLUDE ZBC405_A20_R06_I01                      .  " PAI-Modules
* INCLUDE ZBC405_A20_R06_F01                      .  " FORM-Routines


START-OF-SELECTION.

  SELECT *
    FROM spfli
    INTO CORRESPONDING FIELDS OF TABLE gt_spfli
    WHERE carrid IN so_car
    AND connid IN so_con.

  TRY.
      CALL METHOD cl_salv_table=>factory
        EXPORTING
          list_display = ''    "IF_SALV_C_BOOL_SAP=>FALSE
*         r_container  =
*         container_name =
        IMPORTING
          r_salv_table = go_alv
        CHANGING
          t_table      = gt_spfli.
    CATCH cx_salv_msg.
  ENDTRY.

*---set Tool bar
  CALL METHOD go_alv->get_functions
    RECEIVING
      value = go_func.

  CALL METHOD go_func->set_all
    EXPORTING
      value = if_salv_c_bool_sap=>true.

*---set display
*  CALL METHOD go_alv->get_display_settings
*    RECEIVING
*      value = go_display.
  go_display = go_alv->get_display_settings( ).

  "zebra
  CALL METHOD go_display->set_striped_pattern
    EXPORTING
      value = 'X'.

  "salv title
  CALL METHOD go_display->set_list_header
    EXPORTING
      value = 'SALV LIST HEADER'.

  "lines hiding
  CALL METHOD go_display->set_horizontal_lines
    EXPORTING
      value = ''.

  go_display->set_vertical_lines( '' ).

*---set Variant
  CALL METHOD go_alv->get_layout
    RECEIVING
      value = go_layout.

  gs_layout-report = sy-cprog.

  CALL METHOD go_layout->set_key
    EXPORTING
      value = gs_layout.

  CALL METHOD go_layout->set_save_restriction
    EXPORTING
      value = if_salv_c_layout=>restrict_none.

  CALL METHOD go_layout->set_default
    EXPORTING
      value = 'X'.

*---set column
  CALL METHOD go_alv->get_columns
    RECEIVING
      value = go_columns.

  "Optimize Columns
  CALL METHOD go_columns->set_optimize
    EXPORTING
      value = 'X'. "IF_SALV_C_BOOL_SAP~TRUE

**--column 변경 ver1
*  TRY.
*      CALL METHOD go_columns->get_column
*        EXPORTING
*          columnname = 'MANDT'
*        RECEIVING
*          value      = go_col.
*
*    CATCH cx_salv_not_found.
*  ENDTRY.
*
  "column hiding
*  go_column ?= go_col.
*  go_column->set_technical( ).
*   "KEY 고정
**  go_columns->set_key_fixation( ).

* column 변경 ver2
  "column hiding
  go_column ?= go_columns->get_column( 'MANDT' ).
  go_column->set_technical( ).
  CLEAR go_column.

  "column color
  gs_color-col = '3'.
  gs_color-int = '1'.
  gs_color-inv = '0'.
  go_column ?= go_columns->get_column( 'FLTYPE' ).
  go_column->set_color( gs_color ).



*CALL METHOD go_col->set_technical.
*  EXPORTING
*    value  = IF_SALV_C_BOOL_SAP=>TRUE


*SELECTION BUTTON 생성
  go_sel = go_alv->get_selections( ).
  go_sel->set_selection_mode( if_salv_c_selection_mode=>multiple ).
  go_sel->set_selection_mode( if_salv_c_selection_mode=>cell ).


  CALL METHOD go_alv->display.
  "go_alv->display( ).

*  CALL METHOD go_alv->get_functions
*    RECEIVING
*      value = go_func.
