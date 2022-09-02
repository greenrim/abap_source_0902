*&---------------------------------------------------------------------*
*& Module Pool      SAPMZSA2004
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE mzsa2004_top                            .    " Global Data

INCLUDE mzsa2004_o01                            .  " PBO-Modules
INCLUDE mzsa2004_i01                            .  " PAI-Modules
INCLUDE mzsa2004_f01                            .  " FORM-Routines

LOAD-OF-PROGRAM.
  SELECT SINGLE pernr
    FROM ztsa2001
    INTO CORRESPONDING FIELDS OF zssa2061.
