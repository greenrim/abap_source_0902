*&---------------------------------------------------------------------*
*& Include MZSA2013_TOP                             - Module Pool      SAPMZSA2013
*&---------------------------------------------------------------------*
PROGRAM sapmzsa2013.

"COMMON Variable
DATA: ok_code  TYPE sy-ucomm,
      gv_dynnr TYPE sy-dynnr.

"Condition
TABLES zssa2076.
*DATA gs_cond TYPE zssa2076.

"Info
TABLES zssa2075.
*DATA gs_info TYPE zssa2076.

"Radio Button
DATA: gv_gen1, gv_gen2, gv_gen3.

"Tab strip
CONTROLS ts_info TYPE TABSTRIP.
