*&---------------------------------------------------------------------*
*& Report ZRCA20_04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrca20_04.

"173페이지
PARAMETERS pa_car TYPE scarr-carrid. "Char 3
*PARAMETERS pa_car1 TYPE c LENGTH 3.

DATA gs_info TYPE scarr. "DATA 선언 변수니까 내가 지정하는 변수
"gv : g는 글로벌의 약자 v는 valueable의 약자
"gs : structure (structure valuable) 의 약자.
"structure structure valuable도 structure라고 함.
"structure type도 structure라고 함. 둘다 문맥에 따라 구분해야함.
"당분간 강사님은 full name 쓰겠지만 익숙해져야해!
"gw는 work 에리어의 약자?
"wa는 조금 예전분.


"변수가 여러 개가 그룹으로 묶여 있는 것을 structure 변수라고 부름.

CLEAR gs_info. "변수에 값을 넣기 전에 intial value 상태로 두기.
"이 코드에서는 자동 clear되지만, 자동 clear 안 되는 경우도 있음
"그래서 잘 모를 때에는 적는 게 좋음.
SELECT SINGLE carrid carrname
  FROM scarr "from 다음에 나오는 애는 db table
*  INTO CORRESPONDING FIELDS OF gs_info
*  "scarr t에 있는 carrid, carrname 필드 정보를 가져와서
*  "gs_info 변수에 담을거야.
*  "똑같은 곳에 집어 넣어줘. (순서대로x)
    INTO gs_info
  WHERE carrid = pa_car.

WRITE : gs_info-mandt, gs_info-carrid, gs_info-carrname.
"어떤 컴포넌트를 출력할지 -로 연결
"그래서 변수 이름에 -를 안 씀! 컴포넌트 출력과 구분하기 위해서 변수이름에는 언더바를 사용
