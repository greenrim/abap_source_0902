*&---------------------------------------------------------------------*
*& Include          ZC1R200002_C01
*&---------------------------------------------------------------------*

CLASS lcl_event_handler DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS :
      handle_double_click FOR EVENT double_click OF cl_gui_alv_grid
        IMPORTING
          e_row
          e_column,
      handle_hotspot FOR EVENT hotspot_click OF cl_gui_alv_grid
        IMPORTING
          e_row_id
          e_column_id.

ENDCLASS.
*&---------------------------------------------------------------------*
*& Class (Implementation) lcl_event_handler
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
CLASS lcl_event_handler IMPLEMENTATION.
  METHOD handle_double_click.

    PERFORM handle_double_click USING e_row e_column.

  ENDMETHOD.

  METHOD  handle_hotspot.

    PERFORM handle_hotspot USING e_row_id e_column_id.

  ENDMETHOD.

ENDCLASS.
