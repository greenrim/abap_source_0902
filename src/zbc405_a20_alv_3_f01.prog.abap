*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_ALV_3_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .


  DATA lt_temp   TYPE TABLE OF ts_sbook.

  SELECT *
    FROM ztsbook_a20
    INTO CORRESPONDING FIELDS OF TABLE gt_sbook
    WHERE carrid IN so_car
      AND connid IN so_con
      AND fldate IN so_fld
      AND customid IN so_cus.

  "전화번호와 메일 주소 가져오기
  "빈 공간에서 아래 조회 조건도 돌면 퍼포먼스에 안좋은 영향을 미칠 수 있기 때문에 SUBRC 꼭 체크

  IF sy-subrc = 0.
    lt_temp = gt_sbook.
    DELETE lt_temp WHERE customid = space.

    SORT lt_temp BY customid. "customid로 정렬
    DELETE ADJACENT DUPLICATES FROM lt_temp COMPARING customid.


    SELECT *
      INTO CORRESPONDING FIELDS OF TABLE gt_custom
      FROM ztscustom_a20
      FOR ALL ENTRIES IN lt_temp
      WHERE id = lt_temp-customid.

  ENDIF.

  LOOP AT gt_sbook INTO gs_sbook.
    READ TABLE gt_custom INTO gs_custom WITH KEY id = gs_sbook-customid.
    IF sy-subrc EQ 0.
      gs_sbook-telephone = gs_custom-telephone.
      gs_sbook-email = gs_custom-email.
    ENDIF.
*    MODIFY gt_sbook FROM gs_sbook.
*  ENDLOOP.



*  LOOP AT gt_sbook INTO gs_sbook.

    "Exception Handling
    IF gs_sbook-luggwEIght > 25.
      gs_sbook-light = 1.            "RED
    ELSEIF gs_sbook-luggweight > 15.
      gs_sbook-light = 2.            "YELLOW
    ELSE.
      gs_sbook-light = 3.            "GREEN
    ENDIF.

    "ROW COLOR
    CASE gs_sbook-class.
      WHEN 'F'.
        gs_sbook-row_color = 'C710'.
    ENDCASE.

    "CELL COLOR
    CASE gs_sbook-smoker.
      WHEN 'X'.
        CLEAR: gs_color, gs_sbook-it_color.
        gs_color-fname = 'SMOKER'.
        gs_color-color-col = col_negative.
        gs_color-color-int = 1.
        gs_color-color-inv = 0.

        APPEND gs_color TO gs_sbook-it_color.
        CLEAR gs_color.
    ENDCASE.

    IF gs_sbook-custtype NE space.
      gs_sbook-drdn = 1.
    ENDIF.

    IF gs_sbook-class NE space.
      gs_sbook-drdn = 2.
    ENDIF.

    MODIFY gt_sbook FROM gs_sbook.
  ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_layout .
  "VARIANT
  gs_variant-variant = pa_var.
  gv_save = 'A'.                  "SPACE, A, X, U
  "SELECTION MODE
  gs_layout-sel_mode = 'D'.       "A,B,C,D
  "신호등
  gs_layout-excp_fname = 'LIGHT'. "Exception Handling
  gs_layout-excp_led = 'X'.       "ICON 모양 변경
  "ZEBRA
  gs_layout-zebra = 'X'.

  "lFIELD의 최대 길이 압축하기 (TITLE 길이 포함)
  gs_layout-cwidth_opt = 'X'.

  "ROW COLOR 설정
  gs_layout-info_fname = 'ROW_COLOR'.

  "CELL COLOR 설정
  gs_layout-ctab_fname = 'IT_COLOR'.

  "style 설정
  gs_layout-stylefname = 'BT'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_sort
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_sort .

  CLEAR gs_sort.
  gs_sort-fieldname = 'CARRID'. "SBOOK에 있는 FIELD명과 동일해야함
  gs_sort-up        = 'X'.      "오름차순 정렬
  gs_sort-spos      = 1.        "정렬의 순서
  APPEND gs_sort TO gt_sort.
  CLEAR gs_sort.
  gs_sort-fieldname = 'CONNID'.
  gs_sort-up        = 'X'.
  gs_sort-spos      = 2.
  APPEND gs_sort TO gt_sort.
  CLEAR gs_sort.
  gs_sort-fieldname = 'FLDATE'.
  gs_sort-down      = 'X'.
  gs_sort-spos      = 3.
  APPEND gs_sort TO gt_sort.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_fieldcatalog
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_fieldcatalog .
  CLEAR gs_fcat.
  gs_fcat-fieldname = 'LIGHT'.
  gs_fcat-coltext = 'Info'. "column명
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'SMOKER'.
  gs_fcat-checkbox = 'X'.  "CHECKBOX 사용
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'INVOICE'.
  gs_fcat-checkbox = 'X'.  "CHECKBOX 사용
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'CANCELLED'.
  gs_fcat-checkbox  = 'X'.  "CHECKBOX 사용
  gs_fcat-edit      = pa_edit.  "편집 모드
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'TELEPHONE'.
  gs_fcat-ref_table = 'ZTSCUSTOM_A20'.
  gs_fcat-ref_field = 'TELEPHONE'.
  gs_fcat-col_pos = 30.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'EMAIL'.
  gs_fcat-ref_table = 'ZTSCUSTOM_A20'.
  gs_fcat-ref_field = 'EMAIL'.
  gs_fcat-col_pos   = 31.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'CUSTOMID'.
