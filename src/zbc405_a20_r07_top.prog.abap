*&---------------------------------------------------------------------*
*& Include ZBC405_A20_R07_TOP                       - Report ZBC405_A20_R07
*&---------------------------------------------------------------------*
REPORT zbc405_a20_r07.

"COMMON VARIABLE
DATA ok_code TYPE sy-ucomm.

TABLES ztsbook_a20.


"SELECTION SCREEN
*PARAMETERS : pa_car TYPE ztsbook_a20-carrid,
*             PA_Con TYPE  ztsbook_a20-connid.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME.
  SELECT-OPTIONS : so_car FOR ztsbook_a20-carrid,
                   so_con FOR ztsbook_a20-connid.
  SELECTION-SCREEN SKIP 1.
SELECTION-SCREEN END OF BLOCK bl1.

SELECTION-SCREEN SKIP 2.
PARAMETERS pa_edit AS CHECKBOX.


"ALV 생성
DATA : go_con TYPE REF TO cl_gui_custom_container,
       go_alv TYPE REF TO cl_gui_alv_grid.

"IN ALV
TYPES BEGIN OF ts_sbook.
INCLUDE TYPE ztsbook_a20.
TYPES : light     TYPE c LENGTH 1,
        rowcol    TYPE c LENGTH 4,
        cellcol   TYPE lvc_t_scol,
        telephone TYPE ztscustom_a20-telephone,
        email     TYPE ztscustom_a20-email,
        name      TYPE ztscustom_a20-name,
        style     TYPE lvc_t_styl,
        modified  TYPE c LENGTH 1,
        END OF ts_sbook.

"data 담을 변수
DATA : gs_sbook     TYPE ts_sbook,
       gt_sbook     LIKE TABLE OF gs_sbook,
       gs_custom    TYPE ztscustom_a20,
       gt_custom    LIKE TABLE OF gs_custom,
       gs_del_sbook TYPE ztsbook_a20,
       gt_del_sbook LIKE TABLE OF gs_del_sbook,
       gs_ins_sbook TYPE ztsbook_a20,
       gt_ins_sbook LIKE TABLE OF gs_ins_sbook.

"ALV 관련 변수
DATA : gs_layout  TYPE lvc_s_layo,
       gt_fcat    TYPE lvc_t_fcat,
       gs_fcat    LIKE LINE OF gt_fcat,
       gs_cellcol TYPE lvc_s_scol,
       gs_style   TYPE lvc_s_styl.
