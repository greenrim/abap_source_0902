*&---------------------------------------------------------------------*
*& Include          ZSA201005_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form CREATE_F4_FOR_CARRID
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM create_f4_for_carrid .

  DATA : BEGIN OF ls_carrid,
           carrid   TYPE scarr-carrid,
           carrname TYPE scarr-carrname,
           currcode TYPE scarr-currcode,
           url      TYPE scarr-url,
         END OF ls_carrid,

         lt_carrid LIKE TABLE OF ls_carrid.

  SELECT carrid carrname currcode url
    FROM scarr
    INTO CORRESPONDING FIELDS OF TABLE Lt_CARRID.



  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
    EXPORTING
      retfield     = 'CARRID'        "RETURN FIELD F4창에서 더블 클릭했을 때 화면을 떨어질 값
      dynpprog     = sy-repid      "SYSTEM PROGRAM
      dynpnr       = SY-DYNNR      "현재 스크린
      dynprofield  = 'PA_CAR'      "더블클릭 후 셀력션 스크린의 어느 필드에 던질거야?
      window_title = TEXT-t02      "'AIRLINE LIST' 직접 적을 수 있음
      value_org    = 'S'            "C는 더블클릭해도 안 들어감 S해야 들어감
      display      = 'X'            "abap에서 X는 switch on / abap_true
    TABLES
      value_tab    = lt_carrid.


ENDFORM.
