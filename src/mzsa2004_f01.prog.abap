*&---------------------------------------------------------------------*
*& Include          MZSA2004_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA2061_PERNR
*&      --> ZSSA2061_DEPID
*&      <-- ZSSA2061
*&---------------------------------------------------------------------*
FORM get_data  USING    value(p_pernr)
                        value(p_depid)
                        value(p_gender)
               CHANGING p_info type zssa2061.

 SELECT SINGLE pernr ename entdt gender a~depid budget waers
        FROM ztsa2001 AS a INNER JOIN ztsa2002 AS b
        ON a~depid = b~depid
        INTO CORRESPONDING FIELDS OF p_info
        WHERE pernr = p_pernr.

      SELECT SINGLE dtext
        FROM ztsa2002_t
        INTO p_info-depid_t
        WHERE depid = p_depid
        AND spras = sy-langu.

      DATA: lt_domain TYPE TABLE OF dd07v,
            ls_domain LIKE LINE OF lt_domain.

      CALL FUNCTION 'GET_DOMAIN_VALUES'
        EXPORTING
          domname         = 'ZDGENDER_A20'
*         TEXT            = 'X'
*         FILL_DD07L_TAB  = ' '
        TABLES
          values_tab      = lt_domain
*         VALUES_DD07L    =
        EXCEPTIONS
          no_values_found = 1
          OTHERS          = 2.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.

      READ TABLE lt_domain WITH KEY domvalue_l = p_gender
      INTO ls_domain.
      p_info-gender_t = ls_domain-ddtext.
ENDFORM.
