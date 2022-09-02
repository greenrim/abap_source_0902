*&---------------------------------------------------------------------*
*& Report ZRSA20_41
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa20_41_top                           .    " Global Data

* INCLUDE ZRSA20_41_O01                           .  " PBO-Modules
* INCLUDE ZRSA20_41_I01                           .  " PAI-Modules
INCLUDE zrsa20_41_f01                           .  " FORM-Routines

INITIALIZATION.
  pa_pernr = '20220001'.

AT SELECTION-SCREEN.

START-OF-SELECTION.

  SELECT *
    FROM zvsa2010
    INTO CORRESPONDING FIELDS OF TABLE gt_pro
    WHERE pernr = pa_pernr.

  SELECT SINGLE depid
    FROM ztsa2001
    INTO gv_dep
    WHERE pernr = pa_pernr.

  SELECT SINGLE dtext
  FROM ztsa2002_t
  INTO gv_dtext
  WHERE depid = gv_dep.

  SELECT proid ptext
  FROM ztsa20pro_t
  INTO CORRESPONDING FIELDS OF TABLE gt_ptext.

  SELECT proid ptype
   FROM ztsa20pro
   INTO CORRESPONDING FIELDS OF TABLE gt_pdetail.

  LOOP AT gt_pro INTO gs_pro.
    gs_pro-depid = gv_dep.
    gs_pro-dtext = gv_dtext.

    READ TABLE gt_pdetail INTO gs_pdetail WITH KEY proid = gs_pro-proid.
    gs_pro-ptype = gs_pdetail-ptype.

    READ TABLE gt_ptext INTO gs_ptext WITH KEY proid = gs_pro-proid.
    gs_pro-ptext = gs_ptext-ptext.

    CASE gs_pro-ptype.
      WHEN 'C01'.
        gs_pro-ttext = '스낵'.
      WHEN 'C02'.
        gs_pro-ttext = '커피'.
      WHEN 'C03'.
        gs_pro-ttext = '식품'.
      WHEN OTHERS.
        gs_pro-ttext = '미정'.
    ENDCASE.
    MODIFY gt_pro FROM gs_pro.
  ENDLOOP.

  cl_demo_output=>display_data( gt_pro ).
