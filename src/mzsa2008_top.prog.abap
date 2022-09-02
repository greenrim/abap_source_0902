*&---------------------------------------------------------------------*
*& Include MZSA2008_TOP                             - Module Pool      SAPMZSA2008
*&---------------------------------------------------------------------*
PROGRAM sapmzsa2008.

"Condition
TABLES zssa2076.
DATA gs_cond TYPE zssa2076.

"Employee Info
TABLES zssa2075.
DATA gs_info TYPE zssa2075.
DATA : gv_gender1 TYPE zssa2075-gender,
       gv_gender2 LIKE gv_gender1,
       gv_gender3 LIKE gv_gender1.
