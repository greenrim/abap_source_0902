*&---------------------------------------------------------------------*
*& Include SAPMZC1200001_TOP                        - Module Pool      SAPMZC1200001
*&---------------------------------------------------------------------*
PROGRAM sapmzc1200001 MESSAGE-ID zmcsa20.

TABLES ztsa2010.


DATA : BEGIN OF gs_data,
         matnr TYPE ztsa2010-matnr, "Material
         werks TYPE ztsa2010-werks, "Plant
         mtart TYPE ztsa2010-mtart, "Mat.Type
         matkl TYPE ztsa2010-matkl, "Mat.Group
         menge TYPE ztsa2010-menge, "Quantity
         meins TYPE ztsa2010-meins, "Unti
         dmbtr TYPE ztsa2010-dmbtr, "Price
         waers TYPE ztsa2010-waers, "Currency
       END OF gs_data,

       gt_data   LIKE TABLE OF gs_data,

       gv_okcode TYPE sy-ucomm.

"ALV
DATA : gcl_container TYPE REF TO cl_gui_custom_container,
       gcl_grid      TYPE REF TO cl_gui_alv_grid,
       gs_fcat       TYPE lvc_s_fcat,
       gt_fcat       TYPE lvc_t_fcat,
       gs_layout     TYPE lvc_s_layo,
       gs_variant    TYPE disvariant.
