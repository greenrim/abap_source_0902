*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_R04_C01
*&---------------------------------------------------------------------*

CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: on_doubleclick FOR EVENT double_click
                   OF cl_gui_alv_grid IMPORTING e_row e_column es_row_no,
                   on_toolbar FOR EVENT toolbar
                   OF cl_gui_alv_grid IMPORTING e_object,
                   on_usercommand FOR EVENT user_command
                   OF cl_gui_alv_grid IMPORTING e_ucomm,
                   on_contextmenu FOR EVENT context_menu_request
                   OF cl_gui_alv_grid IMPORTING e_object,
                   on_data_changed FOR EVENT data_changed
                   OF cl_gui_alv_grid IMPORTING er_data_changed.

ENDCLASS.


CLASS lcl_handler IMPLEMENTATION.

  METHOD on_doubleclick.
    CASE e_column-fieldname.
      WHEN 'CARRID'.
        READ TABLE gt_sbook INTO gs_sbook INDEX e_row-index.

        DATA gv_carrname TYPE scarr-carrname.

        SELECT SINGLE carrname
          FROM scarr
          INTO gv_carrname
          WHERE carrid = gs_sbook-carrid.

        MESSAGE i016(pn) WITH gv_carrname.
    ENDCASE.
  ENDMETHOD.

  METHOD on_toolbar.
    DATA ls_button TYPE stb_button.
    CLEAR ls_button.
    ls_button-butn_type = '3'.
    APPEND ls_button TO e_object->mt_toolbar.

    CLEAR ls_button.
    ls_button-function = 'GOFLI'.
    ls_button-icon = icon_flight.
    ls_button-quickinfo = 'Connection Detail'.
    ls_button-butn_type = '0'.
    ls_button-text = 'Flight Info'.

    APPEND ls_button TO e_object->mt_toolbar.
    CLEAR ls_button.
  ENDMETHOD.

  METHOD on_usercommand.
    DATA : ls_row_id TYPE lvc_s_row,
           ls_col_id TYPE lvc_s_col.
    CALL METHOD go_alv->get_current_cell
      IMPORTING
*       e_row     =
*       e_value   =
*       e_col     =
        es_row_id = ls_row_id
        es_col_id = ls_col_id
*       es_row_no =
      .

    CASE e_ucomm.
      WHEN 'GOFLI'.
        READ TABLE gt_sbook INTO gs_sbook INDEX ls_row_id-index.

        IF sy-subrc EQ 0.
          SET PARAMETER ID 'CAR' FIELD gs_sbook-carrid.
          SET PARAMETER ID 'CON' FIELD gs_sbook-connid.

          CALL TRANSACTION 'SAPBC405CAL'. " AND SKIP FIRST SCREEN.
        ENDIF.

    ENDCASE.

  ENDMETHOD.

  METHOD on_contextmenu.
    DATA : ls_row_id TYPE lvc_s_row,
           ls_col_id TYPE lvc_s_col.
    CALL METHOD go_alv->get_current_cell
      IMPORTING
*       e_row     =
*       e_value   =
*       e_col     =
        es_row_id = ls_row_id
        es_col_id = ls_col_id
*       es_row_no =
      .

    CASE ls_col_id-fieldname.
      WHEN 'CARRID' OR 'CONNID'.
        CALL METHOD e_object->add_separator.

        CALL METHOD e_object->add_function
          EXPORTING
            fcode = 'GOFLI'
            text  = 'Connection Detail'.
    ENDCASE.
  ENDMETHOD.

  METHOD on_data_changed.
    DATA ls_modi TYPE lvc_s_modi.

    LOOP AT  er_data_changed->mt_mod_cells INTO ls_modi.
      CASE ls_modi-fieldname.
        WHEN 'CUSTOMID'.
          PERFORM cust_change USING ls_modi er_data_changed.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
