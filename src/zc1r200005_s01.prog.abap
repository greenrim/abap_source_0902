*&---------------------------------------------------------------------*
*& Include          ZC1R200005_S01
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-t01.

  PARAMETERS     : pa_bukr TYPE bkpf-bukrs OBLIGATORY, " DEFAULT '1010',
                   pa_gjah TYPE bkpf-gjahr OBLIGATORY.

  SELECT-OPTIONS : so_beln   FOR  bkpf-belnr,
                   so_blar   FOR  bkpf-blart.

SELECTION-SCREEN END OF BLOCK bl1.
