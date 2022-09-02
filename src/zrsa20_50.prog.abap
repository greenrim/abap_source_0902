*&---------------------------------------------------------------------*
*& Report ZRSA20_50
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa20_50_top                           .    " Global Data

INCLUDE zrsa20_50_o01                           .  " PBO-Modules
INCLUDE zrsa20_50_i01                           .  " PAI-Modules
INCLUDE zrsa20_50_f01                           .  " FORM-Routines

*INCLUDE ZRSA20_50_e01 을 사용하는 회사도 있음

INITIALIZATION.
  "기본값 설정
  PERFORM set_init.

AT SELECTION-SCREEN OUTPUT. "PBO
  MESSAGE s000(zmcsa20) WITH 'PBO'.

AT SELECTION-SCREEN. "PAI

START-OF-SELECTION. "END-OF-SELECTION 차이가 없음
  SELECT SINGLE *
    FROM sflight
*    INTO sflight
    WHERE carrid = pa_car
    AND connid = pa_con
    AND fldate IN so_dat.

  CALL SCREEN 100.

  MESSAGE s000(zmcsa20) WITH 'After cll screen'.
