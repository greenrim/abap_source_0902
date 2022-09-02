*&---------------------------------------------------------------------*
*& Report ZRSA20_23
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_23.

DATA: gs_info TYPE zsinfo,
      gt_info LIKE TABLE OF gs_info.

PARAMETERS : pa_carr1 TYPE spfli-carrid,
             pa_carr2 LIKE pa_carr1.

SELECT carrid connid cityfrom cityto
  FROM spfli
  INTO CORRESPONDING FIELDS OF TABLE gt_info
  WHERE carrid BETWEEN pa_carr1 AND pa_carr2.

LOOP AT gt_info INTO gs_info.
  "#1 SELECT SINGLE문을 이용
  SELECT SINGLE carrname
    FROM scarr
    INTO CORRESPONDING FIELDS OF gs_info
    WHERE carrid = gs_info-carrid.

  MODIFY gt_info FROM gs_info.
  CLEAR gs_info.
ENDLOOP.

cl_demo_output=>display_data( gt_info ).
