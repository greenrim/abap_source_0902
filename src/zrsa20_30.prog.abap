*&---------------------------------------------------------------------*
*& Report ZRSA20_30
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_30.

*TYPES: BEGIN OF ts_info,
*         stdno TYPE n LENGTH 8,
*         sname TYPE c LENGTH 40,
*       END OF ts_info.

"Std Info
DATA gs_std TYPE zssa2001.

gs_std-stdno = '20220001'.
gs_std-sname = 'LEE HR'.
