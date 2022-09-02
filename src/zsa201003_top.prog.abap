*&---------------------------------------------------------------------*
*& Include ZSA201003_TOP                            - Report ZSA201003
*&---------------------------------------------------------------------*
REPORT zsa201003.

TABLES sbuspart.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-t01.

  PARAMETERS     pa_bus TYPE sbuspart-buspartnum OBLIGATORY.
  SELECT-OPTIONS so_con FOR  sbuspart-contact    NO INTERVALS.

SELECTION-SCREEN END OF BLOCK bl1.

SELECTION-SCREEN BEGIN OF BLOCK bl2 WITH FRAME TITLE TEXT-t02.
  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 1(5) FOR FIELD pa_ta.
    PARAMETERS pa_ta RADIOBUTTON GROUP gr1 DEFAULT 'X'.

    SELECTION-SCREEN COMMENT 20(5) FOR FIELD pa_fc.
    PARAMETERS pa_fc RADIOBUTTON GROUP gr1.

  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK bl2.


DATA : gs_sbuspart  TYPE sbuspart,
       gt_sbuspart  LIKE TABLE OF gs_sbuspart,
       gv_buspartyp TYPE sbuspart-buspatyp.
