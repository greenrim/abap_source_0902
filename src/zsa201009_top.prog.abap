*&---------------------------------------------------------------------*
*& Include ZSA201009_TOP                            - Report ZSA201009
*&---------------------------------------------------------------------*
REPORT zsa201009.

TABLES : mast, mara.


DATA : go_con TYPE REF TO cl_gui_docking_container,
       go_alv TYPE REF TO cl_gui_alv_grid.

DATA : BEGIN OF gs_data,
         matnr TYPE mast-matnr,
         maktx TYPE makt-maktx,
         stlan TYPE mast-stlan,
         stlnr TYPE mast-stlnr,
         stlal TYPE mast-stlal,
         mtart TYPE mara-mtart,
         matkl TYPE mara-matkl,
       END OF gs_data,

       gt_data LIKE TABLE OF gs_data,

       BEGIN OF gs_makt,
         matnr TYPE makt-matnr,
         maktx TYPE makt-maktx,
       END OF gs_makt,

       gt_makt LIKE TABLE OF gs_makt.

DATA : gs_variant TYPE disvariant,
       gs_layout  TYPE lvc_s_layo,
       gs_fcat    TYPE lvc_s_fcat,
       gt_fcat    LIKE TABLE OF gs_fcat.

"COMMON VARIABLE
DATA : gv_okcode TYPE sy-ucomm,
       gv_tabix  TYPE sy-tabix.
