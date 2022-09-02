*&---------------------------------------------------------------------*
*& Include ZBC405_A20_1_TOP                         - Report ZBC405_A20_1
*&---------------------------------------------------------------------*
REPORT zbc405_a20_1.

DATA : gs_flt    TYPE dv_flights,
       gv_change.

TABLES : dv_flights, sscrfields.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-t01.
  SELECT-OPTIONS : so_flda FOR dv_flights-fldate.

  SELECTION-SCREEN SKIP 3.

  PARAMETERS : p_car TYPE dv_flights-carrid MEMORY ID car
               OBLIGATORY DEFAULT 'LH' VALUE CHECK,
               p_con TYPE s_conn_id MEMORY ID con. "VALUE-REQUEST 질문하기

  SELECTION-SCREEN SKIP 4.
  SELECTION-SCREEN PUSHBUTTON 1(10) gv_text USER-COMMAND btn1 .
SELECTION-SCREEN END OF BLOCK bl1.


PARAMETERS : p_str TYPE string LOWER CASE MODIF ID sg1.

SELECTION-SCREEN BEGIN OF LINE.
  SELECTION-SCREEN COMMENT 1(5) TEXT-t01 MODIF ID sg1.
  PARAMETERS : p_chk AS CHECKBOX MODIF ID sg1.
  SELECTION-SCREEN COMMENT 20(5) TEXT-t02 MODIF ID sg1.
  PARAMETERS p_rad1 RADIOBUTTON GROUP gr1 MODIF ID sg1.
  SELECTION-SCREEN COMMENT pos_low(10) TEXT-t03 MODIF ID sg1.
  PARAMETERS p_rad2 RADIOBUTTON GROUP gr1 MODIF ID sg1.
  SELECTION-SCREEN COMMENT pos_high(10) TEXT-t04 MODIF ID sg1.
  PARAMETERS p_rad3 RADIOBUTTON GROUP gr1 MODIF ID sg1.
SELECTION-SCREEN END OF LINE.
