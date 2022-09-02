*&---------------------------------------------------------------------*
*& Report ZRSA20_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_01.

PARAMETERS pa_carr TYPE scarr-carrid.
DATA gs_scarr TYPE scarr.

*PERFORM get_data.

SELECT SINGLE * FROM scarr
   INTO gs_scarr
   WHERE carrid = pa_carr.

IF sy-subrc IS INITIAL. "sy-subrc = 0.
  NEW-LINE.
  WRITE : gs_scarr-carrid,
  gs_scarr-carrname,
  gs_scarr-url.

ELSE.
  WRITE TEXT-t03. "Sorry, no data found!
  WRITE 'Sorry, no data found!'(t01).
*    MESSAGE 'Sorry, no data found!' TYPE 'I'.
ENDIF.

*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
*FORM get_data .
*  SELECT SINGLE * FROM scarr
*    INTO gs_scarr
*    WHERE carrid = pa_carr.
*
*  IF sy-subrc = 0.
*    NEW-LINE.
*    WRITE : gs_scarr-carrid,
*    gs_scarr-carrname,
*    gs_scarr-url.
*
*  ELSE.
*    WRITE 'Sorry, no data found!'.
**    MESSAGE 'Sorry, no data found!' TYPE 'I'.
*  ENDIF.
*ENDFORM.
