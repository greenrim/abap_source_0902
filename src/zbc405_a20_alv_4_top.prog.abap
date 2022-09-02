*&---------------------------------------------------------------------*
*& Include ZBC405_A20_ALV_4_TOP                     - Report ZBC405_A20_ALV_4
*&---------------------------------------------------------------------*
REPORT zbc405_a20_alv_4.

TABLES ztspfli_t03.

DATA ok_code TYPE sy-ucomm.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME.
  SELECTION-SCREEN SKIP.
  SELECT-OPTIONS so_car FOR ztspfli_t03-carrid.
  SELECT-OPTIONS so_con FOR ztspfli_t03-connid.
SELECTION-SCREEN END OF BLOCK bl1.

"DATA TABLE
TYPES BEGIN OF ts_info.
INCLUDE TYPE ztspfli_t03.
TYPES : sum TYPE p LENGTH 12,
        END OF ts_info.

DATA: gs_spfli TYPE ts_info,
      gt_spfli LIKE TABLE OF gs_spfli,
      n      TYPE n LENGTH 3,
      fname    TYPE c LENGTH 20,
      gv_sum   TYPE i.

"ALV
DATA: go_con TYPE REF TO cl_gui_custom_container,
      go_alv TYPE REF TO cl_gui_alv_grid.

DATA : gs_fcat   TYPE lvc_s_fcat,
       gt_fcat   LIKE TABLE OF gs_fcat,
       gs_layout TYPE lvc_s_layo.
