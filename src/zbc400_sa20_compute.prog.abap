*&---------------------------------------------------------------------*
*& Report ZBC400_SA20_COMPUTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc400_sa20_compute.

PARAMETERS: pa_int1 TYPE i,
            pa_int2 LIKE pa_int1,
            pa_op   TYPE c.

DATA gv_result TYPE p DECIMALS 2.


PERFORM compute USING pa_int1 pa_int2 pa_op
                CHANGING gv_result.

*WRITE: '계산 결과: ', gv_result.

*&---------------------------------------------------------------------*
*& Form compute
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM compute USING VALUE(p_int1) TYPE i VALUE(p_int2) TYPE i VALUE(p_op) TYPE c
             CHANGING p_result.

  CASE p_op.
    WHEN '+'.
      p_result = p_int1 + p_int2.
    WHEN '-'.
      p_result = p_int1 - p_int2.
    WHEN '/'.
      IF p_int2 IS INITIAL.
        MESSAGE '두번째 값을 다시 입력하세요.' TYPE 'E'.
*      EXIT.
      ELSE.
        p_result = p_int1 / p_int2.
      ENDIF.
    WHEN '*'.
      p_result = p_int1 * p_int2.
    WHEN OTHERS.
      MESSAGE '두번째 값을 다시 입력하세요.' TYPE 'E'.
  ENDCASE.
  WRITE: '계산 결과: ', p_result.

ENDFORM.

*
*CASE pa_op.
*  WHEN '+'.
*    gv_result = pa_int1 + pa_int2.
*  WHEN '-'.
*    gv_result = pa_int1 - pa_int2.
*  WHEN '/'.
*    IF pa_int2 IS INITIAL.
*      MESSAGE '두번째 값을 다시 입력하세요.' TYPE 'E'.
**      EXIT.
*    ELSE.
*      gv_result = pa_int1 / pa_int2.
*    ENDIF.
*  WHEN '*'.
*    gv_result = pa_int1 + pa_int2.
*  WHEN OTHERS.
*    MESSAGE '두번째 값을 다시 입력하세요.' TYPE 'E'.
*ENDCASE.
*WRITE: '계산 결과: ', gv_result.
