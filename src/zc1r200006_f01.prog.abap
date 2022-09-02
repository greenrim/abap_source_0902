*&---------------------------------------------------------------------*
*& Include          ZC1R200002_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_bom_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_bom_data .

  CLEAR : gs_data, gt_data.
*  _clear : gs_data, gt_data.
*
*  DEFINE _clear.
*    CLEAR   &1.
*    REFRESH &2.
*  END-OF-DEFINITION.


  SELECT a~mtart a~matkl
         b~matnr b~stlan b~stlnr b~stlal
    FROM mara AS a
   INNER JOIN mast AS b
      ON a~matnr =  b~matnr
   "left outer join으로 걸린 table의 field는 where조건 불가
    INTO CORRESPONDING FIELDS OF TABLE gt_data
   WHERE b~werks =  pa_werks
     AND b~matnr IN so_matnr.

  IF sy-subrc <> 0.
    MESSAGE i001.
    LEAVE LIST-PROCESSING. "멈춰서 사용자에게 다른 검색조건을 유도해야 한다.
  ENDIF.

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
  gs_layout-sel_mode   = 'D'.
  gs_layout-cwidth_opt = 'X'.

  "pbo 다시 탈때 fcat을 다시 만들지 않도록 비어 있을 때만 만들도록 하자

  IF gt_fcat IS INITIAL.
    PERFORM set_fcat USING :
          'X' 'MATNR' '' 'MAST' 'MATNR',
          ' ' 'MAKTX' '' 'MAKT' 'MAKTX',
          ' ' 'STLAN' '' 'MAST' 'STLAN',
          ' ' 'STLNR' '' 'MAST' 'STLNR',
          ' ' 'STLAL' '' 'MAST' 'STLAL',
          ' ' 'MTART' '' 'MARA' 'MTART',
          ' ' 'MATKL' '' 'MARA' 'MATKL'.

  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_fcat
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      --> P_
*&      --> P_
*&---------------------------------------------------------------------*
FORM set_fcat  USING pv_key  pv_field  pv_text  pv_ref_table  pv_ref_field.

*  gt_fcat = VALUE #( BASE gt_fcat
*                     ( key       = pv_key
*                       fieldname = pv_field
*                       coltext   = pv_text
*                       ref_table = pv_ref_table
*                       ref_field = pv_ref_field
*                       )                             "괄호가 하나의 행으로 append가 된다
*                    ).

  "hospot 이벤트도 써야해서 수정함

  gs_fcat = VALUE #(
                      key       = pv_key
                       fieldname = pv_field
                       coltext   = pv_text
                       ref_table = pv_ref_table
                       ref_field = pv_ref_field
                                                   "괄호가 하나의 행으로 append가 된다
                    ).

  CASE pv_field.
    WHEN 'STLNR'.
      gs_fcat-hotspot = 'X'.
  ENDCASE.

  APPEND gs_fcat TO gt_fcat.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_screen
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_screen .

  IF gcl_container IS NOT BOUND.
    CREATE OBJECT gcl_container
      EXPORTING
        repid     = sy-repid
        dynnr     = sy-dynnr
        side      = gcl_container->dock_at_left
*       side      = cl_gui_docking_container=>dock_at_left
        extension = 3000.

    CREATE OBJECT gcl_grid
      EXPORTING
        i_parent = gcl_container.

    gs_variant-report = sy-repid.

    IF gcl_handler IS NOT BOUND.
      CREATE OBJECT gcl_handler.
    ENDIF.
    SET HANDLER : gcl_handler->handle_double_click FOR gcl_grid,
                  gcl_handler->handle_hotspot      FOR gcl_grid.

    CALL METHOD gcl_grid->set_table_for_first_display
      EXPORTING
        is_variant      = gs_variant
        i_save          = 'A'
        i_default       = 'X'
        is_layout       = gs_layout
      CHANGING
        it_outtab       = gt_data
        it_fieldcatalog = gt_fcat.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form handle_double_click
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_ROW
*&      --> E_COLUMN
*&---------------------------------------------------------------------*
FORM handle_double_click  USING ps_row    TYPE lvc_s_row
                                ps_column TYPE lvc_s_col.

  READ TABLE gt_data INTO gs_data INDEX ps_row-index.

  IF sy-subrc NE 0.
    EXIT.
  ENDIF.

  CASE ps_column-fieldname.
    WHEN 'MATNR'.
      IF gs_data-matnr IS INITIAL.
        EXIT.
      ENDIF.

      SET PARAMETER ID : 'MAT' FIELD gs_data-matnr.
      LEAVE TO TRANSACTION 'MM03' AND SKIP FIRST SCREEN.

  ENDCASE.

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
    WHEN 'STLNR'.
      IF gs_data-stlnr IS INITIAL.
        EXIT.
      ENDIF.
      SET PARAMETER ID : 'MAT' FIELD gs_data-matnr,
                         'WRK' FIELD pa_werks,
                         'CSV' FIELD gs_data-stlnr.
      CALL TRANSACTION 'CS03' AND SKIP FIRST SCREEN.
  ENDCASE.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_Material_detail
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_Material_detail .

  DATA : lv_tabix    TYPE sy-tabix,
         lv_maktx    TYPE makt-maktx,
         lv_matnr    TYPE mara-matnr,
         lv_code,
         lv_msg(100).

  IF gcl_makt IS NOT BOUND.
    CREATE OBJECT gcl_makt.
  ENDIF.

  CLEAR : gs_data, lv_maktx, lv_matnr.
  LOOP AT gt_data INTO gs_data.
    lv_tabix = sy-tabix.

    CALL METHOD gcl_makt->get_material_info
      EXPORTING
        pi_matnr = gs_data-matnr
        pi_spras = sy-langu
      IMPORTING
        pe_maktx = lv_maktx
        pe_code  = lv_code
        pe_msg   = lv_msg.

    IF lv_code  EQ 'S'.
      gs_data-maktx = lv_maktx.
      MODIFY gt_data FROM gs_Data INDEX lv_tabix TRANSPORTING maktx.
    ENDIF.




  ENDLOOP.

ENDFORM.
