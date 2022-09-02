*&---------------------------------------------------------------------*
*& Report ZRSA20_36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_36.

*ALV
TYPES: BEGIN OF ts_dep,
         budget TYPE ztsa2002-budget,
         waers  TYPE ztsa2002-waers,
       END OF ts_dep.

DATA: gs_dep TYPE zssa2020, "DB Table
      gt_dep LIKE TABLE OF gs_dep.

*DATA: gs_dep TYPE ts_dep, "DB Table
*      gt_dep LIKE TABLE OF gs_dep.

DATA go_salv TYPE REF TO cl_salv_table.

**ALV
*DATA: gs_dep TYPE ztsa2002, "DB Table
*      gt_dep LIKE TABLE OF gs_dep.
*DATA go_salv TYPE REF TO cl_salv_table.

START-OF-SELECTION.

  SELECT *
    FROM ztsa2002
    INTO CORRESPONDING FIELDS OF TABLE gt_dep.

  cl_salv_table=>factory(
  IMPORTING r_salv_table = go_salv
  CHANGING t_table = gt_dep
  ).
  go_salv->display( ).

*
*DATA: gs_dep TYPE ztsa2002, "DB Table
*      gt_dep LIKE TABLE OF gs_dep.
*
*PARAMETERS pa_dep LIKE gs_dep-depid.
*
*START-OF-SELECTION.
*
*  SELECT SINGLE *
*    FROM ztsa2002
*    INTO CORRESPONDING FIELDS OF gs_dep
*    WHERE depid = pa_dep.
*
*  WRITE: gs_dep-budget CURRENCY gs_dep-waers ,
*         gs_dep-waers.
*
*  SELECT *
*    FROM ztsa2002
*    INTO CORRESPONDING FIELDS OF TABLE gt_dep.
*
*  cl_demo_output=>display_data( gt_dep ).
