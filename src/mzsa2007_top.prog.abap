*&---------------------------------------------------------------------*
*& Include MZSA2007_TOP                             - Module Pool      SAPMZSA2007
*&---------------------------------------------------------------------*
PROGRAM sapmzsa2007.

"Condition
DATA: gv_carrid TYPE sflight-carrid,
      gv_connid TYPE sflight-connid.

TABLES zssa2074. "해당 Structure의 기능 사용을 위해 tables 사용
