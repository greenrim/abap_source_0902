*&---------------------------------------------------------------------*
*& Include          ZRSAMEN02_A20_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_Data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_Data .

  SELECT SINGLE version
    FROM ztversa20
    INTO CORRESPONDING FIELDS OF ztversa20
    WHERE vendor = pa_ven.

  SELECT vendor version pcode order_unit
    FROM ztvermata20
    INTO CORRESPONDING FIELDS OF TABLE gt_data
    WHERE vendor = pa_ven
    AND version = ztversa20-version.

  IF sy-subrc <> 0.
    MESSAGE i001(zmcsa20).
    LEAVE LIST-PROCESSING.
  ENDIF.

  SELECT matnr maktx
    FROM makt
    INTO CORRESPONDING FIELDS OF TABLE gt_makt
    WHERE spras = sy-langu.

  LOOP AT gt_data INTO gs_data.
    gv_tabix = sy-tabix.

    READ TABLE gt_makt INTO gs_makt WITH KEY matnr = gs_data-pcode.
    IF sy-subrc = 0.
      gs_data-maktx = gs_makt-maktx.
      MODIFY gt_data FROM gs_data INDEX gv_tabix TRANSPORTING maktx.
    ENDIF.

  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form create_listbox
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_screen_element .

  "output field
  SELECT SINGLE kunnr name1
    FROM kna1
    INTO CORRESPONDING FIELDS OF gs_KNA1
    WHERE kunnr = pa_ven.

*  READ TABLE gt_kna1 INTO gs_kna1 WITH KEY kunnr = pa_ven.
  kna1-name1 = gs_kna1-name1.
  ztversa20-vendor = pa_ven.

  "listbox
  CLEAR gt_values.

  SELECT version AS key vtext AS text
  FROM ztversa20_t
  INTO CORRESPONDING FIELDS OF TABLE gt_values.

  IF gt_values IS NOT INITIAL.
    SORT gt_values BY key.
    DELETE ADJACENT DUPLICATES FROM gt_values COMPARING key.
    DELETE gt_values WHERE key IS INITIAL.
  ENDIF.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = gv_id
      values = gt_values.

*  ztversa20-version = 1.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form refresh_display
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM refresh_display .
  DATA ls_stable TYPE lvc_s_stbl.

  ls_stable-row = 'X'.
  ls_stable-col = 'X'.

  CALL METHOD go_alv->refresh_table_display
    EXPORTING
      is_stable      = ls_stable
      i_soft_refresh = 'X'
*  EXCEPTIONS
*     finished       = 1
*     others         = 2
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form create_alv
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM create_alv .
  CREATE OBJECT go_con
    EXPORTING
      container_name = 'MY_CON'.

*  CREATE OBJECT go_con
*    EXPORTING
*      repid     = sy-repid
*      dynnr     = sy-dynnr
*      side      = go_con->dock_at_left
*      extension = 3000.

  IF sy-subrc = 0.

    CREATE OBJECT go_alv
      EXPORTING
        i_parent = go_con.

    IF sy-subrc = 0.

      PERFORM set_handler.

      CALL METHOD go_alv->set_table_for_first_display
        EXPORTING
          is_variant      = gs_variant
          i_save          = 'A'
          i_default       = 'X'
          is_layout       = gs_layout
*         is_print        =
*         it_special_groups             =
*         it_toolbar_excluding          =
*         it_hyperlink    =
*         it_alv_graphics =
*         it_except_qinfo =
*         ir_salv_adapter =
        CHANGING
          it_outtab       = gt_data
          it_fieldcatalog = gt_fcat
