*&---------------------------------------------------------------------*
*& Include          ZRSAMAR02C01
*&---------------------------------------------------------------------*

CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      on_toolbar_high FOR EVENT toolbar
        OF cl_gui_alv_grid
        IMPORTING e_object.

ENDCLASS.

CLASS lcl_handler IMPLEMENTATION.
  METHOD on_toolbar_high.
    DATA : ls_button TYPE stb_button.
    ls_button-function = 'SELECT'.
    ls_button-butn_type = '0'.
    ls_button-text = 'SELECT ALL'.
    APPEND ls_button TO e_object->mt_toolbar. "mt_toolbar는 테이블

    CLEAR ls_button.
    ls_button-function = 'DESELECT'.
    ls_button-butn_type = '0'.
    ls_button-text = 'DESELECT ALL'.
    APPEND ls_button TO e_object->mt_toolbar. "mt_toolbar는 테이블

  ENDMETHOD.
ENDCLASS.
