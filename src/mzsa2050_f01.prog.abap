*&---------------------------------------------------------------------*
*& Include          MZSA2050_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_carrname
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA2090_CARRID
*&      <-- ZSSA2090
*&---------------------------------------------------------------------*
FORM get_carrname  USING    VALUE(p_carrid)
                   CHANGING pv_carrid
                            pv_carrname.

  SELECT SINGLE carrid carrname
    FROM scarr
    INTO ( pv_carrid, pv_carrname )
    WHERE carrid = p_carrid.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA2090_MEALNUMBER
*&      <-- ZSSA2091
*&      <-- ZSSA2092
*&---------------------------------------------------------------------*
FORM get_info  USING    VALUE(p_mealnr)
               CHANGING ps_minfo TYPE zssa2091
                        ps_vinfo TYPE zssa2092.

  CLEAR : ps_vinfo.


*  SELECT SINGLE *
*   FROM smeal
*   INTO CORRESPONDING FIELDS OF ps_minfo
*   WHERE mealnumber = p_mealnr.

  SELECT SINGLE mealnumber mealtype price waers
     FROM smeal AS a LEFT OUTER JOIN ztsa20ven AS b
       ON a~mealnumber = b~mealno
     INTO CORRESPONDING FIELDS OF ps_minfo
     WHERE a~mealnumber = p_mealnr.

  IF sy-subrc IS NOT INITIAL.
    MESSAGE i016(pn) WITH 'Data is not found'.
    RETURN.
  ENDIF.

  SELECT SINGLE *
    FROM smealt
    INTO CORRESPONDING FIELDS OF ps_minfo
   WHERE mealnumber = p_mealnr
    AND carrid = ps_minfo-carrid
    AND sprache = sy-langu.


  PERFORM get_fixed_value USING 'S_MEALTYPE'
                                 zssa2091-mealtype
                          CHANGING zssa2091-MEALTYPE_t.

  PERFORM get_fixed_value USING 'ZDVENCA_A20'
                                 zssa2092-venca
                          CHANGING zssa2092-venca_t.

*  SELECT SINGLE *
*      FROM ztsa20ven
*      INTO CORRESPONDING FIELDS OF ps_vinfo
*      WHERE mealnumber = p_mealnr.

*      SELECT SINGLE *
*        FROM ( smeal AS a INNER JOIN ztsa20ven AS b
*          ON a~mealnumber = b~mealno ) LEFT OUTER JOIN scarr AS c
*          ON a~carrid = c~carrid
*        INTO CORRESPONDING FIELDS OF zssa2091
*        WHERE a~mealnumber = zssa2090-mealnumber
*        AND a~carrid = zssa2090-carrid.

  SELECT SINGLE *
    FROM ztsa20ven
    INTO  CORRESPONDING FIELDS OF ps_vinfo
    WHERE mealno = p_mealnr
    AND carrid = zssa2091-carrid.

  SELECT SINGLE *
    FROM t005t
    INTO CORRESPONDING FIELDS OF ps_vinfo
    WHERE land1 = ps_vinfo-land1
    AND spras = sy-langu.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_fixed_value
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_fixed_value USING VALUE(p_domname)
                           VALUE(p_domain)
                     CHANGING p_fvalue.

  DATA: lt_domain TYPE TABLE OF dd07v,
        ls_domain LIKE LINE OF lt_domain.

  CALL FUNCTION 'GET_DOMAIN_VALUES'
    EXPORTING
      domname         = p_domname
*     TEXT            = 'X'
*     FILL_DD07L_TAB  = ' '
    TABLES
      values_tab      = lt_domain
*     VALUES_DD07L    =
    EXCEPTIONS
      no_values_found = 1
      OTHERS          = 2.

  READ TABLE lt_domain WITH KEY domvalue_l = p_domain
  INTO ls_domain.
  p_fvalue = ls_domain-ddtext.

  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_info_vender
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA2090_LIFNR
*&      <-- ZSSA2091
*&      <-- ZSSA2092
*&      <-- GV_SUBRC
*&---------------------------------------------------------------------*
FORM  get_info_vender  USING    p_vend
                      CHANGING ps_minfo TYPE zssa2091
                               ps_vinfo TYPE zssa2092.
  CLEAR : ps_minfo, ps_vinfo.

  SELECT SINGLE *
    FROM ztsa20ven
    INTO CORRESPONDING FIELDS OF ps_vinfo
    WHERE lifnr = p_vend.

  IF sy-subrc IS NOT INITIAL.
    MESSAGE i016(pn) WITH 'Data is not found'.
    RETURN.
  ENDIF.

  SELECT SINGLE *
     FROM smeal AS a INNER JOIN ztsa20ven AS b
       ON a~mealnumber = b~mealno
     INTO CORRESPONDING FIELDS OF ps_minfo
     WHERE b~lifnr = p_vend.


  PERFORM get_fixed_value USING 'ZDVENCA_A20'
                                 ps_vinfo-venca
                          CHANGING ps_vinfo-venca_t.

  SELECT SINGLE *
    FROM smealt
    INTO CORRESPONDING FIELDS OF ps_minfo
   WHERE mealnumber = ps_minfo-mealnumber
    AND carrid = ps_minfo-carrid.

  PERFORM get_fixed_value USING 'S_MEALTYPE'
                                 zssa2091-mealtype
                          CHANGING zssa2091-MEALTYPE_t.

**  SELECT SINGLE *
**      FROM ztsa20ven
**      INTO CORRESPONDING FIELDS OF ps_vinfo
**      WHERE mealnumber = p_mealnr.
*
**      SELECT SINGLE *
**        FROM ( smeal AS a INNER JOIN ztsa20ven AS b
**          ON a~mealnumber = b~mealno ) LEFT OUTER JOIN scarr AS c
**          ON a~carrid = c~carrid
**        INTO CORRESPONDING FIELDS OF zssa2091
**        WHERE a~mealnumber = zssa2090-mealnumber
**        AND a~carrid = zssa2090-carrid.
*
*  SELECT SINGLE *
*    FROM ztsa20ven
*    INTO  CORRESPONDING FIELDS OF ps_vinfo
*    WHERE mealno = p_mealnr.
*
*  SELECT SINGLE *
*    FROM t005t
*    INTO CORRESPONDING FIELDS OF ps_vinfo
*    WHERE land1 = ps_vinfo-land1
*    AND spras = sy-langu.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form clear_cond
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- ZSSA2090_LIFNR
*&      <-- ZSSA2090_NAME1
*&---------------------------------------------------------------------*
FORM clear_cond  CHANGING p_lifnr
                          p_name1.

  CLEAR : p_lifnr, p_name1.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form clear_aircond
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- ZSSA2090_CARRID
*&      <-- ZSSA2090_CARRNAME
*&      <-- ZSSA2090_MEALNUMBER
*&---------------------------------------------------------------------*
FORM clear_aircond  CHANGING p_carrid
                             p_carrname
                             p_mealnumber.
  CLEAR : p_carrid, p_carrname, p_mealnumber.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_vendname
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA2090_LIFNR
*&      <-- ZSSA2090
*&---------------------------------------------------------------------*
FORM get_vendname  USING    p_lifnr
                   CHANGING p_vend TYPE zssa2090.
  CLEAR p_vend-name1.

  SELECT SINGLE lifnr name1
  FROM ztsa20ven
  INTO CORRESPONDING FIELDS OF p_vend
  WHERE lifnr = p_lifnr.

ENDFORM.
