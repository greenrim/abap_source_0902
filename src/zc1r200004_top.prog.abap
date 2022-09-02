*&---------------------------------------------------------------------*
*& Include ZC1R200004_TOP                           - Report ZC1R200004
*&---------------------------------------------------------------------*
REPORT zc1r200004 MESSAGE-ID zmcsa20.

TABLES : scarr, sflight.

"Data
DATA : BEGIN OF gs_data,
         carrid    TYPE scarr-carrid,
         carrname  TYPE scarr-carrname,
         connid    TYPE sflight-connid,
         fldate    TYPE sflight-fldate,
         planetype TYPE sflight-planetype,
         price     TYPE sflight-price,
         currency  TYPE sflight-currency,
         url       TYPE scarr-url,
       END OF gs_data,

       gt_data LIKE TABLE OF gs_data,

       BEGIN OF gs_sbook,
         carrid     TYPE sbook-carrid,
         connid     TYPE sbook-connid,
         fldate     TYPE sbook-fldate,
         bookid     TYPE sbook-bookid,
         customid   TYPE sbook-customid,
         custtype   TYPE sbook-custtype,
         luggweight TYPE sbook-luggweight,
         wunit      TYPE sbook-wunit,
       END OF gs_sbook,

       gt_sbook LIKE TABLE OF gs_sbook,

       BEGIN OF gs_saplane,
         planetype TYPE saplane-planetype,
         seatsmax  TYPE saplane-seatsmax,
         tankcap   TYPE saplane-tankcap,
         cap_unit  TYPE saplane-cap_unit,
         weight    TYPE saplane-weight,
         wei_unit  TYPE saplane-wei_unit,
         producer  TYPE saplane-producer,
       END OF gs_saplane,

       gt_saplane LIKE TABLE OF gs_saplane.

"ALV
DATA : gcl_con    TYPE REF TO cl_gui_docking_container,
       gcl_grid   TYPE REF TO cl_gui_alv_grid,
       gs_fcat    TYPE lvc_s_fcat,
       gt_fcat    LIKE TABLE OF gs_fcat, "lvc_t_fcat
       gs_layout  TYPE lvc_s_layo,
       gs_variant TYPE disvariant.

"POPUP
DATA : gcl_con_pop   TYPE REF TO cl_gui_custom_container,
       gcl_grid_pop  TYPE REF TO cl_gui_alv_grid,
       gs_fcat_pop   TYPE lvc_s_fcat,
       gt_fcat_pop   LIKE TABLE OF gs_fcat, "lvc_t_fcat
       gs_layout_pop TYPE lvc_s_layo.

"popup alv for planetype
DATA : gcl_container_saplane TYPE REF TO cl_gui_custom_container,
       gcl_grid_saplane      TYPE REF TO cl_gui_alv_grid,
       gs_fcat_saplane       TYPE lvc_s_fcat,
       gt_fcat_saplane       TYPE lvc_t_fcat,
       gs_layout_saplane     TYPE lvc_s_layo.

"Common Variable
DATA : gv_okcode TYPE sy-ucomm.