*  gs_fcat-emphasize = 'C400'.
  gs_fcat-edit      = pa_edit.  "편집 모드
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'CLASS'.
  gs_fcat-edit = 'X'.
  gs_fcat-DRDN_field = 'DRDN'.
  gs_fcat-ref_table = 'ZTSBOOK_A20'.
  gs_fcat-ref_field = 'CLASS'.
  gs_fcat-outputlen = 6.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'CUSTTYPE'.
  gs_fcat-edit = 'X'.
  gs_fcat-DRDN_field = 'DRDN'.
  gs_fcat-outputlen = 6.
  APPEND gs_fcat TO gt_fcat.


  CLEAR gs_fcat.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form customer_change_part
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ER_DATA_CHANGED
*&      --> LS_MOD_CELLS
*&---------------------------------------------------------------------*
FORM customer_change_part  USING     p_mod_cells TYPE lvc_s_modi
                                     p_changed TYPE REF TO cl_alv_changed_data_protocol.

  DATA : lv_customid TYPE ztsbook_a20-customid,
         lv_phone    TYPE ztscustom_a20-telephone,
         lv_email    TYPE ztscustom_a20-email,
         lv_name     TYPE ztscustom_a20-name.

  READ TABLE gt_sbook INTO gs_sbook  INDEX p_mod_cells-row_id.

  CALL METHOD p_changed->get_cell_value "내가 타이핑하는 값을 알려줌
    EXPORTING
      i_row_id    = p_mod_cells-row_id  "내가 클릭한 LINE의 ID
*     i_tabix     =
      i_fieldname = 'CUSTOMID'          "p_mod_cells-fieldname 써도 됨
    IMPORTING
      e_value     = lv_customid.

*check lv_customid is not INITIAL.  "NE SPACE.

  IF lv_customid IS NOT INITIAL.
    "기존 T에 해당 ID가 존재하는지 확인
    READ TABLE gt_custom INTO gs_custom WITH KEY id = lv_customid.

    IF sy-subrc = 0.
      lv_phone = gs_custom-telephone.
      lv_email = gs_custom-email.
      lv_name = gs_custom-name.
    ELSE. "기존 T에 해당 ID가 존재하지 않는 다면 DB에 접근
      SELECT SINGLE telephone email name
        FROM ztscustom_a20
        INTO (lv_phone, lv_email, lv_name)
        WHERE id = lv_customid.
    ENDIF.
  ELSE.
    CLEAR : lv_email, lv_phone, lv_name.

  ENDIF.

  CALL METHOD p_changed->modify_cell
    EXPORTING
      i_row_id    = p_mod_cells-row_id
