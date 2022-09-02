*&---------------------------------------------------------------------*
*& Report ZRSA20_24
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa20_24_top                           .    " Global Data

* INCLUDE ZRSA20_24_O01                           .  " PBO-Modules
* INCLUDE ZRSA20_24_I01                           .  " PAI-Modules
INCLUDE zrsa20_24_f01                            .  " FORM-Routines

INITIALIZATION.

AT SELECTION-SCREEN OUTPUT.

AT SELECTION-SCREEN.

START-OF-SELECTION.

  PERFORM get_fligt_info USING pa_car pa_con1 pa_con2 CHANGING gt_info.
  PERFORM get_carrname USING pa_car CHANGING gv_carrname.
  PERFORM get_connection USING pa_car pa_con1 pa_con2 CHANGING gt_city.

  IF gt_info IS INITIAL.
    MESSAGE i016(pn) WITH 'Data is not found.'(t01).
    EXIT.
  ENDIF.

  LOOP AT gt_info INTO gs_info.
    gs_info-carrname = gv_carrname.
    PERFORM get_seatremain USING gs_info-seatsmax gs_info-seatsocc CHANGING gs_info-seatremain.
    PERFORM get_seatremain USING gs_info-seatsmax_b gs_info-seatsocc_b CHANGING gs_info-seatremain_b.
    PERFORM get_seatremain USING gs_info-seatsmax_f gs_info-seatsocc_f CHANGING gs_info-seatremain_f.


    READ TABLE gt_city INTO gs_city WITH KEY connid = gs_info-connid.
    gs_info-cityfrom = gs_city-cityfrom.
    gs_info-cityto = gs_city-cityto.
    MODIFY gt_info FROM gs_info TRANSPORTING carrname cityfrom cityto seatremain seatremain_b seatremain_f.

*    LOOP AT gt_city INTO gs_city.
*      IF gs_info-carrid = gs_city-carrid AND gs_info-connid = gs_city-connid.
*        gs_info-cityfrom = gs_city-cityfrom.
*        gs_info-cityto = gs_city-cityto.
*        EXIT.
*      ENDIF.
*    ENDLOOP.
*    MODIFY gt_info FROM gs_info TRANSPORTING carrname cityfrom cityto seatremain seatremain_b seatremain_f.
  ENDLOOP.

  cl_demo_output=>display_data( gt_info ).

  "질문 seatsocc 0 이면 모든 남은 좌석을 0으로 표시한다는 어떤 의미?
  "해석1) economy class socc가 0이면 e,b,f class의 모든 잔여 좌석을 0으로 표시한다.
  "해석2) 각 class의 socc가 0일 경우 해당 class의 잔여 좌석을 0으로 표시한다.
  "subroutine get_seatremain은 해석2로 작성한 코드
