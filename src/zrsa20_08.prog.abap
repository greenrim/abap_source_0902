*&---------------------------------------------------------------------*
*& Report ZRSA20_08
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_08.

PARAMETERS ps_code TYPE c LENGTH 4 DEFAULT 'SYNC'.
PARAMETERS pa_date TYPE  sy-datum. "sy-datum은 시스템변수 앞에서 sy로 시작하면 시스템변수
DATA : gv_cond_d1 LIKE pa_date,
      gv_cond_d2 LIKE pa_date.

WRITE pa_date.

*gv_cond_d1 = sy-datum. "오늘의 날짜를 변수로 갖음
gv_cond_d1 = sy-datum + 7.
gv_cond_d2 = sy-datum - 7.

CASE ps_code.
  WHEN 'SYNC'.

  WHEN OTHERS.
    WRITE '다음기회에 수강'.
    EXIT. "또는 RETURN.
ENDCASE.

IF pa_date > gv_cond_d1.
  WRITE 'ABAP Dictionary'(t02).
ELSE.
  WRITE 'ABAP Workbaench'(t01).
ENDIF.
