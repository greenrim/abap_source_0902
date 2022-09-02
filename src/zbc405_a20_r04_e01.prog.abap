*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_R04_E01
*&---------------------------------------------------------------------*

INITIALIZATION.
  gs_variant-report = sy-cprog.  "=sy-repid.

AT SELECTION-SCREEN OUTPUT.

AT SELECTION-SCREEN.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR pa_var.
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
perform get_data.

call screen 100.
