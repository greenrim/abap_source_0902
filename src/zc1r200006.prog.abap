*&---------------------------------------------------------------------*
*& Report ZC1R200002
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zc1r200006_top.
*INCLUDE zc1r200002_top                          .    " Global Data

INCLUDE zc1r200006_s01.
*INCLUDE zc1r200002_s01                          .  " Selection Screen
INCLUDE zc1r200006_c01.
*INCLUDE zc1r200002_c01                          .  " Local_Class
INCLUDE zc1r200006_o01.
*INCLUDE zc1r200002_o01                          .  " PBO-Modules
INCLUDE zc1r200006_i01.
*INCLUDE zc1r200002_i01                          .  " PAI-Modules
INCLUDE zc1r200006_f01.
*INCLUDE zc1r200002_f01                          .  " FORM-Routines

START-OF-SELECTION.
  PERFORM get_bom_data.
  PERFORM get_Material_detail.

  CALL SCREEN 100.
