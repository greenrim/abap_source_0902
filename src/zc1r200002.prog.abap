*&---------------------------------------------------------------------*
*& Report ZC1R200002
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zc1r200002_top                          .    " Global Data

INCLUDE zc1r200002_s01                          .  " Selection Screen
INCLUDE zc1r200002_c01                          .  " Local_Class
INCLUDE zc1r200002_o01                          .  " PBO-Modules
INCLUDE zc1r200002_i01                          .  " PAI-Modules
INCLUDE zc1r200002_f01                          .  " FORM-Routines

START-OF-SELECTION.
  PERFORM get_bom_data.
  CALL SCREEN 100.
