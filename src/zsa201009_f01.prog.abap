*&---------------------------------------------------------------------*
*& Include          ZSA201009_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form create_alv
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM create_alv .
  IF go_con IS INITIAL.
    CREATE OBJECT go_con
      EXPORTING
        repid     = sy-repid
        dynnr     = sy-dynnr
        side      = go_con->dock_at_left
        extension = 3000.

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
*           it_toolbar_excluding          =
          CHANGING
            it_outtab       = gt_data
            it_fieldcatalog = gt_fcat
*           it_sort         =
*           it_filter       =
          .

      ENDIF.
    ENDIF.
  ELSE.

  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form exit
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM exit .

  go_alv->free( ).
  go_con->free( ).

  FREE : go_alv, go_con.

  LEAVE TO SCREEN 0.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form create_layout_fcat
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM create_layout_fcat .
  gs_layout-zebra      = 'X'.
  gs_layout-sel_mode   = 'D'.
  gs_layout-cwidth_opt = 'X'.

*key coltext fname reff reft curr quant hotspot
  PERFORM create_fcat USING :
        'X' '' 'MATNR' 'MAST' 'MATNR' '' '' '',
        ''  '' 'MAKTX' 'MAKT' 'MAKTX' '' '' '',
        ''  '' 'STLAN' 'MAST' 'STLAN' '' '' '',
        ''  '' 'STLNR' 'MAST' 'STLNR' '' '' 'X',
        ''  '' 'STLAL' 'MAST' 'STLAL' '' '' '',
        ''  '' 'MTART' 'MARA' 'MTART' '' '' '',
        ''  '' 'MATKL' 'MARA' 'MATKL' '' '' ''.

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
FORM create_fcat  USING pa_key pa_coltext pa_fname pa_ref_t pa_ref_f pa_curr pa_qunt pa_hot.
*key coltext fname reff reft curr quant hotspot

  gt_fcat = VALUE #( BASE gt_fcat
                     ( key       = pa_key
                       coltext   = pa_coltext
                       fieldname = pa_fname
                       ref_table = pa_ref_t
                       ref_field = pa_ref_f
                       currency  = pa_curr
                       quantity  = pa_qunt
                       hotspot   = pa_hot
                       )
                       ).

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
  CLEAR : gt_data, gt_makt.

  "text table을 left outer join으로 걸자
  SELECT a~mtart a~matkl
         b~matnr b~stlan b~stlnr b~stlal
         c~maktx
    FROM mara AS a INNER JOIN mast AS b
      ON a~matnr =  b~matnr
    LEFT OUTER JOIN makt AS c
      ON a~matnr =  c~matnr
     AND c~spras =  sy-langu     "left outer join으로 걸린 table의 field는 where조건 불가
    INTO CORRESPONDING FIELDS OF TABLE gt_data
   WHERE b~werks =  pa_werk
     AND b~matnr IN so_matn.

*  SELECT a~mtart a~matkl
*         b~matnr b~stlan b~stlnr b~stlal
*    FROM mara AS a INNER JOIN mast AS b
*      ON a~matnr =  b~matnr
*    INTO CORRESPONDING FIELDS OF TABLE gt_data
*   WHERE b~werks =  pa_werk
*     AND b~matnr IN so_matn.
*
*  SELECT matnr maktx
*    FROM makt
*    INTO CORRESPONDING FIELDS OF TABLE gt_makt
*   WHERE matnr IN so_matn
*     AND spras =  sy-langu.

  IF sy-subrc <> 0.
    MESSAGE i001(zmcsa20).
    LEAVE LIST-PROCESSING.
  ENDIF.

  CLEAR : gs_data, gv_tabix.

*  LOOP AT gt_data INTO gs_data.
*    gv_tabix = sy-tabix.
*
*    READ TABLE gt_makt INTO gs_makt WITH KEY matnr = gs_data-matnr.
*
*    IF sy-subrc = 0.
*      gs_data-maktx = gs_makt-maktx.
*      MODIFY gt_data FROM gs_data INDEX gv_tabix TRANSPORTING maktx.
*    ENDIF.
*
*  ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_HANDLER
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_handler .

  SET HANDLER lcl_event=>on_double_click  FOR go_alv.
  SET HANDLER lcl_event=>on_hotspot_click FOR go_alv.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form ON_HOTSPOT_CLICK
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM on_hotspot_click USING pa_row_id    TYPE lvc_s_row
                            pa_column_id TYPE lvc_s_col.

  CASE pa_column_id-fieldname.

    WHEN 'STLNR'.
      CLEAR gs_data.
      READ TABLE gt_data INTO gs_data INDEX pa_row_id-index.

      IF sy-subrc = 0.
        SET PARAMETER ID : 'MAT' FIELD gs_data-matnr,
                           'WRK' FIELD pa_werk,
                           'CSV' FIELD gs_data-stlan.
        CALL TRANSACTION   'CS03'.
      ENDIF.

  ENDCASE.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form on_double_click
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_COLUMN
*&      --> E_ROW
*&---------------------------------------------------------------------*
FORM on_double_click  USING pa_column TYPE lvc_s_col
                            pa_row    TYPE lvc_s_row.

  CASE pa_column-fieldname.
    WHEN 'MATNR'.
      CLEAR gs_data.

      READ TABLE gt_data INTO gs_data INDEX pa_row-index.

      IF sy-subrc = 0.
        SET PARAMETER ID 'MAT' FIELD gs_data-matnr.
        CALL TRANSACTION 'MM03'. " AND SKIP FIRST SCREEN.
      ENDIF.

  ENDCASE.

ENDFORM.
