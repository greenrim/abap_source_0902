*&---------------------------------------------------------------------*
*& Include          MZSA2090_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_airline_name
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA2093_CARRID
*&      <-- ZSSA2093_CARRNAME
*&---------------------------------------------------------------------*
FORM get_airline_name  USING    VALUE(p_carrid)
                       CHANGING p_carrname.
  CLEAR p_carrname.
  SELECT SINGLE carrname
    FROM scarr
    INTO ( p_carrname )
    WHERE carrid = p_carrid.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_meal_text
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA2093_CARRID
*&      --> ZSSA2093_MEALNUMBER
*&      --> SY_LANGU
*&      <-- ZSSA2093_MEAL_T
*&---------------------------------------------------------------------*
FORM get_meal_text  USING    VALUE(p_carrid)
                             VALUE(p_mealno)
                             VALUE(p_langu)
                    CHANGING VALUE(p_meal_t).

  CLEAR p_meal_t.

  SELECT SINGLE text
    FROM smealt
    INTO p_meal_t
    WHERE carrid = p_carrid
    AND mealnumber = p_mealno
    AND sprache = p_langu.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_meal_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_meal_info USING VALUE(p_carrid)
                          VALUE(p_mealno)
                   CHANGING ps_meal_info TYPE zssa2094.

  CLEAR ps_meal_info. "into 다음에 담을 변수는 먼저 clear를 한번 해주자.

  "Meal Info
  SELECT SINGLE *
    FROM smeal
    INTO CORRESPONDING FIELDS OF ps_meal_info
    WHERE carrid = p_carrid
    AND mealnumber = p_mealno.

  "Airline Name
  PERFORM get_airline_name USING ps_meal_info-carrid
                           CHANGING ps_meal_info-carrname.

  "Meal Text
  PERFORM get_meal_text USING ps_meal_info-carrid
                              ps_meal_info-mealnumber
                              sy-langu
                        CHANGING ps_meal_info-meal_t.

  "Get Price
  "Flag(V,M), Vendor ID, Airline Code, Meal Number

  "REUSE 목적으로!
  DATA ls_vendor_info TYPE zssa2095. "Vendor 정보가 담긴 strucutre변수

  PERFORM get_vendor_info USING 'M' "Meal Number
                                ps_meal_info-carrid
                                ps_meal_info-mealnumber
                          CHANGING ls_vendor_info.
  ps_meal_info-price = ls_vendor_info-price.
  ps_meal_info-waers = ls_vendor_info-waers.

  SELECT SINGLE price waers
    FROM ztsa2099 "Vendor table
    INTO ( ps_meal_info-price, ps_meal_info-waers ) "CORRESPONDING FIELDS OF ps_meal
    WHERE carrid = ps_meal_info-carrid
    AND mealnumber = ps_meal_info-mealnumber.

  "Meal Type Text

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_vendor_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      --> PS_MEAL_INFO_CARRID
*&      --> PS_MEAL_INFO_MEALNUMBER
*&      <-- LS_VENDOR_INFO
*&---------------------------------------------------------------------*
FORM get_vendor_info  USING    VALUE(p_flag)
                               VALUE(p_code1)
                               VALUE(p_code2)
                      CHANGING ps_info TYPE zssa2095.
  DATA: BEGIN OF ls_cond,
          lifnr  TYPE ztsa2099-lifnr,
          carrid TYPE ztsa2099-carrid,
          mealno TYPE ztsa2099-mealnumber,
        END OF ls_cond.

  CASE p_flag.
    WHEN 'V'. "Vendor
      ls_cond-lifnr = p_code1.

      SELECT SINGLE *
      FROM ztsa2099
      INTO CORRESPONDING FIELDS OF ps_info
      WHERE lifnr = ls_cond-lifnr.

    WHEN 'M'. "Meal Number
      ls_cond-carrid = p_code1.
      ls_cond-mealno = p_code2.

      SELECT SINGLE *
        FROM ztsa2099
        INTO CORRESPONDING FIELDS OF ps_info
        WHERE carrid = ls_cond-carrid
        AND mealnumber = ls_cond-mealno.
    WHEN OTHERS.
      RETURN.
  ENDCASE.

ENDFORM.
