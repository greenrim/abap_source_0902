*&---------------------------------------------------------------------*
*& Include          ZSA2010_I01
*&---------------------------------------------------------------------*
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
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'ENTER'.

    WHEN 'SEARCH'.

      "Get Connection Info
      PERFORM get_conn_info USING zssa2080-carrid zssa2080-connid
                            CHANGING zssa2082
                                     gv_subrc.
      IF gv_subrc <> 0.
        MESSAGE i016(pn) WITH 'Data is not found'.
        RETURN.                                       "module-endmodule을 빠져나감
      ENDIF.
    WHEN 'TAB1' OR 'TAB2'.
      ts_info-activetab = ok_code.

  ENDCASE.


ENDMODULE.
