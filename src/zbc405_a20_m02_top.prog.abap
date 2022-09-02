*&---------------------------------------------------------------------*
*& Include ZBC405_A20_R02_TOP                       - Report ZBC405_A20_R02
*&---------------------------------------------------------------------*
REPORT zbc405_a20_r02.

DATA ok_code TYPE sy-ucomm.

TABLES zssa20r01.

TYPES: BEGIN OF ts_sflight.
         INCLUDE TYPE sflight.
TYPES:   carrname TYPE scarr-carrname,
       END OF ts_sflight.

DATA : gs_sflight TYPE ts_sflight,
       gt_sflight LIKE TABLE OF gs_sflight.

"SELECTION SCREEN
SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME.
  SELECT-OPTIONS so_car FOR zssa20r01-carrid NO-EXTENSION.
  SELECT-OPTIONS so_con FOR zssa20r01-connid NO-EXTENSION.
  SELECT-OPTIONS so_fld FOR zssa20r01-fldate NO-EXTENSION.
SELECTION-SCREEN END OF BLOCK bl1.



"ALV
DATA: go_con_1  TYPE REF TO cl_gui_custom_container,
      go_grid_1 TYPE REF TO cl_gui_alv_grid,
      go_con_2  TYPE REF TO cl_gui_custom_container,
      go_grid_2 TYPE REF TO cl_gui_alv_grid.

"LAYOUT
DATA: gs_variant TYPE disvariant,
      gv_save    TYPE c LENGTH 1.

SELECTION-SCREEN SKIP 3.

PARAMETERS pa_var TYPE disvariant-variant.
