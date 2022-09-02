*&---------------------------------------------------------------------*
*& Include          ZC1R200007_O01
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

  PERFORM set_fcat_layout.

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
        repid     = sy-repid "sy-cprog
        dynnr     = sy-dynnr
        side      = gcl_con->dock_at_left
        extension = 3000.

    CREATE OBJECT gcl_alv
      EXPORTING
        i_parent = gcl_con.

    gs_variant-report = sy-repid.
    CALL METHOD gcl_alv->set_table_for_first_display
      EXPORTING
*       i_structure_name              =
        is_variant      = gs_variant
        i_save          = 'A'
        i_default       = 'X'
        is_layout       = gs_layout
*       it_toolbar_excluding          =
      CHANGING
        it_outtab       = gt_data
        it_fieldcatalog = gt_fcat.

    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.
  ENDIF.
ENDMODULE.
