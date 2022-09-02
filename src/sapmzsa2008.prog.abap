*&---------------------------------------------------------------------*
*& Module Pool      SAPMZSA2008
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE mzsa2008_top                            .    " Global Data

INCLUDE mzsa2008_o01                            .  " PBO-Modules
INCLUDE mzsa2008_i01                            .  " PAI-Modules
INCLUDE mzsa2008_f01                            .  " FORM-Routines

LOAD-OF-PROGRAM.
perform get_default changing zssa2076.
