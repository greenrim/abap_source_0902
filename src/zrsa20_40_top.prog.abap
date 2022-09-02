*&---------------------------------------------------------------------*
*& Include ZRSA20_40_TOP                            - Report ZRSA20_40
*&---------------------------------------------------------------------*
REPORT zrsa20_40.

DATA: gs_std TYPE zssa2012,
      gt_std LIKE TABLE OF gs_std,
      gs_dep type zssa2012.

PARAMETERS pa_majid LIKE gs_std-majid.
