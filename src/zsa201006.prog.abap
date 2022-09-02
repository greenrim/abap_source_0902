*&---------------------------------------------------------------------*
*& Report ZSA201006
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsa201006.

"구문법
DATA : BEGIN OF gs_scarr,
         carrid   TYPE scarr-carrid,
         carrname TYPE scarr-carrname,
       END OF gs_scarr,

       gt_scarr LIKE TABLE OF gs_scarr.

SELECT carrid carrname
  FROM scarr
  INTO CORRESPONDING FIELDS OF TABLE gt_scarr.


"NEW SYNTAX
"변수 선언이 필요없음
"선언 한 곳에서 바로 생성되고 없어짐
"INTO TABLE
"ㅑㅜㅅㄷ구미 ㅅ뮤ㅣㄷDMS qNFLRL DNLGOTJSMS VLFDYGKA
" SELECT문에 기술된 필드명과 동일한 타입을 갖은 테이블을 바로 만듦
" 이것도 해더가 없음
SELECT carrid, carrname
    FROM scarr
    INTO TABLE @DATA(gv_scarr2). "corresponding 쓰면 안됨
"--------------------------------------------------
"구문법
DATA : lv_carrid   TYPE scarr-carrid,
       lv_carrname TYPE scarr-carrname.

SELECT SINGLE carrid carrname
  FROM scarr
  INTO ( lv_carrid, lv_carrname )
  WHERE carrid = 'AA'.


"NEW OPEN SQL
SELECT SINGLE carrid, carrname
  FROM scarr
  INTO (@DATA(lv_carrid2), @DATA(lv_carrname2))
  WHERE carrid = 'AA'.

*********************************************
*DATA


"New Open SQL
*ls_scarr3 = VALUE #( carrid   = 'AA'
*                     carrname = 'American Airline'
*                     url      = 'www.sap.com').
*
*ls_scarr3 = VALUE #( carrid = 'KA' ). "기술되지 않은 필드는 모두 CLEAR 됨
*ls_scarr3 = VALUE #( BASE ls_scarr3
*                     carrid = 'KA' ). "기존 필드 그대로, 특정 필드만 수정

*********************************************
DATA: BEGIN OF ls_scarr4,
        carrid   TYPE scarr-carrid,
        carrname TYPE scarr-carrname,
        url      TYPE scarr-url,
      END OF ls_scarr4,

      lt_scarr4 LIKE TABLE OF ls_scarr4.

"구문법
ls_scarr4-carrid = 'AA'.
ls_scarr4-carrname = 'American Airline'.
ls_scarr4-url      = 'www.sap.com'.
APPEND ls_scarr4 TO lt_scarr4.

ls_scarr4-carrid = 'AA'.
ls_scarr4-carrname = 'American Airline'.
ls_scarr4-url      = 'www.sap.com'.
APPEND ls_scarr4 TO lt_scarr4.

CLEAR lt_scarr4.
"New Open SQL
lt_scarr4 = VALUE #(
                     ( carrid   = 'AA'
                      carrname = 'American Airline'
                      url      = 'www.sap.com'
                      )
                     ( carrid   = 'KA'
                      carrname = 'Korean Airline'
                      url      = 'www.Korea.com'
                      )
                    ).
****loop를 통해 새로운 데이터를 추가하고 싶다면?




*********************************************
*MOVE-CORRESPONDING ls_scarr3 TO ls_scarr4.

"New Open SQL
*ls_scarr4 = CORRESPONDING #( ls_scarr3 ).

*********************************************
"FOR ALL ENTRIES
*********************************************
