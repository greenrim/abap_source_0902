*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_ALV_CLASS
*&---------------------------------------------------------------------*

"class 생성
CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS :
      on_double_click FOR EVENT double_click
        OF cl_gui_alv_grid
        IMPORTING e_row e_column es_row_no,       "더블클릭
      on_hotspot FOR EVENT hotspot_click
        OF cl_gui_alv_grid
        IMPORTING e_row_id e_column_id es_row_no, "한번 클릭
      on_toolbar FOR EVENT toolbar
        OF cl_gui_alv_grid
        IMPORTING e_object e_interactive,
      on_user_command FOR EVENT user_command
        OF cl_gui_alv_grid
        IMPORTING e_ucomm,                       "클릭한 버튼의 이름 가져오기
      on_button_click FOR EVENT button_click
        OF cl_gui_alv_grid
        IMPORTING es_col_id es_row_no.

    "E_OBJECT append해서 버튼 생성 가능?
ENDCLASS.


CLASS lcl_handler IMPLEMENTATION.
  "on_double_click의 구현 logic
  METHOD on_double_click.
    "값을 저장하는 local 변수 선언 mehod안에서만 사용하는
    DATA : lv_total_occ   TYPE i,
           lv_total_occ_c TYPE c LENGTH 10. "숫자를 메세지로 뿌리면 error가 나서 문자로 변경

    CASE e_column-fieldname.
      WHEN 'CHANGES_POSSIBLE'.
        READ TABLE gt_flt INTO gs_flt INDEX es_row_no-row_id.
        IF sy-subrc EQ 0.
          lv_total_occ = gs_flt-seatsocc +
                         gs_flt-seatsocc_b +
                         gs_flt-seatsocc_f.
          lv_total_occ_c = lv_total_occ.
          "숫자는 오른쪽 정렬, 문자는 오른쪽 정렬? condense뭐지
          CONDENSE lv_total_occ_c.
          MESSAGE i016(pn) WITH 'Total number of bookings:' lv_total_occ_c.
        ELSE.
          MESSAGE i075(bc405_408). "Internal Error
          EXIT.
        ENDIF.

    ENDCASE.

  ENDMETHOD.

  "on_hotspot의 구현 logic
  METHOD on_hotspot.
    DATA : gv_carrname TYPE scarr-carrname.
    CASE e_column_id-fieldname.
      WHEN 'CARRID'.
        READ TABLE gt_flt INDEX es_row_no-row_id INTO gs_flt.

        IF sy-subrc EQ 0.
          SELECT SINGLE carrname
            FROM scarr
            INTO gv_carrname
            WHERE carrid = gs_flt-carrid.
          IF sy-subrc IS INITIAL.
            MESSAGE i016(pn) WITH gv_carrname.
          ELSE.
            MESSAGE i000(zt03_msg) WITH 'Data is not found!'.
          ENDIF.
        ELSE.
          MESSAGE i075(bc405_408).
          EXIT.
        ENDIF.

    ENDCASE.
  ENDMETHOD.


  METHOD on_toolbar.
    DATA : ls_button TYPE stb_button.

    "조회 정보 전체의 percentage 버튼
    ls_button-function = 'PERCENTAGE'.
*    ls_button-icon =
    ls_button-quickinfo = 'Occupied Percentage'.
    ls_button-butn_type = '0'.               "Normal Button
    ls_button-text = 'Percentage'.           "icon을 넣었을 때 text를 안 넣으면 icon만 보임
    INSERT ls_button INTO TABLE e_object->mt_toolbar.
    CLEAR ls_button.

    "버튼 간의 구분 선 추가
    ls_button-butn_type = '3'.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.
    CLEAR ls_button.

    "선택한 column 관련 percentage 버튼
    ls_button-function = 'PERCENTAGE MARKED'.
