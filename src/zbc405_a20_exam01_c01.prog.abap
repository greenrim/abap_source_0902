*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_EXAM01_C01
*&---------------------------------------------------------------------*
CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS : on_toolbar FOR EVENT toolbar
                    OF cl_gui_alv_grid IMPORTING e_object,
                    on_usercommand FOR EVENT user_command
                    OF cl_gui_alv_grid IMPORTING e_ucomm,
                    on_doubleclick FOR EVENT double_click
                    OF cl_gui_alv_grid IMPORTING e_row e_column es_row_no,
                    on_data_changed FOR EVENT data_changed
                    OF cl_gui_alv_grid IMPORTING er_data_changed,
                    on_data_changed_finished FOR EVENT data_changed_finished
                    OF cl_gui_alv_grid IMPORTING e_modified et_good_cells.

ENDCLASS.

CLASS lcl_handler IMPLEMENTATION.
  METHOD on_toolbar.
    DATA ls_button TYPE stb_button.
    CLEAR ls_button.
    ls_button-butn_type = '3'.
    APPEND ls_button TO e_object->mt_toolbar.

    CLEAR ls_button.
    ls_button-function = 'FLT'.
    ls_button-icon = icon_flight.
    ls_button-text = 'Flight'.
    ls_button-butn_type = '0'.
    APPEND ls_button TO e_object->mt_toolbar.

    CLEAR ls_button.
    ls_button-function = 'FLINFO'.
    ls_button-text = 'Flight Info'.
    ls_button-butn_type = '0'.
    APPEND ls_button TO e_object->mt_toolbar.

    CLEAR ls_button.
    ls_button-function = 'FLDATA'.
    ls_button-text = 'Flight Data'.
    ls_button-butn_type = '0'.
    APPEND ls_button TO e_object->mt_toolbar.

    CLEAR ls_button.

  ENDMETHOD.

  METHOD on_usercommand.
    DATA : lv_value  TYPE c LENGTH 40,
           ls_col    TYPE lvc_s_col,
           ls_row_no TYPE lvc_s_roid,
           lt_row    TYPE lvc_t_row,
           ls_row    LIKE LINE OF lt_row.

    CALL METHOD go_alv->get_current_cell
      IMPORTING
        e_value   = lv_value
        es_col_id = ls_col
        es_row_no = ls_row_no.

    CALL METHOD go_alv->get_selected_rows
      IMPORTING
        et_index_rows = lt_row.

    CASE e_ucomm.
      WHEN 'FLT'.
        CASE ls_col-fieldname.
          WHEN 'CARRID'.
            DATA lv_carrname TYPE scarr-carrname.
            SELECT SINGLE carrname
              FROM scarr
              INTO lv_carrname
              WHERE carrid = lv_value.
            MESSAGE i016(pn) WITH lv_carrname.
        ENDCASE.

      WHEN 'FLINFO'.
        CLEAR: gs_spfli_sub, gt_spfli_sub.

        LOOP AT lt_row INTO ls_row.
          READ TABLE gt_spfli INTO gs_spfli INDEX ls_row-index.
          MOVE-CORRESPONDING gs_spfli TO gs_spfli_sub.
          APPEND gs_spfli_sub TO gt_spfli_sub.
        ENDLOOP.

        EXPORT mem_it_spfli FROM gt_spfli_sub TO MEMORY ID 'BC405'.

        SUBMIT bc405_call_flights AND RETURN.

      WHEN 'FLDATA'.
        READ TABLE gt_spfli INTO gs_spfli INDEX ls_row_no-row_id.

        SET PARAMETER ID: 'CAR' FIELD gs_spfli-carrid,
                          'CON' FIELD gs_spfli-connid,
                          'DAY' FIELD ''.

        CALL TRANSACTION 'SAPBC410A_INPUT_FIEL'.

    ENDCASE.
  ENDMETHOD.

  METHOD on_doubleclick.
    DATA : lv_value  TYPE c LENGTH 40,
           ls_col    TYPE lvc_s_col,
           ls_row_no TYPE lvc_s_roid.

    CALL METHOD go_alv->get_current_cell
      IMPORTING
