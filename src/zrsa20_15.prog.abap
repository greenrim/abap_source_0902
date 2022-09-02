*&---------------------------------------------------------------------*
*& Report ZRSA20_15
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_15.

DATA: BEGIN OF gs_std,
        stdno    TYPE n LENGTH 8,
        sname    TYPE c LENGTH 40,
        gender   TYPE c LENGTH 1,
        gender_t TYPE c LENGTH 10,
      END OF gs_std.

DATA gt_std LIKE TABLE OF gs_std.

APPEND gs_std TO gt_std.

gs_std-stdno = '20220001'.
gs_std-sname = 'LEE'.
gs_std-gender = 'F'.

APPEND gs_std TO gt_std.                           "gs_std를 gt_std에 추가

CLEAR gs_std.
gs_std-sname = 'HAN'.
APPEND gs_std TO gt_std.
CLEAR gs_std.

LOOP AT gt_std INTO gs_std.
  gs_std-gender_t = 'Male'(t01). "structure 변수 값만 변경함
  MODIFY gt_std FROM gs_std. "INDEX sy-tabix.
  CLEAR gs_std.
ENDLOOP.

*  modify gt_std from gs_std INDEX 2.

cl_demo_output=>display_data( gt_std ).

CLEAR gs_std.
READ TABLE gt_std INDEX 1 INTO gs_std.

READ TABLE gt_std WITH KEY stdno = '20220001' gender = 'M' INTO gs_std.

*LOOP AT gt_std INTO gs_std.
*  WRITE: sy-tabiz, gs_std-stdno, gs_std-sname, gs_std-gender.
*  NEW-LINE.
*ENDLOOP.
*
*WRITE: /sy-tabix, gs_std-stdno, gs_std-sname, gs_std-gender.

*gs_std-stdno = '20220001'.
*gs_std-sname = 'LEE'.
*gs_std-gender = 'F'.
*
*APPEND gs_std TO gt_std.                           "gs_std를 gt_std에 추가
*
*CLEAR gs_std.
*gs_std-sname = 'HAN'.
*APPEND gs_std TO gt_std.
*
*cl_demo_output=>display_data( gt_std ).           "cl_demo_output은 class / display_data는 static method 이문법을  class라고 함
