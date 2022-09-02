*&---------------------------------------------------------------------*
*& Include ZBC405_A20_2_TOP                         - Report ZBC405_A20_2
*&---------------------------------------------------------------------*
REPORT zbc405_a20_2.

TABLES dv_flights.
DATA : gs_flights TYPE dv_flights,
       gt_flights LIKE TABLE OF gs_flights.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-t01.
  SELECT-OPTIONS : so_cid FOR dv_flights-carrid MEMORY ID car,
  so_nid FOR dv_flights-connid,
  so_flda FOR dv_flights-fldate.
SELECTION-SCREEN END OF BLOCK bl1.

SELECTION-SCREEN BEGIN OF LINE.
   SELECTION-SCREEN comment 4(15) text-t01.
  PARAMETERS pa_rad1 RADIOBUTTON GROUP gr1.
    SELECTION-SCREEN  comment pos_low(15) text-t02.
    PARAMETERS           pa_rad2 RADIOBUTTON GROUP gr1.
    SELECTION-SCREEN  comment pos_high(15) text-t03.
    PARAMETERS           pa_rad3 RADIOBUTTON GROUP gr1.
SELECTION-SCREEN END OF LINE.
