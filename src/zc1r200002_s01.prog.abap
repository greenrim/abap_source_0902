*&---------------------------------------------------------------------*
*& Include          ZC1R200002_S01
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-t01.
  PARAMETERS     pa_werks TYPE mast-werks OBLIGATORY DEFAULT '1010'.
  SELECT-OPTIONS so_matnr FOR  mast-matnr.
SELECTION-SCREEN END OF BLOCK bl1.
