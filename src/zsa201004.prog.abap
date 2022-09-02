*&---------------------------------------------------------------------*
*& Module Pool      ZSA201004
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zsa201004_top                           .    " Global Data

* INCLUDE ZSA201004_O01                           .  " PBO-Modules
* INCLUDE ZSA201004_I01                           .  " PAI-Modules
* INCLUDE ZSA201004_F01                           .  " FORM-Routines

INITIALIZATION.

  so_fld-low    = sy-datum.
  so_fld-option = 'GT'.
  so_fld-sign   = 'I'.
  APPEND so_fld.

AT SELECTION-SCREEN OUTPUT.

AT SELECTION-SCREEN.

START-OF-SELECTION.

  CLEAR gt_sbook.

  SELECT carrid connid fldate bookid customid custtype invoice class
    FROM sbook
    INTO CORRESPONDING FIELDS OF TABLE gt_sbook
    WHERE carrid   =  pa_car
    AND   connid   IN so_con
    AND   custtype =  pa_cus
    AND   fldate   IN so_fld
    AND   bookid   IN so_bid
    AND   customid IN so_cid.

  IF sy-subrc <> 0.
    MESSAGE i001(zmcsa20).
    LEAVE LIST-PROCESSING.
  ENDIF.

  CLEAR : gs_sbook, gv_tabix.

  LOOP AT gt_sbook INTO gs_sbook.
    gv_tabix = sy-tabix.

    CASE gs_sbook-invoice.
      WHEN 'X'.
        gs_sbook-class = 'F'.
        MODIFY gt_sbook FROM gs_sbook INDEX gv_tabix TRANSPORTING class.
    ENDCASE.

    CLEAR gs_sbook.
  ENDLOOP.

  cl_demo_output=>display_data( gt_sbook ).