*       e_row     =
        e_value   = lv_value
*       e_col     =
*       es_row_id =
        es_col_id = ls_col
        es_row_no = ls_row_no.

    CASE ls_col-fieldname.
      WHEN 'CARRID' OR 'CONNID'.
        READ TABLE gt_spfli INTO gs_spfli INDEX ls_row_no-row_id.
        SUBMIT bc405_event_s4 WITH so_car = gs_spfli-carrid
                              WITH so_con = gs_spfli-connid
                              AND RETURN.

    ENDCASE.
  ENDMETHOD.

  METHOD on_data_changed.
    DATA : ls_modi    TYPE lvc_s_modi,
           lv_fltime  TYPE ztspfli_a20-fltime,
           lv_depTime TYPE ztspfli_a20-depTime,
           lv_arrtime TYPE spfli-arrtime,
           lv_period  TYPE n,
           lv_light   TYPE c LENGTH 1.

    LOOP AT er_data_changed->mt_mod_cells INTO ls_modi.
      CASE ls_modi-fieldname.
        WHEN 'FLTIME' OR 'DEPTIME'.

          READ TABLE gt_spfli INTO gs_spfli INDEX ls_modi-row_id.

          CALL METHOD er_data_changed->get_cell_value
            EXPORTING
              i_row_id    = ls_modi-row_id
*             i_tabix     =
              i_fieldname = 'FLTIME'
            IMPORTING
              e_value     = lv_fltime.

          CALL METHOD er_data_changed->get_cell_value
            EXPORTING
              i_row_id    = ls_modi-row_id
*             i_tabix     =
              i_fieldname = 'DEPTIME'
            IMPORTING
              e_value     = lv_deptime.

          CALL FUNCTION 'ZBC405_CALC_ARRTIME'
            EXPORTING
              iv_fltime       = lv_fltime
              iv_deptime      = lv_deptime
              iv_utc          = gs_spfli-ftzone
              iv_utc1         = gs_spfli-ttzone
            IMPORTING
              ev_arrival_time = lv_arrtime
              ev_period       = lv_period.

          IF lv_period = 0.
            lv_LIGHT = 3.
          ELSEIF lv_period = 1.
            lv_LIGHT = 2.
          ELSEIF lv_period >= 2.
            lv_LIGHT = 1.
          ENDIF.


          CALL METHOD er_data_changed->modify_cell
            EXPORTING
              i_row_id    = ls_modi-row_id
*             i_tabix     =
              i_fieldname = 'ARRTIME'
              i_value     = lv_arrtime.

          CALL METHOD er_data_changed->modify_cell
            EXPORTING
              i_row_id    = ls_modi-row_id
*             i_tabix     =
              i_fieldname = 'PERIOD'
              i_value     = lv_period.

          CALL METHOD er_data_changed->modify_cell
            EXPORTING
              i_row_id    = ls_modi-row_id
*             i_tabix     =
              i_fieldname = 'LIGHT'
              i_value     = lv_LIGHT.

          gs_spfli-fltime = lv_fltime.
          gs_spfli-deptime = lv_deptime.
          gs_spfli-arrtime = lv_arrtime.
          gs_spfli-period = lv_period.
          gs_SPFLI-light = lv_LIGHT.

          MODIFY gt_spfli FROM gs_spfli INDEX ls_modi-row_id.

      ENDCASE.
    ENDLOOP.

  ENDMETHOD.

  METHOD on_data_changed_finished.

    DATA : ls_modi TYPE lvc_s_modi.

    CHECK e_modified = 'X'.

    LOOP AT et_good_cells INTO ls_modi.

      PERFORM modify_check USING ls_modi.

    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
