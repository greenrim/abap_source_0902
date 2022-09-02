*&---------------------------------------------------------------------*
*& Report ZRSA20_06
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_06.

PARAMETERS pa_i TYPE i.
DATA gv_result LIKE pa_i.

**10보다 크면 출력
**20보다 크다면, 10 추가로 더해서 출력하세요.

*IF pa_i > 20.
*
*ELSEIF pa_i > 10.
*
*ELSE.
*
*ENDIF.
*
*IF pa_i > 20.
*
*ELSE.
*  IF pa_i > 10.
*
*  ENDIF.
*ENDIF.
*
*IF pa_i > 20.
*
*ENDIF.
*
*IF pa_i > 10.
*
*ENDIF.


IF pa_i > 20.
  gv_result = pa_i + 10.
  WRITE gv_result.
ELSE.
  IF pa_i > 10.
    WRITE pa_i.
  ENDIF.
ENDIF.

IF pa_i > 20.
  gv_result = pa_i + 10.
  WRITE gv_result.
ENDIF.

IF pa_i > 10.
  WRITE pa_i.
ENDIF.

**10보다 크면 출력
**20보다 크다면, 10 추가로 더해서 출력하세요.
*IF pa_i > 20.
*  gv_i = pa_i + 10.
*  WRITE gv_i.
*
*ELSEIF pa_i > 10.
*  WRITE pa_i.
*ENDIF.
