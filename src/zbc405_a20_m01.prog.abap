*&---------------------------------------------------------------------*
*& Report ZBC405_A20_M01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zbc405_a20_m01_top                      .    " Global Data

* INCLUDE ZBC405_A20_M01_O01                      .  " PBO-Modules
* INCLUDE ZBC405_A20_M01_I01                      .  " PAI-Modules
* INCLUDE ZBC405_A20_M01_F01                      .  " FORM-Routines

*SELECT *
*  FROM sflight
*  INTO CORRESPONDING FIELDS OF TABLE gt_sfli
*  WHERE carrid = p_car
*  AND connid = p_con1
*  AND fldate BETWEEN p_fld1 AND p_fld2.

INITIALIZATION.

  tab1 = 'Airline'.
  tab2 = 'Connection'.
  tab3 = 'Flight Date'.

  ts_con-activetab = 'FLD'.
  ts_con-dynnr = '1400'.

  gv_chg = '0'.
  gv_text = 'Detail'.

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
*      CASE gv_chg.
*        WHEN '1'.
*          MESSAGE '1번' TYPE 'I'.
*
*        WHEN '0'.
*          MESSAGE '0번' TYPE 'I'.
*      ENDCASE.
      CASE gv_chg.
        WHEN '0'.
          gv_chg = '1'.
        WHEN OTHERS.
          gv_chg = '0'.
      ENDCASE.
*      IF gv_chg = '0'.
*        gv_chg = '1'.
*      ELSE.
*        gv_chg = '0'.
*
*      ENDIF.

  ENDCASE.


AT SELECTION-SCREEN ON cb_popup.
  CASE 'X'.
    WHEN cb_popup.
      CALL SELECTION-SCREEN 1100 STARTING AT 5 5 ENDING AT 50 10.
      IF sy-subrc <> 0.
        LEAVE TO SCREEN 1000.
      ENDIF.
    WHEN pa_rad1.

  ENDCASE.

START-OF-SELECTION.

  SELECT *
    FROM sflight
    INTO CORRESPONDING FIELDS OF TABLE gt_sfli
    WHERE carrid = p_car
    AND connid = p_con1
    AND fldate IN so_fld.

  cl_demo_output=>display_data( gt_sfli ).
