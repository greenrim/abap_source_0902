*&---------------------------------------------------------------------*
*& Report ZRSA20_33
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_33.

DATA gs_dep TYPE zssa2006.
DATA : gt_emp TYPE TABLE OF zssa2005, "emp info
       gs_emp LIKE LINE OF gt_emp.
PARAMETERS pa_dep TYPE ztsa2002-depid.

START-OF-SELECTION.

  SELECT SINGLE *
    FROM ztsa2002 "dep table
    INTO CORRESPONDING FIELDS OF gs_dep
    WHERE depid = pa_dep.
  cl_demo_output=>display_data( gs_dep ).

  SELECT *
  FROM ztsa0001
  INTO CORRESPONDING FIELDS OF TABLE gt_emp
  WHERE depid = gs_dep-depid.
  cl_demo_output=>display_data( gt_emp ).
