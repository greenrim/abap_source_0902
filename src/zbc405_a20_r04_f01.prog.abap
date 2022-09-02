*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_R04_F01
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
  DATA lt_sbook TYPE TABLE OF ts_sbook.

  SELECT *
    FROM ztsbook_a20
    INTO CORRESPONDING FIELDS OF TABLE gt_sbook
    WHERE carrid IN so_car
    AND connid IN so_con
    AND fldate IN so_fld
    AND customid IN so_cus.

  IF sy-subrc = 0.
    lt_sbook = gt_sbook.
    DELETE lt_sbook WHERE customid = space.

    SORT lt_sbook BY customid.
    DELETE ADJACENT DUPLICATES FROM lt_sbook COMPARING customid.

    SELECT *
      FROM ztscustom_a20
      INTO CORRESPONDING FIELDS OF TABLE gt_scustom
      FOR ALL ENTRIES IN lt_sbook
      WHERE id = lt_sbook-customid.
  ENDIF.


  CLEAR : gs_scustom, gs_sbook.

  LOOP AT gt_sbook INTO gs_sbook.
    READ TABLE gt_scustom INTO gs_scustom WITH KEY id = gs_sbook-customid.
    IF sy-subrc EQ 0.
      gs_sbook-telephone = gs_scustom-telephone.
      gs_sbook-email = gs_scustom-email.
    ENDIF.

    "Exception
    IF gs_sbook-luggweight > 25.
      gs_sbook-light = 1.
    ELSEIF gs_sbook-luggweight > 20.
      gs_sbook-light = 2.
    ELSE.
      gs_sbook-light = 3.
    ENDIF.

    CASE gs_sbook-class.
      WHEN 'F'.
        CLEAR gs_sbook-rowcol.
        gs_sbook-rowcol = 'C510'.
    ENDCASE.

    "Cell color
    CASE gs_sbook-smoker.
      WHEN 'X'.
        CLEAR gs_cellcol.
        gs_cellcol-fname = 'SMOKER'.
        gs_cellcol-color-col = col_negative.
        gs_cellcol-color-int = 1.
        gs_cellcol-color-inv = 0.
        APPEND gs_cellcol TO gs_sbook-cellcol.
    ENDCASE.

    "Row Color
    CASE gs_sbook-class.
      WHEN 'F'.
        gs_sbook-rowcol = 'C310'.
    ENDCASE.


    MODIFY gt_sbook FROM gs_sbook.
    CLEAR gs_sbook.
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

  gs_layout-cwidth_opt = 'X'.
  "Exception
  gs_layout-excp_fname = 'LIGHT'.
  gs_layout-excp_led = 'X'.

  gs_layout-grid_title = 'BOOKING INFO'.

  gs_layout-zebra = 'X'.

  gs_layout-sel_mode = 'D'.

  gs_layout-ctab_fname = 'CELLCOL'.
  gs_layout-info_fname = 'ROWCOL'.

  gs_layout-stylefname = 'STYL'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_catalog
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_catalog .
  CLEAR gs_fcat.
  gs_fcat-fieldname = 'LIGHT'.
  gs_fcat-coltext = 'Info'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'CUSTOMID'.
  gs_fcat-coltext = 'Cust. ID'.
  gs_fcat-edit      = pa_edit.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'TELEPHONE'.
  gs_fcat-coltext = 'Cust. Tel'.
  gs_fcat-col_pos = '7'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'EMAIL'.
  gs_fcat-coltext = 'Cust. Email'.
  gs_fcat-col_pos = '8'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'SMOKER'.
  gs_fcat-checkbox = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.

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
  gs_sort-fieldname = 'CARRID'.
  gs_sort-up = 'X'.
  gs_sort-spos = 1.
  APPEND gs_sort TO gt_sort.

  CLEAR gs_sort.
  gs_sort-fieldname = 'CONNID'.
  gs_sort-up = 'X'.
  gs_sort-spos = 2.
  APPEND gs_sort TO gt_sort.

  CLEAR gs_sort.
  gs_sort-fieldname = 'FLDATE'.
  gs_sort-down = 'X'.
  gs_sort-spos = 3.
  APPEND gs_sort TO gt_sort.

  CLEAR gs_sort.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form cust_change
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LS_MODI
*&      --> ER_DATA_CHANGED
*&---------------------------------------------------------------------*
FORM cust_change  USING    p_modi TYPE lvc_s_modi
                           p_changed TYPE REF TO cl_alv_changed_data_protocol.

  DATA : lv_customid TYPE ztsbook_a20-customid,
         lv_name     TYPE ztscustom_a20-NAMe,
         lv_tel      TYPE ztscustom_a20-telephone,
         lv_email    TYPE  ztscustom_a20-email.

  READ TABLE gt_sbook INTO gs_sbook INDEX p_modi-row_id.
  CALL METHOD p_changed->get_cell_value
    EXPORTING
      i_row_id    = p_modi-row_id
*     i_tabix     =
      i_fieldname = 'CUSTOMID'
    IMPORTING
      e_value     = lv_customid.

  IF lv_customid IS NOT INITIAL.
    READ TABLE gt_scustom INTO gs_scustom WITH KEY id = lv_customid.
    IF sy-subrc = 0.
      lv_email = gs_Scustom-email.
      lv_name = gs_Scustom-name.
      lv_TEL = gs_Scustom-telephone.
    ELSE.
      SELECT SINGLE name telephone email
        FROM ztscustom_A20
        INTO (lv_name, lv_TEL, lv_email)
        WHERE id = lv_customid.
    ENDIF.

  ELSE.
    CLEAR : lv_name, lv_tel, lv_email.
  ENDIF.

  "ALV 값 변경
  CALL METHOD p_changed->modify_cell
    EXPORTING
      i_row_id    = p_modi-row_id
*     i_tabix     =
      i_fieldname = 'TELEPHONE'
      i_value     = lv_TEL.

  CALL METHOD p_changed->modify_cell
    EXPORTING
      i_row_id    = p_modi-row_id
*     i_tabix     =
      i_fieldname = 'EMAIL'
      i_value     = lv_email.

  CALL METHOD p_changed->modify_cell
    EXPORTING
      i_row_id    = p_modi-row_id
*     i_tabix     =
      i_fieldname = 'PASSNAME'
      i_value     = lv_NAME.

  "INTERNAL TABLE
  gs_sbook-passname = lv_NAME.
  gs_sbook-email = lv_email.
  gs_sbook-telephone = lv_TEL.

  MODIFY gt_sbook FROM gs_sbook INDEX p_modi-row_id.
ENDFORM.
