*&---------------------------------------------------------------------*
*& Include ZRSA20_24_TOP                            - Report ZRSA20_24
*&---------------------------------------------------------------------*
REPORT zrsa20_24.

TYPES: BEGIN OF ts_info,
         carrid       TYPE sflight-carrid,
         carrname     TYPE scarr-carrname,
         connid       TYPE sflight-connid,
         cityfrom     TYPE spfli-cityfrom,
         cityto       TYPE spfli-cityto,
         fldate       TYPE sflight-fldate,
         price        TYPE sflight-price,
         currency     TYPE sflight-currency,
         seatsmax     TYPE sflight-seatsmax,
         seatsocc     TYPE sflight-seatsocc,
         seatremain   TYPE i,
         seatsmax_b   TYPE sflight-seatsmax_b,
         seatsocc_b   TYPE sflight-seatsocc_b,
         seatremain_b TYPE i,
         seatsmax_f   TYPE sflight-seatsmax_f,
         seatsocc_f   TYPE sflight-seatsocc_f,
         seatremain_f TYPE i,
       END OF ts_info.

DATA: gs_info     TYPE ts_info,
      gt_info     LIKE TABLE OF gs_info,
      gv_carrname LIKE gs_info-carrname,
      gs_city     LIKE gs_info,
      gt_city     LIKE TABLE OF gs_city.

PARAMETERS: pa_car  LIKE gs_info-carrid,
            pa_con1 LIKE gs_info-connid,
            pa_con2 LIKE pa_con1.
