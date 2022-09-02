*&---------------------------------------------------------------------*
*& Report ZRSA20_09
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_09.

DATA gv_d TYPE sy-datum.

gv_d = sy-datum - 365.

CLEAR gv_d.

IF gv_d IS INITIAL. "= '00000000'.
  WRITE 'No Date'.
ELSE.
  WRITE 'Exist Date'.
ENDIF.

*data gv_cnt type i.
*DO 10 TIMES.
*  gv_cnt = gv_cnt + 1.
*  write sy-index.
*  DO 5 TIMES.
*
*    WRITE sy-index.
*  ENDDO.
*NEW-LINE.
*ENDDO.
*
*write gv_cnt.
