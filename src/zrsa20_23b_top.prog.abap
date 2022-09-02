*&---------------------------------------------------------------------*
*& Include ZRSA20_23B_TOP                           - Report ZRSA20_23B
*&---------------------------------------------------------------------*
REPORT zrsa20_23b.

"Sch Date Info
DATA: gt_info TYPE TABLE OF zsinfo00, "zsinfo00는 structure type
      gs_info LIKE LINE OF gt_info.

PARAMETERS: pa_car LIKE sbook-carrid DEFAULT 'AA',
            pa_con LIKE sbook-connid DEFAULT '0017'.
