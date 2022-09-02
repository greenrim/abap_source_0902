*&---------------------------------------------------------------------*
*& Include ZBC405_A20_EXAM01_TOP                    - Report ZBC405_A20_EXAM01
*&---------------------------------------------------------------------*
REPORT zbc405_a20_exam01.

DATA ok_code TYPE sy-ucomm.

TABLES ztspfli_a20.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-t01.
  SELECT-OPTIONS so_car FOR ztspfli_a20-carrid.
  SELECT-OPTIONS so_con FOR ztspfli_a20-connid.
SELECTION-SCREEN END OF BLOCK bl1.

SELECTION-SCREEN BEGIN OF BLOCK bl2 WITH FRAME.
  SELECTION-SCREEN SKIP 1.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(14) TEXT-t02. "FOR FIELD pa_var.
    SELECTION-SCREEN POSITION POS_LOW.
    PARAMETERS pa_var TYPE disvariant-variant.
    SELECTION-SCREEN COMMENT pos_high(10) FOR FIELD pa_edit.
    PARAMETERS pa_edit AS CHECKBOX.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK bl2.
PARAMETERS pa_sel AS CHECKBOX.

"SCREEN 200
TYPES: BEGIN OF tr_carrid,
         sign   TYPE ddsign,
         option TYPE ddoption,
         low    TYPE ztspfli_a20-carrid,
         high   TYPE ztspfli_a20-carrid,
       END OF tr_carrid.

DATA : gs_car TYPE tr_carrid,
       gt_car LIKE TABLE OF gs_car.

TYPES: BEGIN OF tr_connid,
         sign   TYPE ddsign,
         option TYPE ddoption,
         low    TYPE ztspfli_a20-connid,
         high   TYPE ztspfli_a20-connid,
       END OF tr_connid.

DATA : gs_con TYPE tr_connid,
       gt_con LIKE TABLE OF gs_con.




"ALV TABLE
TYPES BEGIN OF ts_spfli.
INCLUDE TYPE ztspfli_a20.
TYPES : light       TYPE c LENGTH 1,
        cellcol     TYPE lvc_t_scol,
        rowcol      TYPE c LENGTH 4,
        dif         TYPE c LENGTH 1,
        fltype_icon TYPE icon-id,
        ftzone      TYPE sairport-time_zone,
        ttzone      TYPE sairport-time_zone,
        modified    TYPE c LENGTH 1,
        END OF ts_spfli.

DATA : gs_spfli     TYPE ts_spfli,
       gt_spfli     LIKE TABLE OF gs_spfli,
       gs_spfli_sub TYPE spfli,
       gt_spfli_sub LIKE TABLE OF gs_spfli_sub.

DATA: gs_port TYPE sairport,
      gt_port LIKE TABLE OF gs_port.
"ALV
DATA : go_con TYPE REF TO cl_gui_custom_container,
       go_alv TYPE REF TO cl_gui_alv_grid.

DATA : gt_fcat         TYPE lvc_t_fcat,
       gs_fcat         LIKE LINE OF gt_fcat,
       gs_variant      TYPE disvariant,
       gs_layout       TYPE lvc_s_layo,
       gs_cellcol      TYPE lvc_s_scol,
       gt_excp         TYPE ui_functions,
       gv_soft_refresh TYPE c LENGTH 1,
       gs_stable       TYPE lvc_s_stbl.
