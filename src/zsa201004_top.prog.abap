*&---------------------------------------------------------------------*
*& Include ZSA201004_TOP                            - Module Pool      ZSA201004
*&---------------------------------------------------------------------*
PROGRAM zsa201004.

TABLES sbook.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-t01.

  PARAMETERS      pa_car TYPE sbook-carrid   DEFAULT 'AA' OBLIGATORY.
  SELECT-OPTIONS  so_con FOR  sbook-connid   OBLIGATORY.
  PARAMETERS      pa_cus TYPE sbook-custtype DEFAULT 'B'  OBLIGATORY
                  AS LISTBOX VISIBLE LENGTH 17.
  SELECT-OPTIONS: so_fld FOR  sbook-fldate, " DEFAULT sy-datum.
                  so_bid FOR  sbook-bookid,
                  so_cid FOR  sbook-customid NO INTERVALS NO-EXTENSION.

SELECTION-SCREEN END OF BLOCK bl1.

DATA : BEGIN OF gs_sbook,
         carrid   TYPE sbook-carrid,
         connid   TYPE sbook-connid,
         fldate   TYPE sbook-fldate,
         bookid   TYPE sbook-bookid,
         customid TYPE sbook-customid,
         custtype TYPE sbook-custtype,
         invoice  TYPE sbook-invoice,
         class    TYPE sbook-class,
       END OF gs_sbook,

       gt_sbook LIKE TABLE OF gs_sbook.

"Common Variable
DATA gv_tabix TYPE sy-tabix.
