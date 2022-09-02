*&---------------------------------------------------------------------*
*& Report ZRCA20_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrca20_02.

DATA gv_step TYPE i.
DATA gv_cal LIKE gv_step.
DATA gv_lev LIKE gv_cal.
PARAMETERS pa_req LIKE gv_lev. "LIKE 다음에는 이미 선언된 변수가 옴.
PARAMETERS pa_syear(1) TYPE c.
DATA gv_new_lev LIKE gv_lev.

CASE pa_syear.
  WHEN '1' OR '2' OR '3' OR '4' OR '5' OR '6'.
    IF pa_req >= 3.
      gv_new_lev = 3.
    ELSE.
      gv_new_lev = pa_req.
    ENDIF.
  WHEN OTHERS.
    MESSAGE 'MESSAGE tEST' TYPE 'X'. "이런게 sap의 메세지야 라는 것만 이해하면 됨.

ENDCASE.
WRITE 'Time Table'. "메세지 출력 후 아래 라인을 타기 때문에 출력하는 문장을 넣은 것.
NEW-LINE.
DO gv_new_lev TIMES. "pa_req만큼만 반복할거야.
  gv_lev = gv_lev + 1.
  CLEAR gv_step.
  DO 9 TIMES.
    gv_step = gv_step + 1.
    CLEAR gv_cal.
    gv_cal = gv_lev * gv_step.
    WRITE : gv_lev,' * ',gv_step, '=', gv_cal.
    NEW-LINE.
  ENDDO.
  CLEAR gv_step.
  WRITE '============='. "단 구분을 위해
  NEW-LINE.
ENDDO.
"프로그램이 끝난 후에는 gv_cal에는 제일 마지막 계산값이 남아있음.
