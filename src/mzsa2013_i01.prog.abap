*&---------------------------------------------------------------------*
*& Include          MZSA2013_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  CASE ok_code.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'CANC'.
      SET SCREEN 0.
      LEAVE SCREEN.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'ENTER'.
      PERFORM get_ename USING zssa2076-pernr
                        CHANGING zssa2076.

    WHEN 'SEARCH'.
      PERFORM get_info USING zssa2076-pernr
                       CHANGING zssa2075.
    WHEN 'TAB1' OR 'TAB2'.
      ts_info-activetab = ok_code.

  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHECK_EMP  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_emp INPUT.
  IF zssa2075-pernr+4(2) = '01'.
    MESSAGE e016(pn) WITH 'Please recheck the Personal Number'.
  ENDIF.
ENDMODULE.
