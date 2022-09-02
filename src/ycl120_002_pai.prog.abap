*&---------------------------------------------------------------------*
*& Include          YCL120_002_PAI
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  EXIT_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit_0100 INPUT.

  save_ok = ok_code.
  CLEAR ok_code.

  CASE save_ok.
    WHEN'EXIT'.
      LEAVE PROGRAM.
    WHEN 'CANC'.
      LEAVE TO SCREEN 0.
    WHEN OTHERS.
      ok_code = save_ok.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  save_ok = ok_code.
  CLEAR ok_code.

  CASE save_ok.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.

    WHEN 'SEARCH'.
      PERFORM select_data.

    WHEN OTHERS.
      ok_code = save_ok.
*      CLEAR save_ok.
  ENDCASE.
ENDMODULE.
