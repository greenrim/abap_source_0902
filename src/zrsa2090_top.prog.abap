*&---------------------------------------------------------------------*
*& Include ZRSA2090_TOP                             - Report ZRSA2090
*&---------------------------------------------------------------------*
REPORT zrsa2090.

DATA : gv_carrid TYPE zssa0093-carrid,
       gv_mealno TYPE zssa0093-mealnumber,
       gv_venca  TYPE zssa0093-venca,
       gs_info   TYPE zssa0093,
       gt_info   LIKE TABLE OF gs_info.

DATA : gt_subinfo LIKE gt_info,
       gs_subinfo LIKE LINE OF gt_subinfo.

PARAMETERS pa_cid LIKE gv_carrid.

SELECT-OPTIONS so_meal FOR gv_mealno.
PARAMETERS pa_venca LIKE gv_venca AS LISTBOX VISIBLE LENGTH 20.
