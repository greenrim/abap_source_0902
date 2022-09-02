*&---------------------------------------------------------------------*
*& Include ZRSA20_25_TOP                            - Report ZRSA20_25
*&---------------------------------------------------------------------*
REPORT zrsa20_25.

*TYPE 선언
*TYPES: BEGIN OF ts_info,
*         carrid   TYPE sflight-carrid, "field 명을 동일하게 맞춤
*         connid   TYPE sflight-connid,
*         cityfrom TYPE spfli-cityfrom,
*         cityto   TYPE spfli-cityto,
*         fldate   TYPE sflight-fldate,
*       END OF ts_info,
*       tt_info TYPE TABLE OF ts_info. "Table Type

*Data Object
DATA: gt_info TYPE TABLE OF zssa2025,
      gs_info LIKE LINE OF gt_info.

*Selection Screen
PARAMETERS: pa_car  TYPE sflight-carrid,
            pa_con1 TYPE sflight-connid,
            pa_con2 TYPE sflight-connid.

*SELECT-OPTIONS so_con FOR gs_info-connid. "for 뒤에는 Variable "so_con은 일반적이지 않은 Internal Table
