*&---------------------------------------------------------------------*
*& Include          ZC1R200001_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form init_param
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_param .

  pa_carr = 'KA'.

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

  CLEAR : gs_data, gt_data.

  SELECT carrid connid fldate price currency planetype
    FROM sflight
    INTO CORRESPONDING FIELDS OF TABLE gt_data
   WHERE carrid  = pa_carr
     AND connid IN so_conn.

  IF sy-subrc <> 0.
    MESSAGE s001.
    LEAVE LIST-PROCESSING. "STOP
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

  IF gt_fcat IS INITIAL.
    PERFORM set_fcat USING :
     'X' 'CARRID'    '' 'SFLIGHT' 'CARRID',
     'X' 'CONNID'    '' 'SFLIGHT' 'CONNID',
     'X' 'FLDATE'    '' 'SFLIGHT' 'FLDATE',
     ''  'PRICE'     '' 'SFLIGHT' 'PRICE',
     ''  'CURRENCY'  '' 'SFLIGHT' 'CURRENCY',
     ''  'PLANETYPE' '' 'SFLIGHT' 'PLANETYPE'.

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
*&      --> P_
*&      --> P_
*&---------------------------------------------------------------------*
FORM set_fcat  USING pv_key pv_field pv_text pv_ref_table pv_ref_field.

  gs_fcat = VALUE #(
                     key       = pv_key
                     fieldname = pv_field
                     coltext   = pv_text
                     ref_table = pv_ref_table
                     ref_field = pv_ref_field
                     ).
  CASE pv_field.
    WHEN 'PRICE'.
      gs_fcat-cfieldname = 'CURRENCY'.
  ENDCASE.

*  gs_fcat-key       = pv_key.
*  gs_fcat-fieldname = pv_field.
*  gs_fcat-coltext   = pv_text.
*  gs_fcat-ref_table = pv_ref_table.
*  gs_fcat-ref_field = pv_ref_field.
*
  APPEND gs_fcat TO gt_fcat.
*  CLEAR gt_fcat.

ENDFORM.
*&---------------------------------------------------------------------*
*& Module DISPLAY_SCREEN OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE display_screen OUTPUT.

  PERFORM display_screen.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Form display_screen
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_screen .

  IF gcl_container IS INITIAL. "is not bound.
    CREATE OBJECT gcl_container
      EXPORTING
        repid     = sy-repid
        dynnr     = sy-dynnr "screen ??????
*       side      = cl_gui_docking_container=>dock_at_left
        side      = gcl_container->dock_at_left
        extension = 3000.


    CREATE OBJECT gcl_grid
      EXPORTING
        i_parent = gcl_container.

    gs_variant-report = sy-cprog. "sy-repid

    CALL METHOD gcl_grid->set_table_for_first_display
      EXPORTING
        is_variant      = gs_variant
        i_save          = 'A'
        i_default       = 'X'
        is_layout       = gs_layout
      CHANGING
        it_outtab       = gt_data
        it_fieldcatalog = gt_fcat.

    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.
  ENDIF.

ENDFORM.
