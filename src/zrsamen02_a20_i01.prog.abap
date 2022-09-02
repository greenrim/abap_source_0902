*&---------------------------------------------------------------------*
*& Include          ZRSAMEN02_A20_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'ENTER'.

    WHEN 'SEL'.

*  "update 버전을 바꿀 경우 기존 버전에서 변경한 내역을 gt_data_ins에 저장해야하나...
*  LOOP AT gt_data INTO gs_data WHERE modified = 'X'.
*    read table gs_data_mod into gs_data_mod with key vendor = gs_data-vendor version = gs_data-version pcode = gs_data-pcode.
*
*    gs_data_mod-vendor = gs_data-vendor.
*    gs_data_mod-version = gs_data-version.
*    gs_data_mod-pcode   = gs_data-pcode.
*    gs_data_mod-order_unit = gs_data-order_unit.
*
*    APPEND gs_data_mod TO gt_data_mod.
*  ENDLOOP.
*
*  MODIFY ztvermata20 FROM TABLE lt_data_mod.

    WHEN 'SAVE'.
      DATA lv_ans.
      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
          titlebar              = '확인'
          text_question         = '변경 내용을 TABLE에 반영하시겠습니까?'
          text_button_1         = '저장'(001)
          text_button_2         = '저장 안 함'(002)
          default_button        = '1'
          display_cancel_button = 'X'
        IMPORTING
          answer                = lv_ans.
      CASE lv_ans.
        WHEN '1'.
          PERFORM data_save.
          MESSAGE S016(PN) WITH '저장이 완료되었습니다.'.
      ENDCASE.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHECK_LISTBOX  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_listbox INPUT.

  IF ztversa20-version IS NOT INITIAL.
    CLEAR gt_data.

    SELECT vendor version pcode order_unit
      FROM ztvermata20
      INTO CORRESPONDING FIELDS OF TABLE gt_data
      WHERE vendor = pa_ven
      AND version = ztversa20-version.

    SELECT matnr maktx
      FROM makt
      INTO CORRESPONDING FIELDS OF TABLE gt_makt
      WHERE spras = sy-langu.

    LOOP AT gt_data INTO gs_data.
      gv_tabix = sy-tabix.

      READ TABLE gt_makt INTO gs_makt WITH KEY matnr = gs_data-pcode.
      IF sy-subrc = 0.
        gs_data-maktx = gs_makt-maktx.
        MODIFY gt_data FROM gs_data INDEX gv_tabix TRANSPORTING maktx.
      ENDIF.

    ENDLOOP.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.

  go_alv->free( ).
  go_con->free( ).
  FREE : go_alv, go_con.
  LEAVE PROGRAM.
*  CASE ok_code.
*    WHEN 'EXIT'.
*      LEAVE PROGRAM.
*    WHEN 'CANC'.
*      LEAVE TO SCREEN 0.
*  ENDCASE.
ENDMODULE.
