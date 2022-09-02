*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_EXAM01_F01
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

  SELECT *
    FROM ztspfli_a20
    INTO CORRESPONDING FIELDS OF TABLE gt_spfli
    WHERE carrid IN so_car
    AND connid IN so_con.

  SELECT *
    FROM sairport
    INTO CORRESPONDING FIELDS OF TABLE gt_port.

  LOOP AT gt_spfli INTO gs_spfli.

    "SET I&D
    CLEAR : gs_cellcol.
    IF gs_spfli-countryfr = gs_spfli-countryto.
      CLEAR : gs_cellcol.
      gs_spfli-dIf = 'I'.
      gs_cellcol-fname = 'DIF'.
      gs_cellcol-color-col = col_positive.
      gs_cellcol-color-int = 1.
      gs_cellcol-color-inv = 0.
      APPEND gs_cellcol TO gs_spfli-cellcol.
      CLEAR : gs_cellcol.
    ELSE.
      CLEAR : gs_cellcol.
      gs_spfli-dIf = 'D'.
      gs_cellcol-fname = 'DIF'.
      gs_cellcol-color-col = col_total.
      gs_cellcol-color-int = 1.
      gs_cellcol-color-inv = 0.
      APPEND gs_cellcol TO gs_spfli-cellcol.
      CLEAR : gs_cellcol.
    ENDIF.

    "SET FLTYPE ICON
    CASE gs_SPFLI-fltype.
      WHEN 'X'.
        gs_SPFLI-fltype_icon = icon_ws_plane. "icon_flight.
      WHEN OTHERS.
        gs_SPFLI-fltype_icon  = icon_space.
    ENDCASE.

    "EXCEPTION
    IF gs_spfli-period = 0.
      gs_SPFLI-light = 3.
    ELSEIF gs_spfli-period = 1.
      gs_SPFLI-light = 2.
    ELSEIF gs_spfli-period >= 2.
      gs_SPFLI-light = 1.
    ENDIF.

    "TIME_ZONE
    CLEAR gs_port.
    READ TABLE gt_port INTO gs_port WITH KEY id = gs_spfli-airpfrom.
    gs_spfli-ftzone = gs_port-time_zone.
    CLEAR gs_port.
    READ TABLE gt_port INTO gs_port WITH KEY id = gs_spfli-AIRPto.
    gs_spfli-ttzone = gs_port-time_zone.

    MODIFY gt_spfli FROM gs_spfli.
  ENDLOOP.

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
  gs_fcat-fieldname = 'DIF'.
  gs_fcat-coltext = 'I&D'.
  gs_fcat-col_opt = 'X'.
  gs_fcat-col_pos = 5.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'FLTYPE_ICON'.
  gs_fcat-coltext = 'FLIGHT'.
  gs_fcat-col_pos = 9.
  gs_fcat-just = 'C'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'FLTYPE'.
  gs_fcat-no_out = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'ARRTIME'.
  gs_fcat-emphasize = 'C710'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'PERIOD'.
  gs_fcat-emphasize = 'C710'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'FLTIME'.
  gs_fcat-edit = pa_edit.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'DEPTIME'.
  gs_fcat-edit = pa_edit.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'FTZONE'.
  gs_fcat-coltext = 'From TZ'.
  gs_fcat-col_pos = 17.
  gs_fcat-col_opt = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'TTZONE'.
  gs_fcat-coltext = 'To TZ'.
  gs_fcat-col_pos = 18.
  gs_fcat-col_opt = 'X'.
  APPEND gs_fcat TO gt_fcat.


  CLEAR gs_fcat.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_layout_and_Variant .
  "SET VARIANT
  gs_variant-variant = pa_var.

  "TITLE
  gs_layout-grid_title = 'Flight Schedule Report'.

  "ZEBRA
  gs_layout-zebra = 'X'.

  "SEL MODE
  gs_layout-sel_mode = 'D'.

  "EXCEPTION
  gs_layout-excp_fname = 'LIGHT'.
  gs_layout-excp_led = 'X'.

  "ROW COLOR
  gs_layout-info_fname = 'ROWCOL'.

  "CELL COLOR
  gs_layout-ctab_fname = 'CELLCOL'.

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
  DATA lv_ans TYPE c LENGTH 1.

  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      titlebar              = 'Data Save'
      text_question         = 'Do you Want to Save?'
      text_button_1         = 'Yes'(001)
      text_button_2         = 'No'(002)
      display_cancel_button = ''
    IMPORTING
      answer                = lv_ans
    EXCEPTIONS
      text_not_found        = 1
      OTHERS                = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ELSE.
    IF lv_ans = '1'.

      "UPDATE
      LOOP AT gt_spfli INTO gs_spfli WHERE modified = 'X'.

        UPDATE ztspfli_a20
        SET fltime = gs_spfli-fltime
            deptime = gs_spfli-deptime
            arrtime = gs_spfli-arrtime
            period = gs_spfli-period
            WHERE carrid = gs_spfli-carrid
            AND connid = gs_spfli-connid.

      ENDLOOP.
    ENDIF.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form modify_check
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LS_MODI
*&---------------------------------------------------------------------*
FORM modify_check  USING VALUE(p_modi) TYPE lvc_s_modi.
  READ TABLE gt_spfli INTO gs_spfli INDEX p_modi-row_id.
  IF sy-subrc EQ 0.

    gs_spfli-modified = 'X'.

    MODIFY gt_spfli FROM gs_spfli INDEX p_modi-row_id.
  ENDIF.
ENDFORM.