*         it_sort         =
*         it_filter       =
        .

    ENDIF.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form create_fcat
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&---------------------------------------------------------------------*
FORM create_fcat  USING pa_key pa_coltext pa_fname pa_ref_t pa_ref_f pa_edit pa_curr pa_qnt.

  CLEAR gs_fcat.
  gs_fcat-key       = pa_key.
  gs_fcat-coltext   = pa_coltext.
  gs_fcat-fieldname = pa_fname.
  gs_fcat-ref_table = pa_ref_t.
  gs_fcat-ref_field = pa_ref_f.
  gs_fcat-edit      = pa_edit.
  gs_fcat-currency  = pa_curr.
  gs_fcat-quantity  = pa_qnt.

  APPEND gs_fcat TO gt_fcat.
  CLEAR  gs_fcat.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form on_toolbar
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM on_toolbar .


ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_handler
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_handler .

  CALL METHOD go_alv->register_edit_event
    EXPORTING
      i_event_id = cl_gui_alv_grid=>mc_evt_modified.

  SET HANDLER lcl_event=>on_toolbar      FOR go_alv.
  SET HANDLER lcl_event=>on_data_changed FOR go_alv.
  SET HANDLER lcl_event=>ON_user_command FOR go_alv.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form insert_rows
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insert_rows USING pa_data_changed TYPE REF TO cl_alv_changed_data_protocol.
  DATA ls_ins_row  TYPE lvc_s_moce.


  "field symbol 이용
  FIELD-SYMBOLS <fs> LIKE gt_data.

  IF pa_data_changed->mt_inserted_rows IS NOT INITIAL.
    ASSIGN pa_data_changed->mp_mod_rows->* TO <fs>.

    IF sy-subrc = 0.
      APPEND LINES OF <fs> TO gt_data.
      LOOP AT pa_data_changed->mt_inserted_rows INTO ls_ins_row.

        CALL METHOD pa_data_changed->modify_style
          EXPORTING
            i_row_id    = ls_ins_row-row_id
            i_fieldname = 'PCODE'
            i_style     = cl_gui_alv_grid=>mc_style_enabled.

      ENDLOOP.
    ENDIF.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form SEARCH_HELP_PA_VEN
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM search_help_pa_ven .

  DATA : BEGIN OF ls_ven,
           kunnr TYPE kna1-kunnr,
           name1 TYPE kna1-name1,
         END OF ls_ven,

         lt_ven LIKE TABLE OF ls_ven.
  SELECT kunnr name1
    FROM kna1
  INTO CORRESPONDING FIELDS OF TABLE lt_ven.

  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
    EXPORTING
      retfield     = 'KUNNR'
      dynpprog     = sy-repid
      dynpnr       = sy-dynnr
      dynprofield  = 'PA_VEN'
      window_title = 'Customer List'
      value_org    = 'S'
*     DISPLAY      = ' '
* IMPORTING
*     USER_RESET   =
    TABLES
      value_tab    = lt_ven.

  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form modify_row
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ER_DATA_CHANGED
*&---------------------------------------------------------------------*
FORM modify_row  USING pa_data_changed TYPE REF TO cl_alv_changed_data_protocol.

  DATA ls_mod_cell TYPE lvc_s_modi.

  IF pa_data_changed->mt_mod_cells IS NOT INITIAL.

    LOOP AT pa_data_changed->mt_mod_cells INTO ls_mod_cell.

      CASE ls_mod_cell-fieldname.
        WHEN 'PCODE'.
          DATA : lv_pcode TYPE ztvermata20-pcode,
                 lv_maktx TYPE makt-maktx,
                 lv_unit  TYPE ztvermata20-order_unit.

          CLEAR : lv_pcode, lv_maktx, lv_unit.

          "변경한 cell 값 가져오기
          CALL METHOD pa_data_changed->get_cell_value
            EXPORTING
              i_row_id    = ls_mod_cell-row_id
              i_fieldname = 'PCODE'
            IMPORTING
              e_value     = lv_pcode.

          IF lv_pcode IS NOT INITIAL.
            READ TABLE gt_data INTO gs_data WITH KEY pcode = lv_pcode.

            IF sy-subrc = 0.
              MESSAGE s016(pn) WITH '동일한 데이터가 존재합니다.'.
              CLEAR gs_data.

            ELSE.
              SELECT SINGLE maktx
                       FROM makt
                       INTO lv_maktx
                      WHERE matnr = lv_pcode.
            ENDIF.
          ELSE.
            CLEAR : lv_pcode, lv_maktx.

          ENDIF.

          "수정된 값을 alv에 반영
          CALL METHOD pa_data_changed->modify_cell
            EXPORTING
              i_row_id    = ls_mod_cell-row_id
