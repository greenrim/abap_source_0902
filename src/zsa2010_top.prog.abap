*&---------------------------------------------------------------------*
*& Include ZSA2010_TOP                              - Module Pool      SAPMZSA2010
*&---------------------------------------------------------------------*
PROGRAM sapmzsa2010.

"Common Variable               어느 프로그램에서도 쓰는 변수
DATA ok_code TYPE sy-ucomm.
DATA gv_subrc TYPE sy-subrc. "0= 성공, 0<> 실패

"Condition
TABLES zssa2080.
*DATA gs_cond TYPE zssa2080.

"Airline Info
TABLES zssa2081.
*DATA gs_airline TYPE zssa2081.

"Connection Info
TABLES zssa2082.
*DATA gs_conn TYPE zssa2082.
