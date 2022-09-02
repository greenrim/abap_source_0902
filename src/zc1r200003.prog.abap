*&---------------------------------------------------------------------*
*& Report ZC1R200003
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zc1r200003_top                          .    " Global Data

INCLUDE zc1r200003_s01                          .  " Selection Screen
INCLUDE zc1r200003_c01                          .  " Local Class
INCLUDE zc1r200003_o01                          .  " PBO-Modules
INCLUDE zc1r200003_i01                          .  " PAI-Modules
INCLUDE zc1r200003_f01                          .  " FORM-Routines

START-OF-SELECTION.
  PERFORM get_flight_list.
  PERFORM set_carrname.

  CALL SCREEN '0100'.
