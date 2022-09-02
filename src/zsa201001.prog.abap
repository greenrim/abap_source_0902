*&---------------------------------------------------------------------*
*& Module Pool      ZSA201001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zsa201001_top                           .    " Global Data

* INCLUDE ZSA201001_O01                           .  " PBO-Modules
* INCLUDE ZSA201001_I01                           .  " PAI-Modules
* INCLUDE ZSA201001_F01                           .  " FORM-Routines


*"1교시
*gv_name = 'ABCDEFGHIJ' .
*gv_num1 = '111.25' .
*gv_num2 = '365'.
*WRITE : gv_name, / gv_num1, / gv_num2.

*"3교시
*SELECT carrid connid fldate bookid customid invoice class smoker
*  FROM sbook
*  INTO CORRESPONDING FIELDS OF TABLE gt_sbook
*  WHERE carrid   = 'DL'
*  AND custtype   = 'P'
*  AND order_date = '20201227'.
*
*IF sy-subrc <> 0.
*  MESSAGE i001(zmcsa20).
*  LEAVE LIST-PROCESSING. "STOP과 동일
*ENDIF.
*
*CLEAR gs_sbook.
*
*LOOP AT gt_sbook INTO gs_sbook.
*  gv_tabix = sy-tabix.
**  IF gs_sbook-smoker = 'X' AND gs_sbook-invoice = 'X'.
**    gs_sbook-class = 'F'.
**  ENDIF.
*
*  CASE gs_sbook-smoker.
*    WHEN 'X'.
*      CASE gs_sbook-invoice.
*        WHEN 'X'.
*          gs_sbook-class = 'F'.
*
*          MODIFY gt_sbook FROM gs_sbook INDEX gv_tabix
*                                        TRANSPORTING class.
*          CLEAR gs_sbook.
*      ENDCASE.
*  ENDCASE.
*ENDLOOP.
*
*cl_demo_output=>display_data( gt_sbook ).

*"3교시 SFLIGHT
*CLEAR gt_sflight.
*
*SELECT carrid connid fldate currency planetype seatsocc_b
*  FROM sflight
*  INTO CORRESPONDING FIELDS OF TABLE gt_sflight
*  WHERE currency   = 'USD'
*  AND   planetype  = '747-400'.
*
*CLEAR : gs_sflight, gv_tabix.
*
*IF sy-subrc <> 0.
*  MESSAGE i001(zmcsa20).
*  LEAVE LIST-PROCESSING.
*ENDIF.
*
*LOOP AT gt_sflight INTO gs_sflight.
*
*  gv_tabix = sy-tabix.
*  CASE gs_sflight-carrid.
*    WHEN 'UA'.
*      gs_sflight-seatsocc_b = gs_sflight-seatsocc_b + 5.
*      MODIFY gt_sflight FROM gs_sflight
*                        INDEX gv_tabix
*                        TRANSPORTING seatsocc_b.
*  ENDCASE.
*  CLEAR gs_sflight.
*
*ENDLOOP.
*
*cl_demo_output=>display_data( gt_sflight ).

"5교시 MARA
*
*CLEAR : gt_mara, gt_makt, gs_mara, gs_makt.
*
*SELECT matnr mtart matkl
*  FROM mara
*  INTO CORRESPONDING FIELDS OF TABLE gt_mara.
*
*SELECT matnr maktx
*  FROM makt
*  INTO CORRESPONDING FIELDS OF TABLE gt_makt
*  WHERE spras = sy-langu.
*
*CLEAR : gs_mara, gv_tabix.
*
*LOOP AT gt_mara INTO gs_mara.
*
*  gv_tabix = sy-tabix.
*
*  CLEAR gs_makt.
*  READ TABLE gt_makt INTO gs_makt WITH KEY matnr = gs_mara-matnr.
*
*  IF sy-subrc = 0.
*    gs_mara-maktx = gs_makt-maktx.
*    MODIFY gt_mara FROM gs_mara INDEX gv_tabix TRANSPORTING maktx.
*  ENDIF.
*  CLEAR gs_mara.
*ENDLOOP.
*
*cl_demo_output=>display_data( gt_mara ).

*"6교시 SPFLI
*
*CLEAR : gt_spfli, gt_scarr.
*
*SELECT carrid connid airpfrom airpto deptime arrtime
*  FROM spfli
*  INTO CORRESPONDING FIELDS OF TABLE gt_spfli.
*
*SELECT carrid carrname url
*  FROM scarr
*  INTO CORRESPONDING FIELDS OF TABLE gt_scarr.
*
*CLEAR : gs_spfli, gv_tabix.
*LOOP AT gt_spfli INTO gs_spfli.
*  gv_tabix = sy-tabix.
*
*  CLEAR gs_scarr.
*
*  READ TABLE gt_scarr INTO gs_scarr WITH KEY carrid = gs_spfli-carrid.
*
*  IF sy-subrc = 0.
*
*    gs_spfli-carrname = gs_scarr-carrname.
*    gs_spfli-url      = gs_scarr-url.
*
*    MODIFY gt_spfli FROM gs_spfli INDEX gv_tabix TRANSPORTING carrname url.
*    CLEAR gs_spfli.
*  ENDIF.
*
*ENDLOOP.
*
*cl_demo_output=>display_data( gt_spfli ).

"7교시 TEXT TABLE

*DATA :gt_data LIKE TABLE OF gt_data,
*      gt_t134t LIKE TABLE OF gs_t134t,
*      gt_t137t LIKE TABLE OF gs_t137t,
*       gt_TTGRT LIKE TABLE OF gs_TTGRT.

CLEAR : gt_data, gt_t134t, gt_t137t, gt_TTGRT.

SELECT a~matnr b~maktx mtart mbrsh tragr
  FROM mara AS a INNER JOIN makt AS b
  ON a~matnr = b~matnr
  INTO CORRESPONDING FIELDS OF TABLE gt_data
  WHERE b~spras = sy-langu.

SELECT mtart mtbez
  FROM t134t
  INTO CORRESPONDING FIELDS OF TABLE gt_t134t
  WHERE spras = sy-langu.

SELECT mbrsh mbbez
 FROM t137t
 INTO CORRESPONDING FIELDS OF TABLE gt_t137t
 WHERE spras = sy-langu.

SELECT tragr vtext
  FROM ttgrt
  INTO CORRESPONDING FIELDS OF TABLE gt_TTGRT
  WHERE spras = sy-langu.

CLEAR gs_data.
LOOP AT gt_data INTO gs_data.
  gv_tabix = sy-tabix.

  CLEAR gs_t134t.
  READ TABLE gt_t134t INTO gs_t134t WITH KEY mtart = gs_data-mtart.
  IF sy-subrc = 0.
    gs_data-mtbez = gs_t134t-mtbez.
  ENDIF.

  CLEAR gs_t137t.
  READ TABLE gt_t137t INTO gs_t137t WITH KEY mbrsh = gs_data-mbrsh.
  IF sy-subrc = 0.
    gs_data-mbbez = gs_t137t-mbbez.
  ENDIF.

  CLEAR gs_TTGRT.
  READ TABLE gt_TTGRT INTO gs_TTGRT WITH KEY tragr = gs_data-tragr.
  IF sy-subrc = 0.
    gs_data-vtext = gs_TTGRT-vtext.
  ENDIF.

  MODIFY gt_data FROM gs_data INDEX gv_tabix TRANSPORTING mtbez mbbez vtext.
  CLEAR gs_Data.
ENDLOOP.

cl_demo_output=>display_data( gt_data ).
