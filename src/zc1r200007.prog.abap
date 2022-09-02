*&---------------------------------------------------------------------*
*& Report ZC1R200007
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zc1r200007_top                          .    " Global Data

INCLUDE zc1r200007_s01                          .  " Selection Screen
INCLUDE zc1r200007_o01                          .  " PBO-Modules
INCLUDE zc1r200007_i01                          .  " PAI-Modules
INCLUDE zc1r200007_f01                          .  " FORM-Routines

INITIALIZATION.

START-OF-SELECTION.

  PERFORM get_data.

  CALL SCREEN 100.
