*&---------------------------------------------------------------------*
*& Include          YCL120_001_CLS
*&---------------------------------------------------------------------*

DATA : gr_con     TYPE REF TO cl_gui_docking_container,
       gr_split   TYPE REF TO cl_gui_splitter_container,
       gr_con_top TYPE REF TO cl_gui_container,
       gr_con_alv TYPE REF TO cl_gui_container.

DATA : gr_alv      TYPE REF TO cl_gui_alv_grid,
       gs_layout   TYPE lvc_s_layo,
       gt_fieLdcat TYPE lvc_t_fcat,
       gs_fieldcat TYPE lvc_s_fcat,

       gs_variant  TYPE disvariant,
       gv_save     TYPE c.
