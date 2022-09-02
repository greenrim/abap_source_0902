*&---------------------------------------------------------------------*
*& Include ZRSA20_41_TOP                            - Report ZRSA20_41
*&---------------------------------------------------------------------*
REPORT zrsa20_41.

PARAMETERS pa_pernr TYPE zssa20pro-pernr.

DATA: gs_pro     TYPE zssa20pro,
      gt_pro     LIKE TABLE OF gs_pro,
      gv_dep     TYPE ztsa2002-depid,
      gv_dtext   TYPE ztsa2002_t-dtext,
      gt_pdetail LIKE gt_pro,
      gs_pdetail LIKE LINE OF gt_pdetail,
      gs_ptext   TYPE ztsa20pro_t,
      gt_ptext   LIKE TABLE OF gs_ptext.
