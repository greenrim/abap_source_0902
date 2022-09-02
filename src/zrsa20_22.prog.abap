*&---------------------------------------------------------------------*
*& Report ZRSA20_22
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_22.

DATA: gs_list TYPE scarr,
      gt_list LIKE TABLE OF gs_list.

CLEAR: gt_list, gs_list.

*SELECT *
*  FROM scarr
*  INTO CORRESPONDING FIELDS OF gs_list
*  WHERE carrid BETWEEN 'ZZ' AND 'UA'.     "carrid 'AA'부터 'UA'까지 문자여서 순서 있음
*  APPEND gs_list TO gt_list.
*  CLEAR gs_list.
*ENDSELECT.

SELECT carrid carrname
  FROM scarr
  INTO CORRESPONDING FIELDS OF TABLE gt_list
  WHERE carrid BETWEEN 'AA' AND 'UA'.

WRITE sy-subrc.
WRITE sy-dbcnt.

cl_demo_output=>display_data( gt_list ).
