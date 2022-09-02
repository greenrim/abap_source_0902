*&---------------------------------------------------------------------*
*& Report ZBC405_A20_R02_L
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zbc405_a20_r02_l_top                    .    " Global Data

INCLUDE zbc405_a20_r02_L_class.
INCLUDE zbc405_a20_r02_l_o01                    .  " PBO-Modules
INCLUDE zbc405_a20_r02_l_i01                    .  " PAI-Modules
INCLUDE zbc405_a20_r02_l_f01                    .  " FORM-Routines



INITIALIZATION.
  gs_variant-report = sy-cprog.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR pa_var.
  CALL FUNCTION 'LVC_VARIANT_SAVE_LOAD'
    EXPORTING
      i_save_load     = 'F'
    CHANGING
      cs_variant      = gs_variant
    EXCEPTIONS
      not_found       = 1
      wrong_input     = 2
      fc_not_complete = 3
      OTHERS          = 4.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ELSE.
    pa_var = gs_variant.
  ENDIF.


START-OF-SELECTION.
  "layout setting
  PERFORM set_layout.

  "SETDATA
  SELECT *
    FROM sflight
    INTO CORRESPONDING FIELDS OF TABLE gt_sflight
    WHERE carrid IN so_car
    AND connid IN so_con
    AND fldate IN so_fld.

  SELECT carrid carrname
    FROM scarr
    INTO CORRESPONDING FIELDS OF TABLE gt_scarr
    WHERE carrid IN so_car.

  LOOP AT gt_sflight INTO gs_sflight.
    READ TABLE gt_scarr INTO gs_scarr WITH KEY carrid = gs_sflight-carrid.
    gs_sflight-carrname = gs_scarr-carrname.
    MODIFY gt_sflight FROM gs_sflight.
  ENDLOOP.

  LOOP AT gt_sflight INTO gs_sflight.
    IF gs_sflight-seatsocc < 10.
      gs_sflight-light = '1'.
    ELSEIF gs_sflight-seatsocc < 100.
      gs_sflight-light = '2'.
    ELSE.
      gs_sflight-light = '3'.
    ENDIF.


    IF gs_sflight-fldate+4(2) = sy-datum+4(2).
      gs_sflight-row_color = 'C510'.
    ENDIF.

    IF gs_sflight-connid = '64'.
      gs_color-fname = 'CONNID'. "색상 지정할 FIELD명
      gs_color-color-col = col_group.
      gs_color-color-int = '1'.
      gs_color-color-inv = '0'.
      APPEND gs_color TO gs_sflight-gt_color.
    ENDIF.

    MODIFY gt_sflight FROM gs_sflight.
  ENDLOOP.


  "set_fieldcatalog
  gs_fcat-fieldname = 'CARRNAME'.
  gs_fcat-coltext = 'Name'.
  gs_fcat-col_pos = '3'.
  APPEND gs_fcat TO gt_fcat.

  LOOP AT gt_fcat INTO gs_fcat.
    CASE gs_fcat-fieldname.
      WHEN 'CARRID' OR 'CARRNAME' OR 'CONNID' OR 'FLDATE'.
        gs_fcat-fix_column = 'X'.
    ENDCASE.
    MODIFY gt_fcat FROM gs_fcat.
  ENDLOOP.

*   SELECT *
*    FROM sflight
*    INTO CORRESPONDING FIELDS OF TABLE gt_sflight
*    WHERE carrid IN so_car
*    AND connid IN so_con
*    AND fldate IN so_fld.


  "CALL SCREEN
  CALL SCREEN 100.
