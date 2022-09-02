*&---------------------------------------------------------------------*
*& Include MZSA2450T_TOP                            - Module Pool      SAPMZSA2450_T
*&---------------------------------------------------------------------*
PROGRAM SAPMZSA2450_T.

DATA: ok_code TYPE sy-ucomm,
      gv_dynnr type sy-dynnr.

TABLES: zssa24vencond,
        zssa2451,
        zssa2452.



CONTROLS ts_info TYPE TABSTRIP.
