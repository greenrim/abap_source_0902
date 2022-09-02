*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_EXAM01_E01
*&---------------------------------------------------------------------*

INITIALIZATION.
  gs_variant-report = sy-cprog.

  DATA: l_user_specific.

*  CALL FUNCTION 'REUSE_ALV_VARIANT_DEFAULT_GET'
*    EXPORTING
*      i_save     = 'U'
*    CHANGING
*      cs_variant = gs_variant
**                  EXCEPTIONS
**     WRONG_INPUT         = 1
**     NOT_FOUND  = 2
**     PROGRAM_ERROR       = 3
**     OTHERS     = 4
*    .
*  IF sy-subrc <> 0.
** Implement suitable error handling here
*  ENDIF.



  CALL FUNCTION 'LT_VARIANT_DESCRIPTION_LOAD'
    EXPORTING
      i_dialog        = 'N'      "Never
      i_user_specific = ''
      i_default       = 'X'
    CHANGING
      cs_variant      = gS_VARIANT
    EXCEPTIONS
      wrong_input     = 1
      not_found       = 2
      OTHERS          = 3.

  IF gs_variant IS NOT INITIAL.
    pa_var = gs_variant-variant.
  ENDIF.

AT SELECTION-SCREEN OUTPUT.

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

AT SELECTION-SCREEN.

START-OF-SELECTION.
  PERFORM get_data.
  CASE pa_sel.
    WHEN 'X'.
      CALL SCREEN 200.
    WHEN OTHERS.
      CALL SCREEN 100.
  ENDCASE.