*             i_tabix     =
              i_fieldname = 'MAKTX'
              i_value     = lv_maktx.

          "수정된 값을 internal table에 반영
          CLEAR gs_data.
          gs_data-pcode   = lv_pcode.
          gs_data-maktx   = lv_maktx.
          gs_data-vendor  = ztversa20-vendor.
          gs_data-version = ztversa20-version.

          MODIFY gt_data FROM gs_data INDEX ls_mod_cell-row_id TRANSPORTING pcode maktx vendor version.

          IF sy-subrc = 0.
            READ TABLE gt_data INTO gs_data INDEX ls_mod_cell-row_id.
            IF gs_data-order_unit IS NOT INITIAL.
              "pcode, unit 모두 수정했다면 pcode output field로 변경
              CALL METHOD pa_data_changed->modify_style
                EXPORTING
                  i_row_id    = ls_mod_cell-row_id
                  i_fieldname = 'PCODE'
                  i_style     = cl_gui_alv_grid=>mc_style_disabled.
              "수정한 row 체크
              gs_data-modified = 'X'.
              """"""""확인용
              CALL METHOD pa_data_changed->modify_cell
                EXPORTING
                  i_row_id    = ls_mod_cell-row_id
                  i_fieldname = 'MODIFIED'
                  i_value     = gs_data-modified.

              MODIFY gt_data FROM gs_data INDEX ls_mod_cell-row_id TRANSPORTING modified.
            ENDIF.
          ENDIF.

        WHEN 'ORDER_UNIT'.

          CALL METHOD pa_data_changed->get_cell_value
            EXPORTING
              i_row_id    = ls_mod_cell-row_id
              i_fieldname = 'ORDER_UNIT'
            IMPORTING
              e_value     = lv_unit.

          IF lv_unit IS NOT INITIAL.

            READ TABLE gt_data INTO gs_data WITH KEY order_unit = lv_unit.

            IF sy-subrc <> 0.
              SELECT SINGLE msehi
                FROM t006
                INTO gs_data-order_unit
               WHERE msehi = lv_unit.
            ENDIF.

            MODIFY gt_data FROM gs_data INDEX ls_mod_cell-row_id TRANSPORTING order_unit.

            IF sy-subrc = 0.

              READ TABLE gt_data INTO gs_data INDEX ls_mod_cell-row_id.

              IF gs_data-pcode IS INITIAL.
                MESSAGE i016(pn) WITH '제품 코드를 입력하세요.'.
              ELSE.
                CALL METHOD pa_data_changed->modify_style
                  EXPORTING
                    i_row_id    = ls_mod_cell-row_id
                    i_fieldname = 'PCODE'
                    i_style     = cl_gui_alv_grid=>mc_style_disabled.

                gs_data-modified = 'X'.
                """""""""확인용
                CALL METHOD pa_data_changed->modify_cell
                  EXPORTING
                    i_row_id    = ls_mod_cell-row_id
                    i_fieldname = 'MODIFIED'
                    i_value     = gs_data-modified.
                MODIFY gt_data FROM gs_data INDEX ls_mod_cell-row_id TRANSPORTING modified.

              ENDIF.
            ENDIF.
          ENDIF.
      ENDCASE.
    ENDLOOP.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form delete_rows
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ER_DATA_CHANGED
*&---------------------------------------------------------------------*
FORM delete_rows  USING pa_data_changed TYPE REF TO cl_alv_changed_data_protocol.
    DATA ls_del_row TYPE lvc_s_moce.

    IF pa_data_changed->mt_deleted_rows IS NOT INITIAL.

      LOOP AT pa_data_changed->mt_deleted_rows INTO ls_del_row.
        CLEAR : gs_data, gs_data_del.

        READ TABLE gt_data INTO gs_data INDEX ls_del_row-row_id.

        IF sy-subrc = 0.
          MOVE-CORRESPONDING gs_data TO gs_data_del.
          APPEND gs_data_del TO gt_data_del.
        ENDIF.

      ENDLOOP.
    ENDIF.
ENDFORM.
