*&---------------------------------------------------------------------*
*& Include MZSA2050_TOP                             - Module Pool      SAPMZSA2050
*&---------------------------------------------------------------------*
PROGRAM sapmzsa2050.

"Common Variable
DATA: ok_code  TYPE sy-ucomm,
      gv_dynnr TYPE sy-dynnr,
      gv_subrc TYPE sy-subrc.

"Condition
TABLES zssa2090.
DATA gs_condition TYPE zssa2090.


"Radio Button
DATA: gv_cond1, gv_cond2,
      gv_gr1   TYPE i VALUE 1, gv_gr2 TYPE i.

"Inflight Meal
TABLES zssa2091.
DATA gs_meal TYPE zssa2091.

"Vendor info
TABLES zssa2092.
DATA gs_vendor TYPE zssa2092.

"Tab Strip
CONTROLS ts_info TYPE TABSTRIP.
