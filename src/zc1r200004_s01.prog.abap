*&---------------------------------------------------------------------*
*& Include          ZC1R200004_S01
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK BL1 WITH FRAME TITLE TEXT-T01.
  SELECT-OPTIONS : SO_CARR FOR SCARR-CARRID,
                   SO_CONN FOR SFLIGHT-CONNID,
                   SO_PLAN FOR SFLIGHT-PLANETYPE NO INTERVALS NO-EXTENSION.
  SELECTION-SCREEN END OF BLOCK BL1.
