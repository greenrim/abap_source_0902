*&---------------------------------------------------------------------*
*& Include          ZSA201009_C01
*&---------------------------------------------------------------------*

CLASS lcl_event DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS :
    on_double_click    FOR EVENT double_click
    OF cl_gui_alv_grid IMPORTING e_row e_column es_row_no,

    on_HOTSPOT_CLICK   FOR EVENT hotspot_click
    OF cl_gui_alv_grid IMPORTING e_row_id e_column_id es_row_no.

ENDCLASS.



CLASS lcl_event IMPLEMENTATION.
  METHOD on_double_click.

    PERFORM on_double_click USING e_column e_row.

  ENDMETHOD.

  METHOD on_HOTSPOT_CLICK.

    PERFORM on_hotspot_click USING e_row_id e_column_id.

  ENDMETHOD.
ENDCLASS.
