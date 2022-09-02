*&---------------------------------------------------------------------*
*& Report ZRSA20_12
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_12.

DATA gv_carrname TYPE scarr-carrname.
PARAMETERS pa_carr TYPE scarr-carrid.

PERFORM sel_carrname USING pa_carr
                     CHANGING gv_carrname.

WRITE gv_carrname.
*&---------------------------------------------------------------------*
*& Form sel_carrname
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM sel_carrname USING p_carr
                  CHANGING p_carrname.
  p_carr = 'UA'.
  SELECT SINGLE carrname
    FROM scarr
    INTO p_carrname
    WHERE carrid = p_carr.
  WRITE 'Test p_carr:'.
  WRITE pa_carr.

ENDFORM.
