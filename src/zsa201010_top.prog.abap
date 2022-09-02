*&---------------------------------------------------------------------*
*& Include ZSA201010_TOP                            - Report ZSA201010
*&---------------------------------------------------------------------*
REPORT zsa201010 MESSAGE-ID zmcsa20.

TABLES ztsa20emp.

DATA : BEGIN OF gs_data,
         pernr    TYPE ztsa20emp-pernr,
         ename    TYPE ztsa20emp-ename,
         entdt    TYPE ztsa20emp-entdt,
         gender   TYPE ztsa20emp-gender,
         depid    TYPE ztsa20emp-depid,
         carrid   TYPE scarr-carrid,
         carrname TYPE scarr-carrname,
         style    TYPE lvc_t_styl,
       END OF gs_data,

       gt_data     LIKE TABLE OF gs_data,
       gt_data_del LIKE TABLE OF gs_data.

"ALV
DATA : gcl_container TYPE REF TO cl_gui_docking_container,
       gcl_grid      TYPE REF TO cl_gui_alv_grid,
       gs_fcat       TYPE lvc_s_fcat,
       gt_fcat       TYPE lvc_t_fcat,
       gs_layout     TYPE lvc_s_layo,
       gs_variant    TYPE disvariant,
       gs_stable     TYPE lvc_s_stbl.

DATA : gv_okcode TYPE sy-ucomm,
       gv_tabix  TYPE sy-tabix.

"사용자가 선택한 행의 정보를 저장할 ITAB
DATA : gt_rows TYPE lvc_t_row,
       gs_row  TYPE lvc_s_row.
