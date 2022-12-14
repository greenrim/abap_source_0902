*&---------------------------------------------------------------------*
*& Include          MZSA2003_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_airline_name
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GV_CARRID
*&      <-- GV_CARRNAME
*&---------------------------------------------------------------------*
FORM get_airline_name  USING VALUE(p_code)
                       CHANGING VALUE(p_text).

  CLEAR p_text.
  SELECT SINGLE carrname
    FROM scarr
    INTO p_text             "정확히 1대1인 경우 필드 명칭이 같지 않아도 됨
    WHERE carrid = p_code.

ENDFORM.
