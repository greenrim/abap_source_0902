*&---------------------------------------------------------------------*
*& Include          ZC1R200004_C01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Class lcl_evnet_handler
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
CLASS lcl_event_handler DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-METHODS :
      on_double_click FOR EVENT double_click OF cl_gui_alv_grid
        IMPORTING
          e_row
          e_column,
      handle_hotspot_click for EVENT hotspot_click of cl_gui_alv_grid
         IMPORTING
           e_row_id
           e_column_id.
ENDCLASS.
*&---------------------------------------------------------------------*
*& Class (Implementation) lcl_evnet_handler
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
CLASS lcl_event_handler IMPLEMENTATION.
  METHOD on_double_click.

  perform on_double_click using e_row e_column.

  ENDMETHOD.
 METHOD handle_hotspot_click.

    PERFORM handle_hotspot_click USING e_row_id e_column_id.

  ENDMETHOD.
ENDCLASS.
