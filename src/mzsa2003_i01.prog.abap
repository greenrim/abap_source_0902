*&---------------------------------------------------------------------*
*& Include          MZSA2003_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'BACK'.
      SET SCREEN 0.
      LEAVE SCREEN.
    WHEN 'CANC'.
      LEAVE TO SCREEN 0.
    WHEN 'SEARCH'.
      SET SCREEN 200.
      LEAVE SCREEN.
*
*      = LEAVE TO SCREEN 200.
      MESSAGE i000(zmsca20) WITH 'SET'.

*      CALL SCREEN 200.
*      MESSAGE i000(zmsca20) WITH 'CALL'.
*      PERFORM get_airline_name USING gv_carrid
*                           CHANGING gv_carrname.

*      PERFORM get_airline_name USING gv_carrid
*                               CHANGING gv_carrname.
*      SET SCREEN 200.
*      LEAVE SCREEN.

  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.


      LEAVE TO SCREEN 0.

*      CALL SCREEN 100.
**      SET SCREEN 100.
**      MESSAGE i000(zmcsa20) WITH 'BACK'.
**      LEAVE SCREEN.
*
*      MESSAGE i000(zmcsa20) WITH 'BACK'.
*      LEAVE TO SCREEN 100.

  ENDCASE.
ENDMODULE.
