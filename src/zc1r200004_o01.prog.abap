*&---------------------------------------------------------------------*
*& Include          ZC1R200004_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module SET_FCAT_LAYOUT OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE set_fcat_layout OUTPUT.

  gs_layout-zebra = 'X'.
  gs_layout-sel_mode = 'D'. " A,B,C,D
  gs_layout-cwidth_opt = 'X'.


  "key fieldname coltext ref_t ref_f currency
  PERFORM set_fcat USING :
        'X' 'CARRID'    '바꿈' 'SCARR'    'CARRID'    ' ',
        ' ' 'CARRNAME'  ' '   'SCARR'    'CARRNAME'  ' ',
        ' ' 'CONNID'    ' '   'SFLIGHT'  'CONNID'    ' ',
        ' ' 'FLDATE'    ' '   'SFLIGHT'  'FLDATE'    ' ',
        ' ' 'PLANETYPE' ' '   'SFLIGHT'  'PLANETYPE' ' ',
        ' ' 'PRICE'     ' '   'SFLIGHT'  'PRICE'     'CURRENCY',
        ' ' 'CURRENCY'  ' '   'SFLIGHT'  'CURRENCY'  ' ',
        ' ' 'URL'       ' '   'SCARR'    'URL'       ' '.


ENDMODULE.
*&---------------------------------------------------------------------*
*& Module DISPLAY_SCREEN OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE display_screen OUTPUT.

  IF gcl_con IS NOT BOUND. "is initial.

    CREATE OBJECT gcl_con
      EXPORTING
        repid     = sy-repid
        dynnr     = sy-dynnr
*       side      = cl_gui_docking_container=>DOCK_AT_LEFT
        side      = gcl_con->dock_at_left
        extension = 3000.

    CREATE OBJECT gcl_grid
      EXPORTING
        i_parent = gcl_con.

    SET HANDLER: lcl_event_handler=>on_double_click FOR gcl_grid,
                 lcl_event_handler=>handle_hotspot_click FOR gcl_grid.


    CALL METHOD gcl_grid->set_table_for_first_display
      EXPORTING
        is_variant      = gs_variant
        i_save          = 'A' "A U SPACE
        i_default       = 'X'
        is_layout       = gs_layout
      CHANGING
        it_outtab       = gt_data
        it_fieldcatalog = gt_fcat.

  ELSE.

  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0101 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0101 OUTPUT.
  SET PF-STATUS 'S101'.
  SET TITLEBAR 'T101'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module SET_FCAT_LAYOUT_0101 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE set_fcat_layout_0101 OUTPUT.

  gs_layout_pop-zebra = 'X'.
  gs_layout_pop-SEL_MODe = 'D'.
  gs_layout_pop-no_toolbar = 'X'.

  "KEY FIELD REF_T REFT_F QUNT

  PERFORM set_fcat_pop USING :
    'X' 'CARRID' 'SBOOK' 'CARRID' ' ',
    'X' 'CONNID' 'SBOOK' 'CONNID' ' ',
    'X' 'FLDATE' 'SBOOK' 'FLDATE' ' ',
    'X' 'BOOKID' 'SBOOK' 'BOOKID' ' ',
    ' ' 'CUSTOMID' 'SBOOK' 'CUSTOMID' ' ',
    ' ' 'CUSTTYPE' 'SBOOK' 'CUSTTYPE' ' ',
    ' ' 'LUGGWEIGHT' 'SBOOK' 'LUGGWEIGHT' 'WUNIT',
    ' ' 'WUNIT' 'SBOOK' 'WUNIT' ' '.


ENDMODULE.
*&---------------------------------------------------------------------*
*& Module DISPLAY_SCREEN_0101 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE display_screen_0101 OUTPUT.

  IF gcl_con_pop IS INITIAL.
    CREATE OBJECT gcl_con_pop
      EXPORTING
        container_name = 'GCL_CON_POP'.

    CREATE OBJECT gcl_grid_pop
      EXPORTING
        i_parent = gcl_con_pop.

    CALL METHOD gcl_grid_pop->set_table_for_first_display
      EXPORTING
        i_save          = 'A'
        i_default       = 'X'
        is_layout       = gs_layout_pop
      CHANGING
        it_outtab       = gt_sbook
        it_fieldcatalog = gt_fcat_pop.

  ENDIF.


ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0102 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0102 OUTPUT.
SET PF-STATUS 'S102'.
 SET TITLEBAR 'T102'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module SET_FCAT_LAYOUT_0102 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE set_fcat_layout_0102 OUTPUT.

PERFORM set_fcat_layout_0102.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module DISPLAY_SCREEN_0102 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE display_screen_0102 OUTPUT.
PERFORM dsiplay_screen_0102.
ENDMODULE.
