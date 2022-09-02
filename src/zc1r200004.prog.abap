*&---------------------------------------------------------------------*
*& Report ZC1R200004
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zc1r200004_top                          .    " Global Data

INCLUDE zc1r200004_s01                          .  " SELECTION SCREEN
INCLUDE zc1r200004_c01                          .  " LOCAL CLASS
INCLUDE zc1r200004_o01                          .  " PBO-Modules
INCLUDE zc1r200004_i01                          .  " PAI-Modules
INCLUDE zc1r200004_f01                          .  " FORM-Routines

START-OF-SELECTION.
  PERFORM get_flight_data.

  "list-processing
*  call screen '0100'.

  CALL SCREEN '0100'.
