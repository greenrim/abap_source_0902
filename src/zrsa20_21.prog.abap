*&---------------------------------------------------------------------*
*& Report ZRSA20_21
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_21.

"Local Structure Type
TYPES: BEGIN OF ts_info,
         carrid    TYPE c LENGTH 3,
         carrname  TYPE scarr-carrname,
         connid    TYPE spfli-connid,
         countryfr TYPE spfli-countryfr,
         countryto TYPE spfli-countryto,
         atype, "TYPE c LENGTH 1
       END OF ts_info.

*Connection Internal Table
DATA gt_info TYPE TABLE OF ts_info.
*Structure Variable
DATA gs_info LIKE LINE OF gt_info.
*DATA gs_info TYPE ts_info.

*DATA: gs_info TYPE ts_info,
*      gt_info LIKE TABLE OF gs_info.

PARAMETERS pa_car TYPE spfli-carrid.
"LIKE gs_info-carrid.

*PERFORM test_info USING 'AA' '0017' 'US' 'US'. "내가 작성한 Subroutine.

*PERFORM add_info USING 'AA' '0017' 'US' 'US'. "강사님 Subroutine.
*PERFORM add_info USING 'AA' '0016' 'US' 'US'.

SELECT carrid connid countryfr countryto
  FROM spfli
  INTO CORRESPONDING FIELDS OF TABLE gt_info
  WHERE carrid = pa_car.

LOOP AT gt_info INTO gs_info. "gt_info를 한줄씩 반복함
  "Get Atype ( D, I )
  IF gs_info-countryfr = gs_info-countryto.
    gs_info-atype = 'D'. "국내선
  ELSE.
    gs_info-atype = 'I'. "해외선
  ENDIF.

  "Get Airline Name
  SELECT SINGLE carrname
    FROM scarr
    INTO gs_info-carrname
    WHERE carrid = gs_info-carrid.

  MODIFY gt_info FROM gs_info TRANSPORTING carrname atype. "atype만 변경
  CLEAR gs_info.
ENDLOOP.

SORT gt_info BY atype ASCENDING. "atype으로 asc 올림차순 정렬 ascending은 생략 가능
cl_demo_output=>display_data( gt_info ). "Class의 Method
*&---------------------------------------------------------------------*
*& Form test_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM test_info USING VALUE(p_carrid)
                     VALUE(p_connid)
                     VALUE(p_countryfr)
                     VALUE(p_countryto).

  DATA ls_info LIKE LINE OF gt_info.
  ls_info-carrid = p_carrid.
  ls_info-connid = p_connid.
  ls_info-countryfr = p_countryfr.
  ls_info-countryto = p_countryto.

  APPEND ls_info TO gt_info.

  CLEAR ls_info.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form add_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM add_info USING VALUE(p_carrid)
                    VALUE(p_connid)
                    VALUE(p_countryfr)
                    VALUE(p_countryto).
  DATA ls_info LIKE LINE OF gt_info.
  CLEAR ls_info.
  ls_info-carrid = p_carrid.
  ls_info-connid = p_connid.
  ls_info-countryfr = p_countryfr.
  ls_info-countryto = p_countryto.
  APPEND ls_info TO gt_info.
  CLEAR ls_info.
ENDFORM.

*IF gt_flightinfo IS NOT INITIAL.
*ENDIF.
*
*READ TABLE gt_flightinfo INDEX 1 INTO gs_flightinfo.
*IF sy-subrc = 0.
*ENDIF.
