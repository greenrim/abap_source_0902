*&---------------------------------------------------------------------*
*& Include          MZSA2007_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.
      SET SCREEN 0.
      LEAVE SCREEN.
    WHEN 'ENTER'.
*      MESSAGE S016(pn) with 'Test'.
*      MESSAGE i016(pn) with 'Test'.
      MESSAGE i016(pn) WITH 'Test'.


  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  CASE sy-ucomm.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'CANC'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHECK_AIRLINE  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_airline INPUT.
  IF gv_carrid = 'JL'.
*    MESSAGE e016(pn) WITH 'CHECK'.
    MESSAGE w016(pn) WITH 'CHECK'.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHECK_TWO  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_two INPUT.
  IF zssa2074-carrid = 'JL'.
    MESSAGE e016(pn) WITH 'Check'.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHECK_A  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_a INPUT.
  IF zssa2074-carrid IS INITIAL.
    MESSAGE e016(pn) WITH 'Check initial value'.
  ENDIF.

  IF zssa2074-carrid = 'JL'.
    MESSAGE e016(pn) WITH 'Check JL'.
  ENDIF.
ENDMODULE.
