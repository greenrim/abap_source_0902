*&---------------------------------------------------------------------*
*& Report ZSA201009
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zsa201009_top                           .    " Global Data

INCLUDE zsa201009_s01                           .  " Selection Screen
INCLUDE zsa201009_c01                           .  " Local Class
INCLUDE zsa201009_o01                           .  " PBO-Modules
INCLUDE zsa201009_i01                           .  " PAI-Modules
INCLUDE zsa201009_f01                           .  " FORM-Routines

INITIALIZATION.
  gs_variant-report = sy-repid.

AT SELECTION-SCREEN OUTPUT.

AT SELECTION-SCREEN.

START-OF-SELECTION.
  PERFORM get_data.

  CALL SCREEN 100.
