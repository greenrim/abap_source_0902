*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_EXAM01_I01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK' OR 'CANC'.
      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.
      PERFORM data_save.
      LEAVE PROGRAM.

    WHEN 'SAVE'.
      PERFORM data_save.

    WHEN OTHERS.

  ENDCASE.

ENDMODULE.
