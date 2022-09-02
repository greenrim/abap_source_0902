*&---------------------------------------------------------------------*
*& Include ZBC405_A20_R02_ANS_TOP                   - Report ZBC405_A20_R02_ANS
*&---------------------------------------------------------------------*
REPORT zbc405_a20_r02_ans.

TABLES zssa19fl.

TYPES BEGIN OF tp_sfli.
INCLUDE TYPE sflight.
TYPES : carrname TYPE scarr-carrname,
        END OF tp_sfli.

"ALV 관련 변수
DATA : go_container_high TYPE REF TO cl_gui_custom_container,
       go_alv_grid_high  TYPE REF TO cl_gui_alv_grid,
       go_container_low  TYPE REF TO cl_gui_custom_container,
       go_alv_grid_low   TYPE REF TO cl_gui_alv_grid.

"Table 관련 변수
DATA : gs_sflight      TYPE tp_sfli,
       gt_sflight_high LIKE TABLE OF gs_sflight,
       gt_sflight_low  LIKE TABLE OF gs_sflight,
       gs_scarr        TYPE scarr,
       gt_scarr        LIKE TABLE OF gs_scarr.

SELECTION-SCREEN BEGIN OF BLOCK con WITH FRAME TITLE TEXT-t01.
  SELECT-OPTIONS so_car FOR zssa19fl-carrid NO-EXTENSION.
  SELECT-OPTIONS so_con FOR zssa19fl-connid NO-EXTENSION.
  SELECT-OPTIONS so_fld FOR zssa19fl-fldate NO-EXTENSION."cntl+d
SELECTION-SCREEN END OF BLOCK con.
