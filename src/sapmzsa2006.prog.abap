*&---------------------------------------------------------------------*
*& Module Pool      SAPMZSA2005
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE mzsa2006_top.
*INCLUDE mzsa2005_top                            .    " Global Data

INCLUDE mzsa2006_o01.
*INCLUDE mzsa2005_o01                            .  " PBO-Modules
INCLUDE mzsa2006_i01.
*INCLUDE mzsa2005_i01                            .  " PAI-Modules
INCLUDE mzsa2006_f01.
*INCLUDE mzsa2005_f01                            .  " FORM-Routines

LOAD-OF-PROGRAM.
  PERFORM set_default CHANGING zssa0073.
  CLEAR: gv_r1, gv_r2, gv_r3.
  gv_r2 = 'X'.
