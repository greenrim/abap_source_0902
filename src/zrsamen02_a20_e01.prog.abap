*&---------------------------------------------------------------------*
*& Include          ZRSAMEN02_A20_E01
*&---------------------------------------------------------------------*

INITIALIZATION.
  gs_variant-report = sy-cprog.
  gs_variant-report  = sy-repid.

  pa_ven = 'CUS-00'.
  gv_id  = 'ZTVERSA20-VERSION'.

AT SELECTION-SCREEN OUTPUT.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR pa_ven.
  PERFORM search_help_pa_ven.

START-OF-SELECTION.
  PERFORM get_Data.

  CALL SCREEN 100.
*&---------------------------------------------------------------------*
*& Form data_save
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM data_save .

  DATA : ls_data_mod TYPE ztvermata20,
         lt_data_mod LIKE TABLE OF ls_data_mod.

  "update
  LOOP AT gt_data INTO gs_data WHERE modified = 'X'.
    ls_data_mod-vendor = gs_data-vendor.
    ls_data_mod-version = gs_data-version.
    ls_data_mod-pcode   = gs_data-pcode.
    ls_data_mod-order_unit = gs_data-order_unit.

    APPEND ls_data_mod TO lt_data_mod.
  ENDLOOP.

  IF lt_data_mod IS NOT INITIAL.
    MODIFY ztvermata20 FROM TABLE lt_data_mod.
  ENDIF.

  IF gt_data_del IS NOT INITIAL.
    DELETE  ztvermata20 FROM TABLE gt_data_del.
    CLEAR gt_data_del.
  ENDIF.

ENDFORM.
