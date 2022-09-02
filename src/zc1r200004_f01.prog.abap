*&---------------------------------------------------------------------*
*& Include          ZC1R200004_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_flight_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_flight_data .

  CLEAR gt_data.

  SELECT a~carrid a~carrname a~url
         b~connid b~fldate   b~planetype  b~price b~currency
    FROM scarr AS a
    INNER JOIN sflight AS b
      ON a~carrid    = b~carrid
    INTO CORRESPONDING FIELDS OF TABLE gt_data
   WHERE a~carrid    IN so_carr
     AND b~connid    IN so_conn
     AND b~planetype IN so_plan.

  IF sy-subrc NE 0.
    MESSAGE s001.
    LEAVE LIST-PROCESSING.
  ENDIF.

*    cl_demo_output=>display_data( gt_data ).

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
*&      --> P_
*&---------------------------------------------------------------------*
FORM set_fcat  USING pv_key pv_fname pv_text pv_ref_t pv_ref_f pv_curr.

  "key fieldname coltext ref_t ref_f currency
  CLEAR gs_fcat.

  gs_fcat-key = pv_key.
  gs_fcat-fieldname = pv_fname.
  gs_fcat-coltext = pv_text.
  gs_fcat-ref_table = pv_ref_t.
  gs_fcat-ref_field = pv_ref_f.
  gs_fcat-cfieldname = pv_curr.

  CASE pv_fname.
    WHEN 'PLANETYPE'.
      gs_fcat-hotspot = 'X'.
  ENDCASE.

  APPEND gs_fcat TO gt_fcat.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form on_double_click
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_ROW
*&      --> E_COLUMN
*&---------------------------------------------------------------------*
FORM on_double_click  USING ps_row    TYPE lvc_s_row
                            ps_column TYPE lvc_s_col.

  READ TABLE gt_data INTO gs_data INDEX ps_row-index.

  IF sy-subrc NE 0.
    EXIT.
  ENDIF.

  IF ps_column-fieldname NE 'PLANETYPE'.
    SELECT carrid   connid   fldate      bookid
           customid custtype luggweight wunit
      FROM sbook
      INTO CORRESPONDING FIELDS OF TABLE gt_sbook
     WHERE carrid = gs_data-carrid
       AND connid = gs_data-connid
       AND fldate = gs_data-fldate.

*    CL_DEMO_OUTPUT=>DISPLAY_DATA( GT_SBOOK ).
    CALL SCREEN '0101' STARTING AT 20 10.


  ENDIF.
*gs_data-carrid , connid, fldate


ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_FCAT_POP
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&---------------------------------------------------------------------*
FORM set_fcat_pop  USING pv_key pv_fname pv_ref_t pv_ref_f pv_qunt.

  "KEY FIELD REF_T REFT_F QUNT

  gt_fcat_pop = VALUE #( BASE gt_fcat_pop
                         ( key = pv_key
                           fieldname = pv_fname
                           ref_table = pv_ref_t
                           ref_field = pv_ref_f
                           qfieldname = pv_qunt
                           )
                        ).

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_fcat_layout_0102
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fcat_layout_0102 .
  gs_layout_saplane-zebra      = 'X'.
  gs_layout_saplane-cwidth_opt = 'X'.
  gs_layout_saplane-sel_mode   = 'D'.
  gs_layout_saplane-no_toolbar = 'X'. "ALV TOOLBER 제거

  IF gt_fcat_saplane IS INITIAL.

    PERFORM set_fcat_0102 USING :
      'X'  'PLANETYPE'    ' '   'SAPLANE'  'PLANETYPE',
      ' '  'SEATSMAX'     ' '   'SAPLANE'  'SEATSMAX',
      ' '  'TANKCAP'      ' '   'SAPLANE'  'TANKCAP',
      ' '  'CAP_UNIT'     ' '   'SAPLANE'  'CAP_UNIT',
      ' '  'WEIGHT'       ' '   'SAPLANE'  'WEIGHT',
      ' '  'WEI_UNIT'     ' '   'SAPLANE'  'WEI_UNIT',
      ' '  'PRODUCER'     ' '   'SAPLANE'  'PRODUCER'.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_fcat_0102
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&---------------------------------------------------------------------*
FORM set_fcat_0102  USING pv_key pv_field pv_text pv_ref_table pv_ref_field.

  gs_fcat_saplane = VALUE #(
                         key = pv_field
                         fieldname = pv_field
                         coltext  = pv_text
                         ref_table = pv_ref_table
                         ref_field = pv_ref_field
                         ).

  CASE pv_field.
    WHEN 'TANKCAP'.
      gs_fcat_saplane-qfieldname = 'X'.
    WHEN 'WEIGHT'.
      gs_fcat_saplane-qfieldname = 'X'.
  ENDCASE.

  APPEND gs_fcat_saplane TO  gt_fcat_saplane.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form dsiplay_screen_0102
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM dsiplay_screen_0102 .
  IF  gcl_container_saplane IS NOT BOUND.
    CREATE OBJECT gcl_container_saplane
      EXPORTING
        container_name = 'GCL_CONTAINER_SAPLANE'.
    "Ctrl+l : lower case +U : Upper case.

    CREATE OBJECT gcl_grid_saplane
      EXPORTING
        i_parent = gcl_container_saplane.

    CALL METHOD gcl_grid_saplane->set_table_for_first_display
      EXPORTING
        i_save          = 'A'
        i_default       = 'X'
        is_layout       = gs_layout_saplane
      CHANGING
        it_outtab       = gt_saplane
        it_fieldcatalog = gt_fcat_saplane.

  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form handle_hotspot_click
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_ROW_ID
*&      --> E_COLUMN_ID
*&---------------------------------------------------------------------*
FORM handle_hotspot_click   USING ps_row_id    TYPE lvc_s_row
                                 ps_column_id TYPE lvc_s_col.

  READ TABLE gt_data INTO gs_data INDEX ps_row_id-index.

  IF sy-subrc NE 0.
    EXIT.
  ENDIF.

  SELECT planetype  seatsmax  tankcap
         cap_unit   weight    wei_unit  producer
    FROM saplane
    INTO CORRESPONDING FIELDS OF TABLE gt_saplane
   WHERE planetype = gs_data-planetype.

  IF sy-subrc NE 0.
    EXIT.
  ENDIF.

  CALL SCREEN '0102' STARTING AT 20 20.

ENDFORM.
