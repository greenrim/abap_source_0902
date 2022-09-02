*&---------------------------------------------------------------------*
*& Include ZC1R200001_TOP                           - Report ZC1R200001
*&---------------------------------------------------------------------*
REPORT zc1r200001 MESSAGE-ID zmcsa20.

TABLES : sflight.

DATA : BEGIN OF gs_data,
         carrid    TYPE sflight-carrid,
         connid    TYPE sflight-connid,
         fldate    TYPE sflight-fldate,
         price     TYPE sflight-price,
         currency  TYPE sflight-currency,
         planetype TYPE sflight-planetype,
       END OF gs_data,

       gt_data LIKE TABLE OF gs_data.

"ALV관련
DATA : gcl_container TYPE REF TO cl_gui_docking_container,
       "custom control을 안 그리고 지정 숫자만큼 커짐
       "custom c은 팝업이나 모듈풀에서 쓰는 거고 alv전용은 아님
       gcl_grid      TYPE REF TO cl_gui_alv_grid,
       gs_fcat       TYPE lvc_s_fcat,
       gt_fcat       TYPE lvc_t_fcat,
       gs_layout     TYPE lvc_s_layo,
       gs_variant    TYPE disvariant. "layout menagement

DATA : gv_okcode TYPE sy-ucomm.
