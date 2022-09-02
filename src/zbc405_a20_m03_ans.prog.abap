*&---------------------------------------------------------------------*
*& Report ZBC405_A20_M01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zbc405_a20_m03_ans_top.
*INCLUDE zbc405_a20_m03_top.                          " Global Data

* INCLUDE ZBC405_A20_M01_O01                      .  " PBO-Modules
* INCLUDE ZBC405_A20_M01_I01                      .  " PAI-Modules
* INCLUDE ZBC405_A20_M01_F01                      .  " FORM-Routines

"힌트 ! sy-datum+0(4) = 2022
INITIALIZATION.
  tab1 = 'Airline'.
  tab2 = 'Connection'.
  tab3 = 'Flight Date'.

  ts_con-activetab = 'CON'.
  ts_con-dynnr = '1200'.

  gv_chg = '0'.
  gv_text = 'Detail'.

  so_fld-low+0(4) = sy-datum+0(4) - 2.
  so_fld-low+4 = sy-datum+4.
*  so_fld-high = sy-datum+0(4) && '1231'.
  so_fld-high+0(4) = sy-datum+0(4) .
  so_fld-high+4 = '1231'.
  APPEND so_fld TO so_fld[].

AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    IF screen-group1 = 'GR1'.
      screen-invisible = gv_chg.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.

  CASE gv_chg.
    WHEN '0'.
      gv_text = 'Detail'.
    WHEN '1'.
      gv_text = 'Hide'.
  ENDCASE.


AT SELECTION-SCREEN.
  CHECK sy-dynnr = '1000'.
  CASE sscrfields-ucomm .
    WHEN 'ON'.
      CASE gv_chg.
        WHEN '0'.
          gv_chg = '1'.
        WHEN OTHERS.
          gv_chg = '0'.
      ENDCASE.
  ENDCASE.


START-OF-SELECTION.

  SELECT *
    FROM sflight
    INTO CORRESPONDING FIELDS OF TABLE gt_sfli
    WHERE carrid = pa_car
    AND connid = pa_con
    AND fldate IN so_fld.

  cl_demo_output=>display_data( gt_sfli ).
