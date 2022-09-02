*&---------------------------------------------------------------------*
*& Include ZC1R200005_TOP                           - Report ZC1R200005
*&---------------------------------------------------------------------*
REPORT zc1r200005 MESSAGE-ID zmcsa20.

CLASS LCL_EVENT_HANDLER DEFINITION DEFERRED.

TABLES bkpf.

DATA : BEGIN OF gs_data,
         belnr TYPE bseg-belnr,   "전표번호
         buzei TYPE bseg-buzei,   "전표순번
         blart TYPE bkpf-blart,   "전표유형
         budat TYPE bkpf-budat,   "전기일자
         shkzg TYPE bseg-shkzg,   "차대지시자
         dmbtr TYPE bseg-dmbtr,   "전표금액
         waers TYPE bkpf-waers,   "통화키
         hkont TYPE bseg-hkont,   "G/L
       END OF gs_data,

       gt_data LIKE TABLE OF gs_data.


"ALV
DATA : gcl_con    TYPE REF TO cl_gui_docking_container,
       gcl_grid   TYPE REF TO cl_gui_alv_grid,
       gcl_handler type ref to LCL_EVENT_HANDLER,
       gs_fcat    TYPE lvc_s_fcat,
       gt_fcat    TYPE lvc_t_fcat,
       gs_layout  TYPE lvc_s_layo,
       gs_variant TYPE disvariant.

DATA gv_okcode TYPE sy-ucomm.

"메크로
DEFINE _clear.
  CLEAR   &1.
  REFRESH &2.
END-OF-DEFINITION.
