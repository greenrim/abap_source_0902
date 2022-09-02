*&---------------------------------------------------------------------*
*& Include ZBC405_A20_R02_TOP                       - Report ZBC405_A20_R02
*&---------------------------------------------------------------------*
REPORT zbc405_a20_r02.

DATA ok_code TYPE sy-ucomm.

TABLES zssa20r01.

DATA: gs_stable       TYPE lvc_s_stbl,
      gv_soft_refresh TYPE abap_bool.

TYPES: BEGIN OF ts_sflight.
         INCLUDE TYPE sflight.
TYPES:   light     TYPE c LENGTH 1,
         row_color TYPE c LENGTH 4,
         gt_color  TYPE lvc_t_scol, "Table type
         carrname  TYPE scarr-carrname,
       END OF ts_sflight.

DATA : gs_sflight TYPE ts_sflight,
       gt_sflight LIKE TABLE OF gs_sflight,
       gs_sub     TYPE ts_sflight,
       gt_sub     LIKE TABLE OF gs_sub,
       gs_scarr   TYPE scarr,
       gt_scarr   LIKE TABLE OF gs_scarr.

"ALV
DATA: go_con_1  TYPE REF TO cl_gui_custom_container,
      go_grid_1 TYPE REF TO cl_gui_alv_grid,
      go_con_2  TYPE REF TO cl_gui_custom_container,
      go_grid_2 TYPE REF TO cl_gui_alv_grid.

"FIELD CATALOG
DATA: gt_fcat TYPE lvc_t_fcat,
      gs_fcat LIKE LINE OF gt_fcat.

"ALV LAYOUT
DATA: gs_variant            TYPE disvariant,
      gv_save               TYPE c LENGTH 1,
      gs_layout_1           TYPE lvc_s_layo,
      gs_layout_2           TYPE lvc_s_layo,
      gs_color              TYPE lvc_s_scol,
      gt_excluded_functions TYPE ui_functions.

"SELECTION SCREEN
SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME.
  SELECT-OPTIONS so_car FOR zssa20r01-carrid NO-EXTENSION.
  SELECT-OPTIONS so_con FOR zssa20r01-connid NO-EXTENSION.
  SELECT-OPTIONS so_fld FOR zssa20r01-fldate NO-EXTENSION.
SELECTION-SCREEN END OF BLOCK bl1.

SELECTION-SCREEN SKIP 3.

PARAMETERS pa_var TYPE disvariant-variant.
