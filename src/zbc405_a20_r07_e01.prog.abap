*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_R07_E01
*&---------------------------------------------------------------------*

INITIALIZATION.
  so_car-low = 'LH'.
  so_car-high = 'LH'.
  APPEND so_car.

AT SELECTION-SCREEN OUTPUT. "PBO

AT SELECTION-SCREEN. "PAI

START-OF-SELECTION.

  DATA lt_sbook LIKE gt_sbook.

  SELECT *
    FROM ztsbook_a20
    INTO CORRESPONDING FIELDS OF TABLE gt_sbook
  WHERE carrid IN so_car
    AND connid IN so_con.

  IF sy-subrc = 0.
    MOVE-CORRESPONDING gt_sbook TO lt_sbook.
    DELETE lt_sbook WHERE customid = space.

    SORT lt_sbook BY customid.
    DELETE ADJACENT DUPLICATES FROM lt_sbook COMPARING customid.

    SELECT *
      FROM ztscustom_a20
      INTO CORRESPONDING FIELDS OF TABLE gt_custom
      FOR ALL ENTRIES IN lt_sbook
      WHERE id = lt_sbook-customid.
  ENDIF.

  CLEAR gs_sbook.
  LOOP AT gt_sbook INTO gs_sbook.
    "gsbook을 바꾸는 로직
    CLEAR gs_cellcol.

    READ TABLE gt_custom INTO gs_custom WITH KEY id = gs_sbook-customid.
    gs_sbook-telephone = gs_custom-telephone.
    gs_sbook-email = gs_custom-email.
    gs_sbook-name = gs_custom-name.

    "ROW COLOR
    CASE gs_sbook-cancelled.
      WHEN 'X'.
        gs_sbook-rowcol = 'C510'.
    ENDCASE.

    "CELL COLOR
    CASE gs_sbook-smoker.
      WHEN 'X'.
        CLEAR : gs_cellcol, gs_sbook-cellcol.
        gs_cellcol-fname = 'SMOKER'.
        gs_cellcol-color-col = 6.
        gs_cellcol-color-int = 1.
        gs_cellcol-color-inv = 0.
        APPEND gs_cellcol TO gs_sbook-cellcol.
        CLEAR gs_cellcol.
    ENDCASE.

    "EXCEPTION 신호등
    IF gs_sbook-luggweight >= 25.
      gs_sbook-light = 1.
    ELSEIF gs_sbook-luggweight >= 15.
      gs_sbook-light = 2.
    ELSE.
      gs_sbook-light = 3.
    ENDIF.

    MODIFY gt_sbook FROM gs_sbook. "바뀐 gs_book으로 gt_sbook을 변경함
    "gsbook을 바꾸는 로직 -> gt_sbook으로 반영되지 않음
    CLEAR gs_sbook.
  ENDLOOP.


  CALL SCREEN 100.
