*&---------------------------------------------------------------------*
*& Report ZRSA20_07
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_07.

PARAMETERS ps_code TYPE c LENGTH 4 DEFAULT 'SYNC'.
PARAMETERS pa_date TYPE sy-datum.

DATA gv_result TYPE string.
DATA :gv_today   LIKE pa_date,
      gv_cond_d1 LIKE pa_date,
      gv_cond_d2 LIKE pa_date,
      gv_cond_d3 LIKE pa_date.

gv_today = sy-datum.
gv_cond_d1 = gv_today + 7.
gv_cond_d2 = gv_today - 7.
gv_cond_d3 = gv_today + 365.

CASE ps_code.
  WHEN 'SYNC'.
    IF pa_date > gv_cond_d1.
      gv_result = 'ABAP Dictionary'.
    ELSEIF pa_date < gv_cond_d2.
      gv_result = 'SAPUI5'.
    ELSEIF pa_date > gv_cond_d3.
      gv_result = '취업'.
    ELSEIF pa_date < '20220620'.
      gv_result = '교육 준비중'.
    ELSE.
      gv_result = 'ABAP Dictionary'.
    ENDIF.
  WHEN OTHERS.
    WRITE '다음기회에'.
ENDCASE.

WRITE gv_result.
