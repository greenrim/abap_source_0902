*&---------------------------------------------------------------------*
*& Include          ZSA201009_S01
*&---------------------------------------------------------------------*


SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-t01.
  PARAMETERS     pa_werk TYPE mast-werks OBLIGATORY DEFAULT '1010'.
  SELECT-OPTIONS so_matn FOR  mast-MATNR.
SELECTION-SCREEN END OF BLOCK bl1.
