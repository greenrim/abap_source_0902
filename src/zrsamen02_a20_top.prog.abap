*&---------------------------------------------------------------------*
*& Include ZRSAMEN02_A20_TOP                        - Report ZRSAMEN02_A20
*&---------------------------------------------------------------------*
REPORT zrsamen02_a20.

TABLES: kna1, ztvermata20, ztversa20.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-t01.

  PARAMETERS pa_ven LIKE ztversa20-vendor VALUE CHECK.

SELECTION-SCREEN END OF BLOCK bl1.

PARAMETERS pa_var TYPE disvariant-variant.

"ALV
DATA : go_con TYPE REF TO cl_gui_custom_container, "cl_gui_docking_container,
       go_alv TYPE REF TO cl_gui_alv_grid.

DATA : gs_layout  TYPE lvc_s_layo,
       gt_layout  LIKE TABLE OF gs_layout,
       gs_variant TYPE disvariant,
       gs_fcat    TYPE LVC_s_FCAT,
       gt_fcat    LIKE TABLE OF gs_fcat,
       gs_style   TYPE lvc_s_styl.


"DATA TABLE
DATA : BEGIN OF gs_data.
         INCLUDE STRUCTURE ztvermata20.
DATA :   maktx    TYPE makt-maktx,
         gt_style TYPE lvc_t_styl,
         modified TYPE c LENGTH 1,
       END OF gs_data,

       gt_data LIKE TABLE OF gs_data,

       BEGIN OF gs_KNA1,
         kunnr TYPE kna1-kunnr,
         name1 TYPE kna1-name1,
       END OF gs_KNA1,

       gt_KNA1 LIKE TABLE OF gs_KNA1,

       BEGIN OF gs_makt,
         matnr TYPE makt-matnr,
         maktx TYPE makt-maktx,
       END OF gs_makt,

       gt_makt     LIKE TABLE OF gs_makt,

       gs_data_del LIKE ztvermata20,
       gt_data_del LIKE TABLE OF gs_data_del.

*       gs_data_mod TYPE ztvermata20,
*       gt_data_mod LIKE TABLE OF gs_data_mod.

"SCREEN LAYOUT
DATA : gv_id     TYPE vrm_id,
       gt_values TYPE vrm_values,
       gs_value  LIKE LINE OF gt_values.

"Common Variable
DATA : ok_code  TYPE sy-ucomm,
       gv_tabix TYPE sy-tabix.
