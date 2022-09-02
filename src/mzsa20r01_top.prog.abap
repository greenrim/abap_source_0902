*&---------------------------------------------------------------------*
*& Include MZSA20R01_TOP                            - Module Pool      SAPMZSA20R01
*&---------------------------------------------------------------------*
PROGRAM sapmzsa20r01.

DATA : ok_code TYPE sy-ucomm.

TYPES : BEGIN OF ts_cond,
          carrid TYPE sflight-carrid,
          connid TYPE sflight-connid,
        END OF ts_cond.

DATA : gs_cond TYPE ts_cond.

TABLES zssa2060.
