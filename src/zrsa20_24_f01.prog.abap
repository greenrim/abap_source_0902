*&---------------------------------------------------------------------*
*& Include          ZRSA20_24_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_fligt_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_fligt_info USING VALUE(p_car)
                          VALUE(p_con1)
                          VALUE(p_con2)
                    CHANGING VALUE(pt_info) LIKE gt_info.

  SELECT carrid connid fldate price currency
     seatsmax seatsocc seatsmax_b seatsocc_b seatsmax_f seatsocc_f "-> *로 해도 되지않을까유
     FROM sflight
     INTO CORRESPONDING FIELDS OF TABLE pt_info
     WHERE carrid = p_car
     AND connid BETWEEN p_con1 AND p_con2.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_carrname
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_carrname USING VALUE(p_car)
                  CHANGING VALUE(p_carrname).
  SELECT SINGLE carrname
  FROM scarr
  INTO p_carrname
  WHERE carrid = p_car.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_connection
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_connection USING VALUE(p_car)
                          VALUE(p_con1)
                          VALUE(p_con2)
                    CHANGING VALUE(pt_city) LIKE gt_city.
  SELECT carrid connid cityfrom cityto
  FROM spfli
  INTO CORRESPONDING FIELDS OF TABLE pt_city
  WHERE carrid = p_car
  AND connid BETWEEN p_con1 AND p_con2.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_searremain
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_seatremain using value(p_max)
                          value(p_socc)
                    changing value(p_remain).

   IF gs_info-seatsocc <> 0.
      p_remain = p_max - p_socc.
    ELSE.
      p_remain = 0.
    ENDIF.

ENDFORM.
