*&---------------------------------------------------------------------*
*& Include          ZSA2010_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_airline_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_airline_info .

  CLEAR zssa2081.                           "Data 저장 전에 clear
  SELECT SINGLE *
    FROM scarr
    INTO CORRESPONDING FIELDS OF zssa2081
    WHERE carrid = zssa2080-carrid.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_conn_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA2080_CARRID
*&      --> ZSSA2080_CONNID
*&      <-- ZSSA2082
*&---------------------------------------------------------------------*
FORM get_conn_info  USING    VALUE(p_carrid)
                             VALUE(p_connid)
                    CHANGING ps_info TYPE zssa2082
                             p_subrc.
  CLEAR: zssa2081, ps_info, p_subrc.    "처음에 성공했다고 해주기?

  SELECT SINGLE *
    FROM spfli
    INTO CORRESPONDING FIELDS OF ps_info
    WHERE carrid = p_carrid
    AND connid = p_connid.

  IF sy-subrc IS NOT INITIAL.
    p_subrc = 4. "4가 가장 흔하게 사용하는 ERROR CODE "sy-subrc.
*    MESSAGE i016(pn) WITH 'Please enter the Flight Number'.
    RETURN.
  ENDIF.

  "Get Airline Info
  PERFORM get_airline_info.



ENDFORM.
