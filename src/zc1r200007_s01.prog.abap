*&---------------------------------------------------------------------*
*& Include          ZC1R200007_S01
*&---------------------------------------------------------------------*


TABLES : MARC, MARA.
SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-t01.
PARAMETERS pa_werk TYPE MARC-WERKS OBLIGATORY DEFAULT '1010'.
SELECT-OPTIONS so_matn for mara-matnr.
SELECT-OPTIONS so_mtar for mara-mtart.
SELECT-OPTIONS so_ekgr for marc-ekgrp.
SELECTION-SCREEN END OF BLOCK bl1.
