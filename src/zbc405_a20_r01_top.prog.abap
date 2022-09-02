*&---------------------------------------------------------------------*
*& Include ZBC405_A20_R01_TOP                       - Report ZBC405_A20_R01
*&---------------------------------------------------------------------*
REPORT zbc405_a20_r01.

DATA ok_Code TYPE sy-ucomm.

TABLES zssa20r01.

TYPES BEGIN OF ts_scarr.
INCLUDE TYPE scarr.
TYPES : END OF ts_scarr.

TYPES BEGIN OF ts_spfli.
INCLUDE TYPE spfli.
TYPES : END OF ts_spfli.

TYPES BEGIN OF ts_sflight.
INCLUDE TYPE Sflight.
TYPES : END OF ts_sflight.

DATA: gs_scarr   TYPE ts_scarr,
      gt_scarr   LIKE TABLE OF gs_scarr,
      gs_spfli   TYPE ts_spfli,
      gt_spfli   LIKE TABLE OF gs_spfli,
      gs_sflight TYPE ts_sflight,
      gt_sflight LIKE TABLE OF gs_sflight.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-t01. "Condition
  SELECT-OPTIONS so_carr FOR zssa20r01-carrid NO-EXTENSION MODIF ID con.

  SELECT-OPTIONS so_conn FOR zssa20r01-connid NO-EXTENSION MODIF ID con.

  SELECT-OPTIONS so_flda FOR zssa20r01-fldate NO-EXTENSION MODIF ID con.

SELECTION-SCREEN END OF BLOCK bl1.

*SELECTION-SCREEN BEGIN OF SCREEN 1100 AS SUBSCREEN.

DATA : go_container_car TYPE REF TO cl_gui_custom_container,
       go_alv_grid_car  TYPE REF TO cl_gui_alv_grid,
       go_container_con TYPE REF TO cl_gui_custom_container,
       go_alv_grid_con  TYPE REF TO cl_gui_alv_grid,
       go_container_fld TYPE REF TO cl_gui_custom_container,
       go_alv_grid_fld  TYPE REF TO cl_gui_alv_grid.

*  SELECT-OPTIONS so_carr1 FOR zssa20r01-carrid NO-EXTENSION.
*
*  SELECT-OPTIONS so_conn1 FOR zssa20r01-connid NO-EXTENSION.
*
*  SELECT-OPTIONS so_flda1 FOR zssa20r01-fldate NO-EXTENSION.
*SELECTION-SCREEN END OF SCREEN 1100.
*
*SELECTION-SCREEN BEGIN OF SCREEN 1200 AS SUBSCREEN.
*  SELECT-OPTIONS so_carr2 FOR zssa20r01-carrid NO-EXTENSION.
*
*  SELECT-OPTIONS so_conn2 FOR zssa20r01-connid NO-EXTENSION.
*
*  SELECT-OPTIONS so_flda2 FOR zssa20r01-fldate NO-EXTENSION.
*SELECTION-SCREEN END OF SCREEN 1200.
*
*SELECTION-SCREEN BEGIN OF SCREEN 1300 AS SUBSCREEN.
*  SELECT-OPTIONS so_carr3 FOR zssa20r01-carrid NO-EXTENSION.
*
*  SELECT-OPTIONS so_conn3 FOR zssa20r01-connid NO-EXTENSION.
*
*  SELECT-OPTIONS so_flda3 FOR zssa20r01-fldate NO-EXTENSION.
*SELECTION-SCREEN END OF SCREEN 1300.
*
*SELECTION-SCREEN BEGIN OF TABBED BLOCK info FOR 20 LINES.
*  SELECTION-SCREEN TAB (10) tab1 USER-COMMAND air DEFAULT SCREEN 1100.
*  SELECTION-SCREEN TAB (15) tab2 USER-COMMAND con DEFAULT SCREEN 1200.
*  SELECTION-SCREEN TAB (10) tab3 USER-COMMAND fli DEFAULT SCREEN 1300.
*SELECTION-SCREEN END OF BLOCK info.

CONTROLS  ts_info TYPE TABSTRIP.
