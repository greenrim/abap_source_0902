*&---------------------------------------------------------------------*
*& Include          ZC1R200005_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_belnr .

  SELECT a~belnr a~buzei a~shkzg a~dmbtr a~hkont
         b~blart b~budat b~waers
    FROM bseg AS a
   INNER JOIN bkpf AS b
      ON a~bukrs = b~bukrs
     AND a~belnr = b~belnr
     AND a~gjahr = b~gjahr
    INTO CORRESPONDING FIELDS OF TABLE gt_Data
   WHERE b~bukrs = pa_bukr
     AND b~gjahr = pa_gjah
     AND b~belnr IN so_beln
     AND b~blart IN so_blar.

  IF sy-subrc NE 0.
    MESSAGE s001.
    LEAVE LIST-PROCESSING.
  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form init_param
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_param .

  pa_bukr = '1010'.
  pa_gjah = sy-datum(4).  "현재 연도 (앞 4자리만 가져오기)

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_fcat_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fcat_layout .

  gs_layout-zebra      = 'X'.
  gs_layout-sel_mode   = 'X'.
  gs_layout-cwidth_opt = 'X'.

  "fcat은 항상 비어있을 때에만 생성
  IF gt_fcat IS INITIAL.

    PERFORM set_fcat USING :
          'X' 'BELNR'    ' '  'BSEG'     'BELNR',
          'X' 'BUZEI'    ' '  'BSEG'     'BUZEI',
          'X' 'BLART'    ' '  'BKPF'     'BLART',
          ' ' 'BUDAT'    ' '  'BKPF'     'BUDAT',
          ' ' 'SHKZG'    ' '  'BSEG'     'SHKZG',
          ' ' 'DMBTR'    ' '  'BSEG'     'DMBTR',
          ' ' 'WAERS'    ' '  'BKPF'     'WAERS',
          ' ' 'HKONT'    ' '  'BSEG'     'HKONT'.
  ENDIF.



*BUKRS
*BELNR
*GJAHR
*DMBTR
*perform set_fcat using :
*      'X'   'BELNR'   ' '   'BSEG'  'BELNR'
ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_fcat
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&---------------------------------------------------------------------*
FORM set_fcat  USING  pv_key pv_field pv_text pv_ref_t pv_ref_f.

  gs_fcat = VALUE #( key       = pv_key
                     fieldname = pv_field
                     coltext   = pv_text
                     ref_table = pv_ref_t
                     ref_field = pv_ref_f ).

  CASE pv_field.
    WHEN 'DMBTR'.
      gs_fcat-cfieldname = 'WAERS'.
    WHEN 'BELNR'.
      gs_fcat-hotspot = 'X'.
  ENDCASE.

  APPEND gs_fcat TO gt_fcat.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form handle_hotspot
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_ROW_ID
*&      --> E_COLUMN_ID
*&---------------------------------------------------------------------*
FORM handle_hotspot  USING ps_row_id    TYPE lvc_s_row
                           ps_column_id TYPE lvc_s_col.

  READ TABLE gt_data INTO gs_data INDEX ps_row_id-index.

  IF sy-subrc NE 0.
    EXIT.
  ENDIF.

  CASE ps_column_id-fieldname.
    WHEN 'BELNR'.
      IF gs_data-belnr IS INITIAL.
        EXIT.
      ENDIF.
      SET PARAMETER ID : 'BLN' FIELD gs_data-belnr,
                         'BUK' FIELD pa_bukr,
                         'GJR' FIELD  pa_gjah.

      CALL TRANSACTION 'FB03' AND SKIP FIRST SCREEN.
  ENDCASE.

ENDFORM.
