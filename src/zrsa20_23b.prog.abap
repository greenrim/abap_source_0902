*&---------------------------------------------------------------------*
*& Report ZRSA20_23B
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa20_23b_top                          .    " Global Data

* INCLUDE ZRSA20_23B_O01                          .  " PBO-Modules
* INCLUDE ZRSA20_23B_I01                          .  " PAI-Modules
INCLUDE zrsa20_23b_f01                          .  " FORM-Routines

*Event
*LOAD-OF-PROGRAM. "INITIALIZATION과 동일하게 딱 1번 실행됨
"TYPE1이 아닌 다른 프로그램에서 사용 가능

INITIALIZATION. "Runtime에 딱 한번 실행 (TYPE '1').
  IF sy-uname = 'KD-A-20'.
    pa_car = 'AA'.
    pa_con = '0017'.
  ENDIF.

AT SELECTION-SCREEN OUTPUT. "PBO "PROCESS BEFORE OUPUT

AT SELECTION-SCREEN. "PAI "PROCESS AFTER INPUT
*  "값 체크하는 목적
*  IF pa_con IS INITIAL.
*    MESSAGE w016(pn) WITH 'check'. "e는 해당 부분이 빨간색으로 바뀜
**    MESSAGE s016(pn) WITH 'check'. "s는 멈추지 않고 진행됨
**    MESSAGE e016(pn) WITH 'check'.
**    MESSAGE i016(pn) WITH 'check'. "i는 멈춤
**    STOP.
*  ENDIF.

START-OF-SELECTION. "이벤트는 다음 이벤트의 시작점이 끝점

  "Get Info List
  PERFORM get_info.
*  WRITE 'Test'.
  IF gt_info IS INITIAL.
    "S, I, E, W, A, X
*    MESSAGE i016(pn) WITH 'Data is not found!'.
**    RETURN. "START-OF-SELECTION을 빠져나감
*    "이벤트 프로그램은 다시 SELECTION SCREEN으로 돌아감
    MESSAGE s016(pn) WITH 'Data is not found!'.
*    MESSAGE i016(pn) WITH 'Data is not found!'.
*    MESSAGE e016(pn) WITH 'Data is not found!'.
*    "e는 프로그램을 죽임
*    MESSAGE a016(pn) WITH 'Data is not found!'.
*    MESSAGE x016(pn) WITH 'Data is not found!'.
  ENDIF.
  cl_demo_output=>display_data( gt_info ).


*  IF gt_info IS NOT INITIAL.
*    cl_demo_output=>display_data( gt_info ).
*  ELSE.
*
*  ENDIF.
