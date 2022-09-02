*&---------------------------------------------------------------------*
*& Include ZC1R200007_TOP                           - Report ZC1R200007
*&---------------------------------------------------------------------*
REPORT zc1r200007.

DATA : BEGIN OF gs_data,
         matnr TYPE mara-matnr,
         mtart TYPE mara-mtart,
         matkl TYPE mara-matkl,
         meins TYPE mara-meins,
         tragr TYPE mara-tragr,
         pstat TYPE marc-pstat,
         dismm TYPE marc-dismm,
         ekgrp TYPE marc-ekgrp,
       END OF gs_data,

       gt_data LIKE TABLE OF gs_data.

"Common Variable
DATA : ok_code  TYPE sy-ucomm,
       gv_tabix TYPE sy-tabix.

"ALV
DATA : gcl_con    TYPE REF TO cl_gui_docking_container,
       gcl_alv    TYPE REF TO cl_gui_alv_grid,
       gs_variant TYPE disvariant,
       gs_layout  TYPE lvc_s_layo,
       gt_fcat    TYPE lvc_t_fcat,
       gs_fcat    TYPE lvc_s_fcat.
