*&---------------------------------------------------------------------*
*& Include          MZSA2001_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN 'EXIT'.                "대소문자 구분함
      LEAVE PROGRAM.
    WHEN 'BACK' OR 'CANC'.
*      LEAVE TO SCREEN 0.
      SET SCREEN 0.
      LEAVE SCREEN.
    WHEN 'SEARCH'.
      "Get Data
      PERFORM get_data USING gv_pno
                       CHANGING zssa2031.

*      MESSAGE s000(zmcsa20) WITH sy-ucomm.

  ENDCASE.
ENDMODULE.
