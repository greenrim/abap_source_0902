*&---------------------------------------------------------------------*
*& Include          MZSA2050_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module SET_SUBSCREEN OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE set_subscreen OUTPUT.
  CASE ts_info-activetab.
    WHEN 'TAB1'.
      gv_dynnr = '0101'.
    WHEN 'TAB2'.
      gv_dynnr = '0102'.
    WHEN OTHERS.
      gv_dynnr = '0101'.
      ts_info-activetab = 'TBA1'.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module MODIFY_SCREEN_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE modify_screen_0100 OUTPUT.

  LOOP AT SCREEN.
*    CASE gv_rs.
*      WHEN 'AIR'.
*        gv_gr1 = 1.
*        gv_gr2 = 0.
*      WHEN 'VEND'.
*        gv_gr1 = 0.
*        gv_gr2 = 1.
*    ENDCASE.

    CASE screen-group1.
      WHEN 'GR1'.
        screen-active = gv_gr1.
      WHEN 'GR2'.
        screen-active = gv_gr2.
*        CLEAR: ZSSA2090-CARRID, ZSSA2090-CARRNAME, ZSSA2090-MEALNUMBER.
    ENDCASE.
    MODIFY SCREEN.
    CLEAR screen.
  ENDLOOP.

ENDMODULE.
