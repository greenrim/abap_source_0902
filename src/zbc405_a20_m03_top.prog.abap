*&---------------------------------------------------------------------*
*& Include ZBC405_A20_M01_TOP                       - Report ZBC405_A20_M01
*&---------------------------------------------------------------------*
REPORT zbc405_a20_m01.


TABLES: sflight, sscrfields.

"List
DATA : gt_sfli TYPE TABLE OF sflight,
       gv_chg  TYPE c LENGTH 1.

"SELECTION SCREEN LAYOUT

"2줄의 공백
SELECTION-SCREEN SKIP 2.

"BLOCK, line

SELECTION-SCREEN BEGIN OF BLOCK bll.
*SELECTION-SCREEN BEGIN OF LINE.
  SELECTION-SCREEN COMMENT 3(8) TEXT-t05.           " FOR FIELD pa_rad1.  "파라미터명 위치 지정
*  SELECTION-SCREEN POSITION 15.                                   "파라미터 input field 위치 지정
  PARAMETERS pa_rad1 RADIOBUTTON GROUP rd1.                   " MODIF ID gr1 .
  SELECTION-SCREEN  COMMENT pos_high(7) TEXT-t06 .
  PARAMETERS pa_rad2 RADIOBUTTON GROUP rd1.                   " MODIF ID gr1.
*SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END  OF BLOCK bll.
"버튼
SELECTION-SCREEN PUSHBUTTON /1(10) gv_text USER-COMMAND on.

SELECTION-SCREEN SKIP 3.

"LINE생성
SELECTION-SCREEN ULINE.

"SUB SCREEN 생성
SELECTION-SCREEN BEGIN OF SCREEN 1100 AS SUBSCREEN.
  PARAMETERS pa_car TYPE sflight-carrid.
  PARAMETERS cb_popup AS CHECKBOX.
SELECTION-SCREEN END OF SCREEN 1100.

SELECTION-SCREEN BEGIN OF SCREEN 1200 AS SUBSCREEN.
  PARAMETERS pa_con TYPE sflight-connid.
SELECTION-SCREEN END OF SCREEN 1200.


"TAB STRIP
SELECTION-SCREEN BEGIN OF TABBED BLOCK ts_con FOR 5 LINES.
  SELECTION-SCREEN TAB (10) tab1 USER-COMMAND car DEFAULT SCREEN 1100.
  SELECTION-SCREEN TAB (10) tab2 USER-COMMAND con DEFAULT SCREEN 1200.
SELECTION-SCREEN END OF BLOCK ts_con.
