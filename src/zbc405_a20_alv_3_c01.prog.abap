*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_ALV_3_C01
*&---------------------------------------------------------------------*

"정의부
CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.

    CLASS-METHODS : on_doubleclick FOR EVENT double_click
                     OF cl_gui_alv_grid IMPORTING e_row e_column es_row_no,
                     on_toolbar FOR EVENT toolbar
                     OF cl_gui_alv_grid IMPORTING e_object,
                     on_usercommand FOR EVENT user_command
                     OF cl_gui_alv_grid IMPORTING e_ucomm,
                     on_data_changed FOR EVENT data_changed
                     OF cl_gui_alv_grid IMPORTING er_data_changed,
                     on_data_changed_finish FOR EVENT
                     data_changed_finished OF cl_gui_alv_grid
                     IMPORTING e_modified et_good_cells.
ENDCLASS.

"구현부
CLASS lcl_handler IMPLEMENTATION.
  METHOD on_doubleclick.
    DATA lv_carrname TYPE scarr-carrname.
    CASE e_column-fieldname.
      WHEN 'CARRID'.
        READ TABLE gt_sbook INTO gs_sbook INDEX e_row-index.
        IF sy-subrc = 0.
          SELECT SINGLE carrname
            FROM scarr
            INTO lv_carrname
            WHERE carrid = gs_sbook-carrid.
          IF sy-subrc = 0.
            MESSAGE i016(pn) WITH lv_carrname.
          ENDIF.


        ENDIF.
    ENDCASE.
  ENDMETHOD.

  "toolbar 버튼 생성
  METHOD on_toolbar.
    DATA : ls_button TYPE stb_button.
    CLEAR ls_button.
    "버튼 사이의 구분 선
    ls_button-butn_type = 3.              "Separator
    INSERT ls_button INTO TABLE e_object->mt_toolbar.

    CLEAR ls_button.
    "버튼 생성
    ls_button-butn_type = 0.              "Normal button
    ls_button-function = 'GOTOFL'.        "FLIGHT CONNECTION.
    ls_button-icon = icon_flight.         "ICON 생성
    ls_button-quickinfo = 'Go to Flight Connection'.
    ls_button-text = 'Flight'.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.

  ENDMETHOD.

  METHOD on_usercommand.
    DATA: ls_col_id TYPE lvc_s_col,
          ls_row_no TYPE lvC_s_roid.

    CALL METHOD go_alv->get_current_cell
      IMPORTING
*       e_row     =
*       e_value   =
*       e_col     =
*       es_row_id =
        es_col_id = ls_col_id   "현재 클릭하고 있는 colum의 정보
        es_row_no = ls_row_no.   "현재 클릭하고 있는 row의 위치

    CASE e_ucomm.
      WHEN 'GOTOFL'.
        READ TABLE gt_sbook INTO gs_sbook INDEX ls_row_no-row_id.

        IF sy-subrc EQ 0.
          SET PARAMETER ID 'CAR' FIELD gs_sbook-carrid.
          SET PARAMETER ID 'CON' FIELD gs_sbook-connid.

          CALL TRANSACTION 'SAPBC405CAL'.

        ENDIF.
    ENDCASE.
  ENDMETHOD.

  METHOD on_data_changed.
    FIELD-SYMBOLS : <fs> LIKE gt_sbook.
    DATA : ls_mod_cells TYPE lvc_s_modi,
           ls_ins_cells TYPE lvc_s_moce,
           ls_del_cells TYPE lvc_s_moce.

    LOOP AT er_data_changed->mt_mod_cells INTO ls_mod_cells.  "mt_good_cells도 사용 가능
      CASE ls_mod_cells-fieldname.
        WHEN 'CUSTOMID'.                                      "내가 변경한 셀의 FIELD가 CUSTOMID일 경우
          PERFORM customer_change_part USING ls_mod_cells
                                       er_data_changed .
        WHEN 'CANCELLED'.


      ENDCASE.
    ENDLOOP.


    "inserted parts
    IF  er_data_changed->mt_inserted_rows IS NOT INITIAL.

      ASSIGN  er_data_changed->mp_mod_rows->* TO <fs>.
      IF sy-subrc EQ 0.
        APPEND LINES OF <fs> TO gt_sbook.
        LOOP AT er_data_changed->mt_inserted_rows INTO ls_ins_cells.

          READ TABLE gt_sbook INTO gs_sbook INDEX ls_ins_cells-row_id.
          IF sy-subrc EQ 0.
*
            PERFORM insert_parts USING er_data_changed
                                          ls_ins_cells.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.

    "delete parts
    IF er_data_changed->mt_deleted_rows IS NOT INITIAL.
      LOOP AT er_data_changed->mt_deleted_rows INTO ls_del_cells.
        READ TABLE gt_sbook INTO gs_sbook INDEX ls_del_cells-row_id.
        IF sy-subrc = 0.
          MOVE-CORRESPONDING gs_sbook TO gs_del_sbook.
          APPEND gs_del_sbook TO gt_del_sbook.

        ENDIF.
      ENDLOOP.
    ENDIF.


  ENDMETHOD.

  METHOD on_data_changed_finish.

    DATA : ls_mod_cells TYPE lvc_s_modi.

    CHECK e_modified = 'X'.
    LOOP AT et_good_cells INTO ls_mod_cells.
      PERFORM modify_check USING ls_mod_cells.


    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
