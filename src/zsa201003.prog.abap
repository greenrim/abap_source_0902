*&---------------------------------------------------------------------*
*& Report ZSA201003
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zsa201003_top                           .    " Global Data

* INCLUDE ZSA201003_O01                           .  " PBO-Modules
* INCLUDE ZSA201003_I01                           .  " PAI-Modules
* INCLUDE ZSA201003_F01                           .  " FORM-Routines

INITIALIZATION.

AT SELECTION-SCREEN OUTPUT.

AT SELECTION-SCREEN.

START-OF-SELECTION.

  CASE 'X'.
    WHEN pa_ta.
      gv_buspartyp = 'TA'.

    WHEN pa_fc.
      gv_buspartyp = 'FC'.
  ENDCASE.

  SELECT mandant buspartnum contact contphono buspatyp
    FROM sbuspart
    INTO CORRESPONDING FIELDS OF TABLE gt_sbuspart
    WHERE buspartnum =  pa_bus
    AND   contact    IN so_con
    AND   buspatyp   =  gv_buspartyp.

  cl_demo_output=>display_data( gt_sbuspart ).