*     i_tabix     =
      i_fieldname = 'TELEPHONE'
      i_value     = lv_phone.

  CALL METHOD p_changed->modify_cell
    EXPORTING
      i_row_id    = p_mod_cells-row_id
*     i_tabix     =
      i_fieldname = 'EMAIL'
      i_value     = lv_email.

  CALL METHOD p_changed->modify_cell
    EXPORTING
      i_row_id    = p_mod_cells-row_id
*     i_tabix     =
      i_fieldname = 'PASSNAME'
      i_value     = lv_NAME.


  gs_sbook-email = lv_email.
  gs_sbook-telephone = lv_phone.
  gs_sbook-passname = lv_NAME.
  MODIFY gt_sbook FROM gs_sbook INDEX p_mod_cells-row_id.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form insert_parts
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ER_DATA_CHANGED
*&      --> LS_INS_CELLS
*&---------------------------------------------------------------------*
FORM insert_parts  USING     rr_data_changed TYPE REF TO
                             cl_alv_changed_data_protocol
                            Rs_ins_cells TYPE lvc_s_moce.


  "selection screen의 값을 직접 주기 위해서 사용
  gs_sbook-carrid = so_car-low.  "sign = 'I', opption = 'EQ'
  gs_sbook-connid = so_con-low.
  gs_sbook-fldate = so_fld-low.
*

  CALL METHOD rr_data_changed->modify_cell
    EXPORTING
      i_row_id    = Rs_ins_cells-row_id
      i_fieldname = 'FLDATE'
      i_value     = gs_sbook-fldate.

  CALL METHOD rr_data_changed->modify_cell
    EXPORTING
      i_row_id    = Rs_ins_cells-row_id
      i_fieldname = 'CONNID'
      i_value     = gs_sbook-connid.

  CALL METHOD rr_data_changed->modify_cell
    EXPORTING
      i_row_id    = Rs_ins_cells-row_id
      i_fieldname = 'CARRID'
      i_value     = gs_sbook-carrid.

  CALL METHOD rr_data_changed->modify_cell
    EXPORTING
      i_row_id    = Rs_ins_cells-row_id
      i_fieldname = 'ORDER_DATE'
      i_value     = sy-datum.

  CALL METHOD rr_data_changed->modify_cell
    EXPORTING
      i_row_id    = Rs_ins_cells-row_id
      i_fieldname = 'CUSTTYPE'
      i_value     = 'P'.

  CALL METHOD rr_data_changed->modify_cell
    EXPORTING
      i_row_id    = Rs_ins_cells-row_id
      i_fieldname = 'CLASS'
      i_value     = 'C'.


  PERFORM modify_style USING rr_data_changed
                             Rs_ins_cells
                             'CUSTTYPE'.
  PERFORM modify_style USING rr_data_changed
                             Rs_ins_cells
                             'CLASS'.
  PERFORM modify_style USING rr_data_changed
                             Rs_ins_cells
                             'DISCOUNT'.
  PERFORM modify_style USING rr_data_changed
                            Rs_ins_cells
                            'SMOKER'.
  PERFORM modify_style USING rr_data_changed
                           Rs_ins_cells
                           'LUGGWEIGHT'.
  PERFORM modify_style USING rr_data_changed
                           Rs_ins_cells
                           'WUNIT'.
  PERFORM modify_style USING rr_data_changed
                          Rs_ins_cells
                          'INVOICE'.
  PERFORM modify_style USING rr_data_changed
                          Rs_ins_cells
                          'FORCURAM'.
  PERFORM modify_style USING rr_data_changed
                         Rs_ins_cells
                         'FORCURKEY'.
  PERFORM modify_style USING rr_data_changed
                       Rs_ins_cells
                       'LOCCURAM'.
  PERFORM modify_style USING rr_data_changed
                        Rs_ins_cells
                        'LOCCURKEY'.
  PERFORM modify_style USING rr_data_changed
                        Rs_ins_cells
                        'ORDER_DATE'.
  PERFORM modify_style USING rr_data_changed
                        Rs_ins_cells
                        'AGENCYNUM'.




  MODIFY gt_sbook FROM gs_sbook INDEX Rs_ins_cells-row_id .




