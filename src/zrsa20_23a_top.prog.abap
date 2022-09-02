*&---------------------------------------------------------------------*
*& Include ZRSA20_23A_TOP                           - Report ZRSA20_23A
*&---------------------------------------------------------------------*
REPORT zrsa20_23a.

* Structure Variable / Internal Table
DATA: gs_info TYPE zsinfo00,
      gt_info LIKE TABLE OF gs_info.

** Selection Screen
*parameters: pa_car type scarr-carrid, "selection screen 만드는 변수도 global변수
*            pa_con type spfli-connid,
*            pa_dat type sflight-fldate.

PARAMETERS: pa_car TYPE sbook-carrid,
            pa_con TYPE sbook-connid,
            pa_dat TYPE sbook-fldate.
