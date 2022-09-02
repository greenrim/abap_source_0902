*&---------------------------------------------------------------------*
*& Report ZBC405_A20_M01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zbc405_a20_m03_top.                          " Global Data

* INCLUDE ZBC405_A20_M01_O01                      .  " PBO-Modules
* INCLUDE ZBC405_A20_M01_I01                      .  " PAI-Modules
* INCLUDE ZBC405_A20_M01_F01                      .  " FORM-Routines

INITIALIZATION.
  "TAB title
  tab1 = 'Airline'.
  tab2 = 'Connection'.

  gv_chg = '0'.
  gv_text = 'Detail'.

  "Q1-초기값 설정





AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    IF screen-group1 = 'GR1'.
      screen-active = gv_chg.
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

*  LEAVE TO TRANSACTION 'ZBC405_A20_R02' AND SKIP FIRST SCREEN.
*  LEAVE TO TRANSACTION 'ZSA2090'.
*  CALL TRANSACTION 'ZSA2090'.
  SUBMIT zbc405_a20_r02
  WITH so_car-high = 'AA'
  AND RETURN.

  SELECT *
    FROM sflight
    INTO CORRESPONDING FIELDS OF TABLE gt_sfli
    WHERE carrid = pa_car
    AND connid = pa_con.
*    AND fldate IN so_fld.

  cl_demo_output=>display_data( gt_sfli ).
