*&---------------------------------------------------------------------*
*& Include ZBC405_A20_ALV_3_TOP                     - Report ZBC405_A20_ALV_3
*&---------------------------------------------------------------------*
REPORT zbc405_a20_alv_3.

TABLES ztsbook_a20.

"조건
SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-t01.
  SELECT-OPTIONS : so_car FOR ztsbook_a20-carrid OBLIGATORY MEMORY ID car,
                   so_con FOR ztsbook_a20-connid MEMORY ID con,
                   so_fld FOR ztsbook_a20-fldate,
                  so_cus FOR ztsbook_a20-customid.
  SELECTION-SCREEN SKIP 2.
  PARAMETERS pa_edit AS CHECKBOX.
SELECTION-SCREEN END OF BLOCK bl1.
SELECTION-SCREEN SKIP 2.

"FOR ALV 변수
DATA : go_container TYPE REF TO cl_gui_custom_container,
       go_alv       TYPE REF TO cl_gui_alv_grid.

DATA: gs_variant      TYPE disvariant,
      gv_save         TYPE c LENGTH 1,
      gv_default      TYPE c LENGTH 1,
      gs_layout       TYPE lvc_s_layo,
      gt_sort         TYPE lvc_t_sort,
      gs_sort         LIKE LINE OF gt_sort,
      gs_color        TYPE lvc_s_scol,
      gt_exct         TYPE ui_functions,
      gt_fcat         TYPE lvc_t_fcat,
      gs_fcat         LIKE LINE OF gt_fcat,
      gv_soft_refresh TYPE c LENGTH 1,
      gs_stable       TYPE lvc_s_stbl.


DATA : gt_custom TYPE TABLE OF ztscustom_a20,
       gs_custom LIKE LINE OF gt_custom.

"VARIANT 조건
SELECTION-SCREEN BEGIN OF BLOCK bL2 WITH FRAME.

  SELECTION-SCREEN SKIP 1.
*  PARAMETERS pa_var TYPE disvariant-variant.
  PARAMETERS pa_var LIKE gs_variant-variant VALUE CHECK.
SELECTION-SCREEN END OF BLOCK bl2.

*SELECTION-SCREEN BEGIN OF LINE.
*  SELECTION-SCREEN COMMENT 4(10) FOR FIELD pa_rad1.
*  SELECTION-SCREEN POSITION 1.
*  PARAMETERS pa_rad1 RADIOBUTTON GROUP rdg1.
*  SELECTION-SCREEN COMMENT pos_low(10) TEXT-t01.
*  PARAMETERS pa_rad2 RADIOBUTTON GROUP rdg1.
*  SELECTION-SCREEN COMMENT 70(10) TEXT-t01 FOR FIELD pa_chk.
*  SELECTION-SCREEN POSITION POS_HIGH.
*  PARAMETERS pa_chk AS CHECKBOX.
*SELECTION-SCREEN END OF LINE.

TYPES BEGIN OF ts_sbook.
INCLUDE TYPE ztsbook_a20.
*INCLUDE TYPE ztscustom_a20.
TYPES : light     TYPE c LENGTH 1,
        row_color TYPE c LENGTH 4,
        it_color  TYPE lvc_t_scol,
        telephone TYPE ztscustom_a20-telephone,
        email     TYPE ztscustom_a20-email,
        bt        TYPE lvc_t_styl,
        modified  TYPE c LENGTH 1,
        drdn      TYPE int4,
        END OF ts_sbook.

DATA : gs_sbook     TYPE ts_sbook,
       gt_sbook     LIKE TABLE OF gs_sbook,
*       gt_del_sbook TYPE TABLE OF ts_sbook, "for Deleted
       gt_del_sbook TYPE TABLE OF ztsbook_a20,
       gs_del_sbook LIKE LINE OF gt_del_sbook.

DATA: ok_code TYPE sy-ucomm.
