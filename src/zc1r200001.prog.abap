*&---------------------------------------------------------------------*
*& Report ZC1R200001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zc1r200001_top                          .    " Global Data

INCLUDE zc1r200001_s01                          .  " Selection Screen
INCLUDE zc1r200001_o01                          .  " PBO-Modules
INCLUDE zc1r200001_i01                          .  " PAI-Modules
INCLUDE zc1r200001_f01                          .  " FORM-Routines

INITIALIZATION.
  PERFORM init_param.

START-OF-SELECTION.
  perform get_data.

  "IF GT_DATA IS NOT INITIAL.
  CALL SCREEN '0100'.
