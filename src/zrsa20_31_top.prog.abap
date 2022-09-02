*&---------------------------------------------------------------------*
*& Include ZRSA20_31_TOP                            - Report ZRSA20_31
*&---------------------------------------------------------------------*
REPORT zrsa20_31.

*Employee List
DATA: gs_emp TYPE zssa2004,
      gt_emp LIKE TABLE OF gs_emp,
      gs_dep type ztsa20002,
      gt_dep like table of gs_dep.

*Selection Screen
PARAMETERS: pa_ent_b LIKE gs_emp-entdt,
            pa_ent_e LIKE gs_emp-entdt.
