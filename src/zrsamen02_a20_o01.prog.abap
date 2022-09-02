*&---------------------------------------------------------------------*
*& Include          ZRSAMEN02_A20_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100' WITH sy-datum sy-uname.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CREAT_ALV_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE create_alv_0100 OUTPUT.

  IF go_con IS INITIAL.

    PERFORM create_alv.

  ELSE.

    PERFORM refresh_display.

  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CREAT_LISTBOX OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE set_screen_element OUTPUT.

  PERFORM set_screen_element.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CREATE_LAYOUT_FCAT OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE create_layout_fcat OUTPUT.

  gs_layout-zebra = 'X'.
  gs_layout-sel_mode = 'D'.
  gs_layout-cwidth_opt = 'X'.
  gs_layout-stylefname = 'GT_STYLE'.

*key / coltext / fieldname / ref_f / ref_t / edit / currenc / quant
  PERFORM create_fcat USING :
        'X' '제품명'    'PCODE'      'ZTVERMATA20' 'PCODE'      ''  '' '',
        'X' '제품코드명'  'MAKTX'      'MAKT'        'MAKTX'      ''  '' '',
        'X' '단위'     'ORDER_UNIT' 'ZTVERMATA20' 'ORDER_UNIT' 'X' '' '',
        '' '수정'  'MODIFIED'      ''        ''      ''  '' ''.


ENDMODULE.
