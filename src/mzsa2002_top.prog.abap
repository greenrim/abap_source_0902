*&---------------------------------------------------------------------*
*& Include MZSA2002_TOP                             - Module Pool      SAPMZSA2002
*&---------------------------------------------------------------------*
PROGRAM sapmzsa2002.

*DATA: BEGIN OF gs_cond,
*        carrid TYPE sflight-carrid,
*        connid TYPE sflight-connid,
*      END OF gs_cond.

"Condition
"Use Screen
TABLES zssa2060. "abap dictionary의 많은 기능을 사용하기 위해서 tables 사용

"Use ABAP
DATA gs_cond TYPE zssa2060.

"같은 structure로 변수 2개 선언

*DATA zssa2060 TYPE zssa2060.


DATA ok_code LIKE sy-ucomm.
