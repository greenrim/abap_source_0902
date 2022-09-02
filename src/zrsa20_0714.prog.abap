*&---------------------------------------------------------------------*
*& Report ZRSA20_0714
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_0714.


PARAMETERS pa_score TYPE i.
DATA gv_score TYPE c LENGTH 2.

IF pa_score >= 90.
  IF pa_score = 95.
    gv_score = 'A+'.
  ELSE.
    gv_score = 'A'.
  ENDIF.

ELSEIF pa_score >= 80.
  gv_score = 'B'.
ELSE.
  gv_score = 'C'.
ENDIF.

WRITE gv_score.
