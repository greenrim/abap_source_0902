*&---------------------------------------------------------------------*
*& Include ZBC405_A20_R06_TOP                       - Report ZBC405_A20_R06
*&---------------------------------------------------------------------*
REPORT zbc405_a20_r06.

TABLES ztspfli_a20.

SELECT-OPTIONS : so_car FOR ztspfli_a20-carrid MEMORY ID car,
                 so_con FOR ztspfli_a20-connid MEMORY ID con.

DATA: gs_spfli TYPE ztspfli_a20,
      gt_spfli LIKE TABLE OF gs_spfli.

DATA : go_alv     TYPE REF TO cl_salv_table,
       go_display TYPE REF TO cl_salv_display_settings,
       go_layout  TYPE REF TO cl_salv_layout,
       gs_layout  TYPE salv_s_layout_key,
       go_func    TYPE REF TO cl_salv_functions_list,
       go_columns TYPE REF TO cl_salv_columns_table,
       go_column  TYPE REF TO cl_salv_column_table,
       go_col     TYPE REF TO cl_salv_column,
       gs_color   TYPE lvc_s_colo,
       go_sel     TYPE REF TO cl_salv_selections.
