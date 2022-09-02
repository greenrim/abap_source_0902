*&---------------------------------------------------------------------*
*& Include          MZSA2002_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100' WITH sy-datum.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module SET_DEFAULT OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE set_default OUTPUT.
  IF zssa2060 IS INITIAL.
    zssa2060-carrid = 'AA'.
    zssa2060-connid = '0017'.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module MODIFY_SCREEN_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE modify_screen_0100 OUTPUT.

  LOOP AT SCREEN.
    CASE screen-group1.
      WHEN 'GR1'.
        screen-active = 1.
    ENDCASE.
    MODIFY SCREEN.

  ENDLOOP.


*  LOOP AT SCREEN. "screen은 header line이 있는 internal table
*    CASE screen-name.
*      WHEN 'ZSSA2060-CARRID'.
*        IF sy-uname <> 'KD-A-20'.
**          screen-input = 0.
*          screen-active = 0. "화면에 보이지 않음
*        ELSE.
**          screen-input = 1.
*          screen-active = 1.
*        ENDIF.
*    ENDCASE.
*    MODIFY SCREEN.
*    CLEAR screen.
*  ENDLOOP.

ENDMODULE.
