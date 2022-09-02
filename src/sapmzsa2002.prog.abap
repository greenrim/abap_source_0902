*&---------------------------------------------------------------------*
*& Module Pool      SAPMZSA2002
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE mzsa2002_top                            .    " Global Data

INCLUDE mzsa2002_o01                            .  " PBO-Modules
INCLUDE mzsa2002_i01                            .  " PAI-Modules
INCLUDE mzsa2002_f01                            .  " FORM-Routines


LOAD-OF-PROGRAM. "INITIALAZTION 과 동일 이건 1번 프로그램에서만 사용
PERFORM set_default.