ENDFORM.
*&---------------------------------------------------------------------*
*& Form modify_style
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> RR_DATA_CHANGED
*&      --> RS_INS_CELLS
*&      --> P_
*&---------------------------------------------------------------------*
FORM modify_style  USING  rr_data_changed  TYPE REF TO
                             cl_alv_changed_data_protocol
                            Rs_ins_cells TYPE lvc_s_moce
                            VALUE(p_val).

  CALL METHOD rr_data_changed->modify_style
    EXPORTING
      i_row_id    = Rs_ins_cells-row_id
      i_fieldname = p_val
      i_style     = cl_gui_alv_grid=>mc_style_enabled.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form modify_check
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LS_MOD_CELLS_ROW_ID
*&---------------------------------------------------------------------*
FORM modify_check  USING    pls_mod_cells TYPE lvc_s_modi.
  READ TABLE gt_sbook INTO gs_sbook INDEX pls_mod_cells-row_id.
  IF sy-subrc EQ 0.

    gs_sbook-modified = 'X'.

    MODIFY gt_sbook FROM gs_sbook INDEX pls_mod_cells-row_id.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form data_save
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM data_save .

  DATA: gs_sbook_ins TYPE ztsbook_a20,
        gt_sbook_ins LIKE TABLE OF gs_sbook_ins.

  CLEAR gs_sbook_ins.
  "UPDATE
  LOOP AT gt_sbook INTO gs_sbook WHERE modified = 'X'.
    UPDATE ztsbook_a20
    SET customid = gs_sbook-customid
        cancelled = gs_sbook-cancelled
        passname = gs_sbook-passname
        WHERE carrid = gs_sbook-carrid
        AND connid = gs_sbook-connid
        AND fldate = gs_sbook-fldate
        AND bookid = gs_sbook-bookid.

  ENDLOOP.

  "INSERT
  DATA: next_number TYPE s_book_id,
        ret_code    TYPE inri-returncode.

  DATA : lv_tabix LIKE sy-tabix.

  LOOP AT gt_sbook INTO gs_sbook WHERE bookid IS INITIAL.
    lv_tabix = sy-tabix.
    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = '01'
        object                  = 'ZBOOKIDA20'
        subobject               = gs_sbook-carrid
        ignore_buffer           = 'X'
      IMPORTING
        number                  = next_number
        returncode              = ret_code
      EXCEPTIONS
        interval_not_found      = 1
        number_range_not_intern = 2
        object_not_found        = 3
        quantity_is_0           = 4
        quantity_is_not_1       = 5
        interval_overflow       = 6
        buffer_overflow         = 7
        OTHERS                  = 8.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    IF next_number IS NOT INITIAL.
      gs_sbook-bookid = next_number.

      MOVE-CORRESPONDING gs_sbook TO gs_sbook_ins.
      APPEND gs_sbook_ins TO gt_sbook_ins.

      MODIFY gt_sbook FROM gs_sbook INDEX lv_tabix TRANSPORTING bookid.

    ENDIF.
  ENDLOOP.

  IF gs_sbook_ins IS NOT INITIAL.
    INSERT ztsbook_a20 FROM TABLE gt_sbook_ins.
  ENDIF.

  "delete
  IF gs_del_sbook IS NOT INITIAL.
    DELETE ztsbook_a20 FROM TABLE gt_del_sbook.
    CLEAR gt_del_sbook.


  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_DROPDOWN
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_dropdown .
  DATA: lt_dropdown TYPE lvc_t_drop,
        ls_dropdown LIKE LINE OF lt_dropdown.

  ls_dropdown-handle = '1'.
  APPEND ls_dropdown TO lt_dropdown.

  CALL METHOD go_alv->set_drop_down_table
    EXPORTING
      it_drop_down = lt_dropdown
*     it_drop_down_alias =
    .

ENDFORM.
