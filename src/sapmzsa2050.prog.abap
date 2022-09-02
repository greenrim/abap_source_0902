*&---------------------------------------------------------------------*
*& Module Pool      SAPMZSA2050
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE mzsa2050_top                            .    " Global Data

INCLUDE mzsa2050_o01                            .  " PBO-Modules
INCLUDE mzsa2050_i01                            .  " PAI-Modules
INCLUDE mzsa2050_f01                            .  " FORM-Routines

LOAD-OF-PROGRAM.

  SELECT SINGLE *
    FROM smeal AS a INNER JOIN scarr AS b
    ON a~carrid = b~carrid
    INTO CORRESPONDING FIELDS OF zssa2090
    WHERE a~carrid = 'AA'
    AND mealnumber = '7'.
