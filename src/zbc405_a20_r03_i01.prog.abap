*&---------------------------------------------------------------------*
*& Include          ZRSAMAR02I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE ok_code.
    WHEN 'BACK' OR 'CANC' OR 'EXIT'.
      LEAVE TO SCREEN 0.
    WHEN 'DOWN'.
      PERFORM Down.


  ENDCASE.
ENDMODULE.
