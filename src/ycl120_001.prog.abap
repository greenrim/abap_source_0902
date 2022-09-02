*&---------------------------------------------------------------------*
*& Report YCL120_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ycl120_001.


INCLUDE ycl120_001_top.   "Global Variable  전역변수 선언
INCLUDE ycl120_001_cls.   "LOCAL CLASS      ALV 관련 선언
INCLUDE ycl120_001_scr.   "SELECTION SCREEN 검색화면
INCLUDE ycl120_001_pbo.   "PBO
INCLUDE ycl120_001_pai.   "PAI
INCLUDE ycl120_001_f01.   "Subroutines

INITIALIZATION.
  "프로그램 실행 시  최초 1회만 수행되는 이벤트 구간
  textt01 = '검색조건'.

AT SELECTION-SCREEN OUTPUT.
  "검색 화면에서 화면이 출력되기 직전에 수행되는 구간
  "주용도
  "검색 화면에 대한 제어
  "특정 필드 숨김 또는 읽기 전용

AT SELECTION-SCREEN.
  "검색 화면에서 사용자가 특정 이벤트를 발생시켰을 때 수행되는 구간
  "상단의 Function Key 이벤트, 특정 field의 click, enter 등의 이벤트에서
  "입력값에 대한 점검, 실행 권한 점검

START-OF-SELECTION.
  "검색화면에서 실행버튼 눌렀을 때 수행되는 구간
  "주용도
  "데이터 조회 & 출력

  PERFORM select_data.

end-OF-selection.
  "START-OF-SELECTION 끝나고 실행되는 구간
  "주용도
  "데이터 출력

  IF gt_scarr[] IS INITIAL.
    MESSAGE '데이터가 없습니다.' TYPE 'S' DISPLAY LIKE 'W'.
  ELSE.
    CALL SCREEN 0100.
  ENDIF.
