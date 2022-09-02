*&---------------------------------------------------------------------*
*& Report ZSA201010
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zsa201010_top                           .    " Global Data

INCLUDE zsa201010_s01                           .  " Selection screen
INCLUDE zsa201010_c01                           .  " Local Class
INCLUDE zsa201010_o01                           .  " PBO-Modules
INCLUDE zsa201010_i01                           .  " PAI-Modules
INCLUDE zsa201010_f01                           .  " FORM-Routines

INITIALIZATION.

START-OF-SELECTION.
  PERFORM get_employee_data.
  PERFORM SET_STYLE.

  CALL SCREEN '0100'.
