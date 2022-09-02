*&---------------------------------------------------------------------*
*& Report ZSA201008
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsa201008.

TABLES : mara, marc, sscrfields.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-t01.
  PARAMETERS : pa_werk TYPE mkal-werks DEFAULT '1010',
               pa_bid  TYPE pbid-berid DEFAULT '1010',
               pa_pbdn TYPE pbid-pbdnr MODIF ID gr1,
               pa_vers TYPE pbid-versb DEFAULT '00' MODIF ID gr1.
SELECTION-SCREEN END OF BLOCK bl1.

SELECTION-SCREEN BEGIN OF BLOCK bl2 WITH FRAME TITLE TEXT-t02.

  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 3(5) FOR FIELD pa_crt.
    PARAMETERS pa_crt RADIOBUTTON GROUP rd1 USER-COMMAND click DEFAULT 'X'.

    SELECTION-SCREEN COMMENT 15(6) FOR FIELD pa_DIS.
    PARAMETERS pa_dis RADIOBUTTON GROUP rd1.
  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK bl2.


SELECTION-SCREEN BEGIN OF BLOCK bl3 WITH FRAME TITLE TEXT-t03.
  SELECT-OPTIONS : so_matn  FOR  mara-matnr MODIF ID gr2,
                   so_mtar  FOR  mara-mtart MODIF ID gr2,
                   so_matk  FOR  mara-matkl MODIF ID gr2.

  SELECT-OPTIONS : so_ekgr  FOR  marc-ekgrp MODIF ID gr2.
  PARAMETERS     : pa_disp TYPE marc-dispo MODIF ID gr2,
                   pa_dism TYPE marc-dismm MODIF ID gr2.
SELECTION-SCREEN END OF BLOCK bl3.

*DATA : gv_chg2, gv_chg3.

INITIALIZATION.
*  gv_chg2 = 1.
*  gv_chg3 = 0.

AT SELECTION-SCREEN OUTPUT.
  PERFORM modify_screen.


AT SELECTION-SCREEN.
*  CASE sscrfields-ucomm.
*    WHEN 'CLICK'.
*      CASE gv_chg2.
*        WHEN '1'.
*          gv_chg2 = 0.
*          gv_chg3 = 1.
*        WHEN '0'.
*          gv_chg2 = 1.
*          gv_chg3 = 0.
*      ENDCASE.
*  ENDCASE.

START-OF-SELECTION.
*&---------------------------------------------------------------------*
*& Form modify_screen
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM modify_screen .



  LOOP AT SCREEN.
    CASE screen-name.
      WHEN 'PA_PBDN' OR 'PA_VERS'.
        screen-input = 0.
        MODIFY SCREEN.
    ENDCASE.


    CASE 'X'.
      WHEN pa_crt.
        CASE screen-group1.
          WHEN 'GR1'.
            screen-active = 0.
            MODIFY SCREEN.
        ENDCASE.
      WHEN pa_disp.
        CASE screen-group1.
          WHEN 'GR2'.
            screen-active = 0.
            MODIFY SCREEN.
        ENDCASE.
    ENDCASE.
*        WHEN pa_crt.
*            screen-active = 1.
*          WHEN pa_dis.
*            screen-active = 0.
*        ENDCASE.

  ENDLOOP.

*    CASE screen-group1.


*      WHEN 'GR2'.
*        CASE 'X'.
*          WHEN pa_crt.
*            screen-active = 1.
*          WHEN pa_dis.
*            screen-active = 0.
*        ENDCASE.
*
*      WHEN 'GR3'.
*        CASE 'X'.
*          WHEN pa_crt.
*            screen-active = 0.
*          WHEN pa_dis.
*            screen-active = 1.
*        ENDCASE.
*
*    ENDCASE.
*
*    MODIFY SCREEN.
*
*  ENDLOOP.


  "내가 작성한 코드
*  LOOP AT SCREEN.
*    CASE screen-group1.
*      WHEN 'GR1'.
*        screen-input  = ''.
*
*      WHEN 'GR2'.
*        CASE 'X'.
*          WHEN pa_crt.
*            screen-active = 1.
*          WHEN pa_dis.
*            screen-active = 0.
*        ENDCASE.
*
*      WHEN 'GR3'.
*        CASE 'X'.
*          WHEN pa_crt.
*            screen-active = 0.
*          WHEN pa_dis.
*            screen-active = 1.
*        ENDCASE.
*
*    ENDCASE.
*
*    MODIFY SCREEN.
*
*  ENDLOOP.
ENDFORM.
