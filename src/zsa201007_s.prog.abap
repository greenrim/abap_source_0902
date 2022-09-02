*&---------------------------------------------------------------------*
*& Report ZSA201007_S
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsa201007_s.

"문제 2
DATA: ls_data     TYPE zssa2001s,
      lt_data     LIKE TABLE OF ls_data,
      ls_data_tmp LIKE ls_data,
      lv_loekz    TYPE eloek,
      lv_statu    TYPE astat,
      lv_loekz1   TYPE ekpo-loekz,
      lv_statu1   TYPE ekpo-statu,
      lv_loekz2   LIKE lv_loekz,
      lv_statu2   LIKE lv_statu,
      lv_loekz3   LIKE lv_loekz1,
      lv_statu3   LIKE lv_statu1,
      lt_data2    LIKE TABLE OF ls_data WITH HEADER LINE.


"문제3
ls_data-bukrs = 'C001'.
ls_data-belnr = 'BL9201110'.
APPEND ls_data TO lt_data.

ls_data-bukrs = 'C002'.
ls_data-belnr = 'BL9201111'.
APPEND ls_data TO lt_data.

ls_data-bukrs = 'C003'.
ls_data-belnr = 'BL9201113'.
APPEND ls_data TO lt_data.

*cl_demo_output=>display( lt_data ).

lt_data2-bukrs = 'C011'.
lt_data2-belnr = 'BL9301110'.
APPEND lt_data2.

lt_data2-bukrs = 'C012'.
lt_data2-belnr = 'BL9301111'.
APPEND lt_data2.

lt_data2-bukrs = 'C013'.
lt_data2-belnr = 'BL9301112'.
APPEND lt_data2.

*cl_demo_output=>display( lt_data2[] ).

"문제4
DATA lv_tabix TYPE sy-tabix.

DATA : BEGIN OF gs_sflight,
         carrid     TYPE sflight-carrid,
         connid     TYPE sflight-connid,
         currency   TYPE sflight-currency,
         planetype  TYPE sflight-planetype,
         seatsocc_b TYPE sflight-seatsocc_b,
       END OF gs_sflight,

       gt_sflight LIKE TABLE OF gs_sflight.

SELECT carrid connid currency planetype seatsocc_b
  FROM sflight
  INTO CORRESPONDING FIELDS OF TABLE gt_sflight
  WHERE currency = 'USD'
  AND planetype = '747-400'.

LOOP AT gt_sflight INTO gs_sflight.
  lv_tabix = sy-tabix.
  CASE gs_sflight-carrid.
    WHEN 'UA'.
      gs_sflight-seatsocc_b = gs_sflight-seatsocc_b + 10.
      MODIFY gt_sflight FROM gs_sflight INDEX lv_tabix TRANSPORTING seatsocc_b.
  ENDCASE.

ENDLOOP.

cl_demo_output=>display( gt_sflight ).
