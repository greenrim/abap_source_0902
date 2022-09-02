*&---------------------------------------------------------------------*
*& Include          MZSA2008_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'ENTER'.
*      MESSAGE i016(pn) WITH sy-ucomm.
      PERFORM get_ename USING zssa2076-pernr
                        CHANGING zssa2076.
      PERFORM get_info USING zssa2076-pernr zssa2075-depid zssa2075-gender
                       CHANGING zssa2075.

    WHEN 'SEARCH'.
      PERFORM get_info USING zssa2076-pernr zssa2075-depid zssa2075-gender
                       CHANGING zssa2075.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  CASE sy-ucomm.
    WHEN 'CANC'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHECK_PERNR  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_pernr INPUT.
  IF zssa2076-pernr+4(2) = '00'.
    MESSAGE e016(pn) WITH 'Please recheck the PERNR.'.
  ENDIF.
ENDMODULE.
