*&---------------------------------------------------------------------*
*& Include ZRSA20_50_TOP                            - Report ZRSA20_50
*&---------------------------------------------------------------------*
REPORT zrsa20_50.

*TABLES: scarr, spfli, sflight.
TABLES: sflight.
"변수이름과 type이름이 동일한 변수 선언
"DATA scarr type scarr

PARAMETERS: pa_car LIKE scarr-carrid,
            pa_con LIKE spfli-connid.

SELECT-OPTIONS so_dat FOR sflight-fldate.
