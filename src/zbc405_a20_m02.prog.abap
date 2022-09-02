*&---------------------------------------------------------------------*
*& Report ZBC405_A20_R02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zbc405_a20_m02_top.
*INCLUDE zbc405_a20_r02_top                      .    " Global Data

INCLUDE zbc405_a20_m02_o01.
*INCLUDE zbc405_a20_r02_o01                      .  " PBO-Modules
INCLUDE zbc405_a20_m02_i01.
*INCLUDE zbc405_a20_r02_i01                      .  " PAI-Modules
INCLUDE zbc405_a20_m02_f01.
*INCLUDE zbc405_a20_r02_f01                      .  " FORM-Routines

INITIALIZATION.
  so_fld-low = sy-datum.
  so_fld-high+0(4) = sy-datum+0(4).
  so_fld-high+4 = '1231'.
  so_fld-sign = 'I'.
  so_fld-option = 'BT'.

  APPEND so_fld TO so_fld[].

"저장한 LAYOUT을 가져오기
AT SELECTION-SCREEN ON VALUE-REQUEST FOR pa_var.
  gs_variant-report = sy-cprog.

  CALL FUNCTION 'LVC_VARIANT_SAVE_LOAD'
    EXPORTING
      i_save_load = 'F'
    CHANGING
      cs_variant  = gs_variant.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ELSE.
    pa_var = gs_variant-variant.
  ENDIF.


START-OF-SELECTION.

  "SETDATA
  SELECT *
    FROM sflight
    INTO CORRESPONDING FIELDS OF TABLE gt_sflight
    WHERE carrid IN so_car
    AND connid IN so_con
    AND fldate IN so_fld.

  gs_variant-report = sy-cprog.
  gv_save = ''.



  "CALL SCREEN
  CALL SCREEN 100.
