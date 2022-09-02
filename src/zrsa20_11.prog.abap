*&---------------------------------------------------------------------*
*& Report ZRSA20_11
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_11.

DATA : gv_a TYPE sy-datum,
       gv_b LIKE gv_a,
       gv_c LIKE gv_a,
       gv_d LIKE gv_a.

*gv_a = sy-datum + 7.
*gv_b = sy-datum + 14.
*gv_c = sy-datum + 21.
*gv_d = sy-datum + 28.

"Cal Date
PERFORM cal_date USING sy-datum '7'
                 CHANGING gv_a.

PERFORM cal_date USING sy-datum '14'
                 CHANGING gv_b.

PERFORM cal_date USING sy-datum '21'
                 CHANGING gv_c.

PERFORM cal_date USING sy-datum '28'
                 CHANGING gv_d.

PERFORM display_data.

*&---------------------------------------------------------------------*
*& Form cal_date_new
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> SY_DATUM
*&      --> P_
*&      <-- GV_D
*&---------------------------------------------------------------------*
*FORM cal_date_new  USING    p_datum
*                            VALUE(p_days)
*                   CHANGING p_new date.

*ENDFORM.
*&---------------------------------------------------------------------*
*& Form cal_date
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM cal_date USING VALUE(p_date)
                    VALUE(p_days)
              CHANGING VALUE(p_new_date).
  p_new_date = p_date + p_days.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form display_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_data .
  WRITE : gv_a, gv_b, gv_c, gv_d.
ENDFORM.
