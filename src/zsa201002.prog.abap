*&---------------------------------------------------------------------*
*& Report ZSA201002
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsa201002.

DATA gv_tabix TYPE sy-tabix.

DATA : BEGIN OF gs_data,
         ktopl TYPE ska1-ktopl,
         ktplt TYPE t004t-ktplt,
         saknr TYPE ska1-saknr,
         txt50 TYPE skat-txt50,
         ktoks TYPE ska1-ktoks,
         txt30 TYPE t077z-txt30,
       END OF gs_data,

       gt_Data LIKE TABLE OF gs_data,

       BEGIN OF gs_t4004t,
         ktopl TYPE t004t-ktplt,
         ktplt TYPE t004t-ktplt,
       END OF gs_t4004t,

       gt_t4004t LIKE TABLE OF gs_t4004t,

       BEGIN OF gs_skat,
         ktopl TYPE skat-ktopl,
         saknr TYPE skat-saknr,
         txt50 TYPE skat-txt50,
       END OF gs_skat,

       gt_skat LIKE TABLE OF gs_skat,

       BEGIN OF gs_t077z,
         ktoks TYPE t077z-ktoks,
         ktopl TYPE t077z-ktopl,
         txt30 TYPE t077z-txt30,
       END OF gs_t077z,

       gt_t077z LIKE TABLE OF gs_t077z.

SELECT ktopl saknr ktoks
  FROM ska1
  INTO CORRESPONDING FIELDS OF TABLE gt_data
  WHERE ktopl = 'WEG'.

SELECT ktopl ktplt
  FROM t004t
  INTO CORRESPONDING FIELDS OF TABLE gt_t4004t
  WHERE ktopl = 'WEG'
  AND   spras = sy-langu.

SELECT ktopl saknr txt50
  FROM skat
  INTO CORRESPONDING FIELDS OF TABLE gt_skat
  WHERE ktopl = 'WEG'
  AND   spras = sy-langu.

SELECT ktoks ktopl txt30
  FROM t077z
  INTO CORRESPONDING FIELDS OF TABLE gt_t077z
  WHERE ktopl = 'WEG'
  AND   spras = sy-langu.

LOOP AT gt_data INTO gs_data.
  gv_tabix = sy-tabix.

  CLEAR gs_t4004t.

  READ TABLE gt_t4004t INTO gs_t4004t
  WITH KEY   ktopl = gs_data-ktopl.

  IF sy-subrc = 0.
    gs_data-ktplt = gs_t4004t-ktplt.

    MODIFY gt_data FROM gs_data INDEX gv_tabix TRANSPORTING ktplt.

  ENDIF.

  CLEAR gs_skat.

  READ TABLE gt_skat INTO gs_skat
  WITH KEY   ktopl = gs_data-ktopl
             saknr = gs_data-saknr.

  IF sy-subrc = 0.
    gs_data-txt50 = gs_skat-txt50.

    MODIFY gt_data FROM gs_data INDEX gv_tabix TRANSPORTING txt50.

  ENDIF.

  CLEAR gs_t077z.
  READ TABLE gt_t077z INTO gs_t077z
  WITH KEY   ktopl = gs_data-ktopl
             ktoks = gs_data-ktoks.

  IF sy-subrc = 0.
    gs_data-txt30 = gs_t077z-txt30.

    MODIFY gt_data FROM gs_data INDEX gv_tabix TRANSPORTING txt30.

  ENDIF.

ENDLOOP.

cl_demo_output=>display_data( gt_data ).
