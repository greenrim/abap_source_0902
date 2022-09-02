*&---------------------------------------------------------------------*
*& Report ZBC405_A20_M04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zbc405_a20_m04_top                      .    " Global Data

* INCLUDE ZBC405_A20_M04_O01                      .  " PBO-Modules
* INCLUDE ZBC405_A20_M04_I01                      .  " PAI-Modules
* INCLUDE ZBC405_A20_M04_F01                      .  " FORM-Routines

INITIALIZATION. "초기값 설정
  gv_text = '버튼'.
  gv_chg = 1.

  "tab 초기설정
  tab1 = 'Car Info'.
  tab2 = 'fldate'.
  ts_info-activetab = 'FLD'.
  ts_info-dynnr = '1200'.

  "flda 초기값 설정
*  20200808
  so_fld-low+0(4) = sy-datum+0(4) - 2.  "'2020'.
  so_fld-low+4 = sy-datum+4.
*  so_fld-high+0(4) = sy-datum+0(4).
*  so_fld-high+4 = '1231'.
  so_fld-high = sy-datum+0(4) && '1231'.
*  append so_fld to so_fld[].
*  append so_fld to so_fld.
  APPEND so_fld.


AT SELECTION-SCREEN OUTPUT.  "PBO
  LOOP AT SCREEN.
    CASE screen-group1.
      WHEN 'GR1'.
        screen-active = gv_chg.  "0 , 1
        MODIFY SCREEN.
    ENDCASE.
  ENDLOOP.

  "PAI

AT SELECTION-SCREEN.
  CHECK sy-dynnr = '1000'.
  CASE sscrfields-ucomm.
    WHEN 'ON'.
*      gv_chg = 0.
      CASE gv_chg. "1
        WHEN '1'.
          gv_chg = 0.
        WHEN '0'.
          gv_chg = 1.
      ENDCASE.
  ENDCASE.
