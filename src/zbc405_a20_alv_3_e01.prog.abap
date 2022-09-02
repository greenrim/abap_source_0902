*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_ALV_3_E01
*&---------------------------------------------------------------------*

INITIALIZATION.

  gs_variant-report = sy-cprog. "sy-repid 도 가능


AT SELECTION-SCREEN ON VALUE-REQUEST FOR pa_var.
  CALL FUNCTION 'LVC_VARIANT_SAVE_LOAD'
    EXPORTING
      i_save_load = 'F'  "S: SAVE / L: LOAD / F:F4
    CHANGING
      cs_variant  = gs_variant.

  IF sy-subrc <> 0.
* Implement suitable error handling here
  ELSE.
    pa_var = gs_variant-variant.
  ENDIF.

*at SELECTION-SCREEN on HELP-REQUEST FOR


START-OF-SELECTION.

  PERFORM get_data.

  CALL SCREEN 100.
