*&---------------------------------------------------------------------*
*& Report ZC1R200005
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zc1r200005_top                          .    " Global Data

INCLUDE zc1r200005_s01                          .  " Selection Screen
INCLUDE zc1r200005_c01                          .  " Local Class
INCLUDE zc1r200005_o01                          .  " PBO-Modules
INCLUDE zc1r200005_i01                          .  " PAI-Modules
INCLUDE zc1r200005_f01                          .  " FORM-Routines

INITIALIZATION.
  PERFORM init_param.

START-OF-SELECTION.
  PERFORM get_belnr.
  CALL SCREEN 100.