*    ls_button-icon =
    ls_button-quickinfo = 'Occupied Marked Percentage'.
    ls_button-butn_type = '0'.               "Normal Button
    ls_button-text = 'Marked Percentage'.    "icon을 넣었을 때 text를 안 넣으면 icon만 보임
    INSERT ls_button INTO TABLE e_object->mt_toolbar.
    CLEAR ls_button.

    "carrid 버튼
    ls_button-function = 'AIR NAME'.
    ls_button-quickinfo = 'Carrname'.
    ls_button-butn_type = '0'.
    ls_button-icon = icon_flight.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.
    CLEAR ls_button.

  ENDMETHOD.

  METHOD on_user_command.

    DATA : lv_occp     TYPE i,
           lv_capa     TYPE i,
           lv_perct    TYPE p LENGTH 8 DECIMALS 1,
           lv_text(20).
    DATA : lt_rows TYPE lvc_t_roid,
           ls_rows LIKE LINE OF lt_rows.
    DATA : lv_value    TYPE c LENGTH 10,
           ls_COL_ID   TYPE lvc_s_col,
           lv_carrname TYPE scarr-carrname.

    CASE e_ucomm.
      WHEN 'PERCENTAGE'.
        LOOP AT gt_flt INTO gs_flt.
          lv_occp = lv_occp + gs_flt-seatsocc. "누적으로 occp 값 계산
          lv_capa = lv_capa + gs_flt-seatsmax.

        ENDLOOP.

        lv_perct = lv_occp / lv_capa * 100.
        lv_text = lv_perct.
        CONDENSE lv_text.

        MESSAGE i016(pn) WITH 'Percentage of occupied seats (%):' lv_text.

      WHEN 'PERCENTAGE MARKED'.
        CALL METHOD go_alv_grid->get_selected_rows
          IMPORTING
*           et_index_rows =
            et_row_no = lt_rows.

        IF lines( lt_rows ) > 0. "lt_row의 line 개수가 0보다 큰 경우
          LOOP AT lt_rows INTO ls_rows.

            READ TABLE gt_flt INTO gs_flt INDEX ls_rows-row_id.
            IF sy-subrc = 0.
              lv_occp = lv_occp + gs_flt-seatsocc.
              lv_capa = lv_capa + gs_flt-seatsmax.

            ENDIF.

          ENDLOOP.

          lv_perct = lv_occp / lv_capa * 100.
          lv_text = lv_perct.
          CONDENSE lv_text.

          MESSAGE i016(pn) WITH 'Percentage of occupied seats (%):' lv_text.
        ELSE.
          MESSAGE i016(pn) WITH  'Please select at least one line'.
        ENDIF.
      WHEN 'AIR NAME'.
        CLEAR lv_carrname.
        CALL METHOD go_alv_grid->get_current_cell
          IMPORTING
*           e_row     =
            e_value   = lv_value
*           e_col     =
*           es_row_id =
            es_col_id = ls_col_id
*           es_row_no =
          .
        CASE ls_col_id-fieldname.
          WHEN 'CARRID'.
            SELECT SINGLE carrname
              FROM scarr
              INTO lv_carrname
              WHERE carrid = lv_value.
            IF sy-subrc <> 0.
              MESSAGE i016(pn) WITH '모르게따'.
            ELSE.
              MESSAGE i016(pn) WITH lv_carrname.
            ENDIF.
        ENDCASE.
    ENDCASE.
  ENDMETHOD.

  METHOD on_button_click.
    DATA lv_carrname TYPE scarr-carrname.
    CASE es_col_id-fieldname.
      WHEN 'BTN_TEXT'.
        READ TABLE gt_flt INTO gs_flt INDEX es_row_no-row_id.

        IF ( gs_flt-seatsmax NE gs_flt-seatsocc ) OR
          ( gs_flt-seatsmax_f NE gs_flt-seatsocc_f ).
          MESSAGE i016(pn) WITH '다른 등급의 좌석을 예약하세요'.
        ELSE.
          MESSAGE i016(pn) WITH '모든 좌석이 예약된 상태입니다.'.
        ENDIF.


*      WHEN 'BTN_CARR'.
*        READ TABLE gt_flt INTO gs_flt INDEX es_row_no-row_id.
*        SELECT SINGLE carrname
*          FROM scarr
*          INTO lv_carrname
*          WHERE carrid = gs_flt-carrid.
*
*        MESSAGE i016(pn) WITH lv_carrname.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
