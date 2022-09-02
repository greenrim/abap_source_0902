*&---------------------------------------------------------------------*
*& Report ZRSA20_REVIEW
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_review.

DATA : BEGIN OF gs_std,
         stdno    TYPE n LENGTH 8,
         sname    TYPE c LENGTH 40,
         gender   TYPE c LENGTH 1,
         gender_t TYPE c LENGTH 10,
       END OF gs_std,
       gt_std LIKE TABLE OF gs_std.

gs_std-stdno = '20220001'.
gs_std-sname = 'LEE'.
gs_std-gender = 'F'.

APPEND gs_std TO gt_std.

PARAMETERS: pa_stdno LIKE gs_std-stdno,
            pa_sname LIKE gs_std-sname,
            pa_gen   LIKE gs_std-gender.

PERFORM add_internaltable USING pa_stdno pa_sname pa_gen
                          CHANGING gt_std.

"gs_std를 gt_std에 추가

CLEAR gs_std.

LOOP AT gt_std INTO gs_std.
  CASE gs_std-gender.
    WHEN 'M'.
      gs_std-gender_t = 'Male'(t01).
    WHEN 'F'.
      gs_std-gender_t = 'Female'(t02).
    WHEN OTHERS.
      gs_std-gender_t = 'Undefined'(t03).
  ENDCASE.

  MODIFY gt_std FROM gs_std INDEX sy-tabix.
*  WRITE gs_std.
*  NEW-LINE.
  CLEAR gs_std.
ENDLOOP.

gs_std-stdno = '20220001'.
gs_std-sname = 'LEE'.
gs_std-gender = 'F'.

MODIFY gt_std FROM gs_std INDEX 2.

READ TABLE gt_std INDEX 1 INTO gs_std.
WRITE gs_std.


cl_demo_output=>display_data( gt_std ).
*
*CLEAR gs_std.
*READ TABLE gt_std INDEX 1 INTO gs_std.
*
*READ TABLE gt_std WITH KEY stdno = '20220001' gender = 'M' INTO gs_std.

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
*cl_demo_output=>display_data( gt_std ).

*cl_demo_output=>display_data( gt_std ).
*&---------------------------------------------------------------------*
*& Form add_internaltable
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM add_internaltable USING VALUE(p_stdno)
                             VALUE(p_sname)
                             VALUE(p_gender)
                       CHANGING VALUE(p_std) LIKE gt_std.
  MOVE p_stdno TO gs_std-stdno.
  MOVE p_sname TO gs_std-sname.
  MOVE p_gender TO gs_std-gender.

  APPEND gs_std TO p_std.


ENDFORM.
