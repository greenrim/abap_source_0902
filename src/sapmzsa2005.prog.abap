*&---------------------------------------------------------------------*
*& Module Pool      SAPMZSA2005
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE mzsa2005_top                            .    " Global Data

INCLUDE mzsa2005_o01                            .  " PBO-Modules
INCLUDE mzsa2005_i01                            .  " PAI-Modules
INCLUDE mzsa2005_f01                            .  " FORM-Routines

LOAD-OF-PROGRAM.
  PERFORM set_default CHANGING zssa0073.
