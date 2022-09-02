*&---------------------------------------------------------------------*
*& Include          MZSA2050_I01
*&---------------------------------------------------------------------*
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
      CASE gv_gr1.
        WHEN 1.
          PERFORM get_carrname USING zssa2090-carrid
                               CHANGING zssa2090-carrid
                                        zssa2090-carrname.
        WHEN 0.
          PERFORM get_vendname USING zssa2090-lifnr
                             CHANGING zssa2090.

      ENDCASE.
    WHEN 'SEARCH'.
      CASE gv_gr1.
        WHEN 1.
          PERFORM get_carrname USING zssa2090-carrid
                               CHANGING zssa2091-carrid
                                        zssa2091-carrname.

          PERFORM get_info USING zssa2090-mealnumber
                           CHANGING zssa2091 zssa2092.


*          PERFORM clear_cond CHANGING zssa2090-lifnr zssa2090-name1.

        WHEN 0.
          PERFORM get_info_vender USING zssa2090-lifnr
                           CHANGING zssa2091 zssa2092.


*          PERFORM clear_aircond CHANGING zssa2090-carrid zssa2090-carrname zssa2090-mealnumber.

      ENDCASE.
    WHEN 'TAB1' OR 'TAB2'.
      ts_info-activetab = ok_code.

  ENDCASE.
ENDMODULE.
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
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHECK_CARRID  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_carrid INPUT.
  CASE zssa2090-carrid.
    WHEN 'AB'.
      CLEAR zssa2090-mealnumber.
      MESSAGE e016(pn) WITH 'Please recheck the Airline Code.'.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  BUTTON_COND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE button_cond_0100 INPUT.
  IF gv_cond1 = 'X'.
    gv_gr1 = 1.
    gv_gr2 = 0.
  ELSEIF gv_cond2 = 'X'.
    gv_gr1 = 0.
    gv_gr2 = 1.
  ENDIF.

*  IF gv_cond1 = 'X'.
*    gv_rs = 'AIR'.
*  ELSEIF gv_cond2 = 'X'.
*    gv_rs = 'VEND'.
*  ENDIF.
*
*  CASE gv_rs.
*    WHEN 'AIR'.
*
*    WHEN 'VEND'.
*      gv_gr1 = 0.
*      gv_gr2 = 1.
*  ENDCASE.
ENDMODULE.
