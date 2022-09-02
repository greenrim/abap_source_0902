*&---------------------------------------------------------------------*
*& Include ZSA201001_TOP                            - Module Pool      ZSA201001
*&---------------------------------------------------------------------*
PROGRAM zsa201001.

*"1교시 데이터변수
*DATA: gv_name TYPE c LENGTH 20,            "GV_NAME(20)
*      gv_num1 TYPE p LENGTH 3 DECIMALS 2,
*      gv_num2 TYPE n LENGTH 9.
*
*
*"2교시 STRUCTURE와 INTERNAL TABLE
*
**TYPES : BEGIN OF ts_mara,
**          matnr TYPE mara-matnr,
**          werks TYPE marc-werks,
**          mtart TYPE mara-mtart,
**          matkl TYPE mara-matkl,
**          ekgrp TYPE marc-ekgrp,
**          pstat TYPE marc-pstat,
**        END OF ts_mara.
*
*DATA : gs_emp TYPE ztsa2001,
*       gt_emp LIKE TABLE OF gs_emp.
*
*DATA : BEGIN OF gs_mara,
*         matnr TYPE mara-matnr,
*         werks TYPE marc-werks,
*         mtart TYPE mara-mtart,
*         matkl TYPE mara-matkl,
*         ekgrp TYPE marc-ekgrp,
*         pstat TYPE marc-pstat,
*       END OF gs_mara.
*DATA gt_mara LIKE TABLE OF gs_mara.
*
*"  INCLUDE STRUCTURE
*DATA : gs_data TYPE ztsa2001,
*       gt_data TYPE TABLE OF ztsa2001.
*
*"특정 DB TABLE의 모든 필드를 가져오고 싶을 때
*"다른 TABLE의 필드도 추가할 수 있음
*DATA : BEGIN OF gs_data2.
*         INCLUDE STRUCTURE ztsa2001.
*DATA:    matnr TYPE mara-matnr,
*         wekrs TYPE marc-werks,
*       END OF gs_data2,
*       gt_data2 LIKE TABLE OF gs_data2.
*
*
*"3교시 SBOOK 과제
*DATA : gs_sbook TYPE sbook,
*       gt_sbook LIKE TABLE OF gs_sbook.
*
*DATA gv_tabix TYPE sy-tabix.
*
*"3교시 SFLIGHT
*DATA : BEGIN OF gs_sflight,
*         carrid     TYPE sflight-carrid,
*         connid     TYPE sflight-connid,
*         fldate     TYPE sflight-fldate,
*         currency   TYPE sflight-currency,
*         planetype  TYPE sflight-planetype,
*         seatsocc_b TYPE sflight-seatsocc_b,
*       END OF gs_sflight,
*       gt_sflight LIKE TABLE OF gs_sflight.


"5교시 MARA, MAKT
*DATA : BEGIN OF gs_mara,
*         matnr TYPE mara-matnr,
*         maktx TYPE makt-maktx,
*         mtart TYPE mara-mtart,
*         matkl TYPE mara-matkl,
*       END OF gs_mara,
*
*       gt_mara LIKE TABLE OF gs_mara,
*
*       BEGIN OF gs_makt,
*         matnr TYPE makt-matnr,
*         maktx TYPE makt-maktx,
*       END OF gs_makt,
*
*       gt_makt LIKE TABLE OF gs_makt.
*
*DATA gv_tabix TYPE sy-tabix.

"6교시 SPFLI
DATA : BEGIN OF gs_spfli,
         carrid   TYPE spfli-carrid,
         carrname TYPE scarr-carrname,
         url      TYPE scarr-url,
         connid   TYPE spfli-connid,
         airpfrom TYPE spfli-airpfrom,
         airpto   TYPE spfli-airpto,
         deptime  TYPE spfli-deptime,
         arrtime  TYPE spfli-arrtime,
       END OF gs_spfli,

       gt_spfli LIKE TABLE OF gs_spfli,

       BEGIN OF gs_scarr,
         carrid   TYPE scarr-carrid,
         carrname TYPE scarr-carrname,
         url      TYPE scarr-url,
       END OF gs_scarr,

       gt_scarr LIKE TABLE OF gs_scarr.

DATA gv_tabix TYPE sy-tabix.

"
DATA : BEGIN OF gs_data,
         matnr TYPE mara-matnr,
         maktx TYPE makt-maktx,
         mtart TYPE mara-mtart,
         mtbez TYPE t134t-mtbez,
         mbrsh TYPE mara-mbrsh,
         mbbez TYPE t137t-mbbez,
         tragr TYPE mara-tragr,
         vtext TYPE ttgrt-vtext,
       END OF gs_data,

       gt_data LIKE TABLE OF gs_data,

       BEGIN OF gs_t134t,
         mtart TYPE t134t-mtart,
         mtbez TYPE t134t-mtbez,
       END OF gs_t134t,

       gt_t134t LIKE TABLE OF gs_t134t,

       BEGIN OF gs_t137t,
         mbrsh TYPE t137t-mbrsh,
         mbbez TYPE t137t-mbbez,
       END OF gs_t137t,

       gt_t137t LIKE TABLE OF gs_t137t,

       BEGIN OF gs_TTGRT,
         tragr TYPE ttgrt-tragr,
         vtext TYPE ttgrt-vtext,
       END OF gs_TTGRT,

       gt_TTGRT LIKE TABLE OF gs_TTGRT.
