*&---------------------------------------------------------------------*
*& Include          MZSA20_R01_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'BACK' OR 'CANC'.
      LEAVE TO SCREEN 0.
    WHEN 'SEARCH'.
*      MESSAGE i016(pn) WITH 'test'.
      CLEAR zssa2031.

      SELECT SINGLE *
        FROM zvsa20r01
        INTO CORRESPONDING FIELDS OF zssa2031
        WHERE pernr = gv_pernr.

      SELECT SINGLE dtext
        FROM ztsa2002_t
        INTO CORRESPONDING FIELDS OF zssa2031
        WHERE depid = zssa2031-depid
      AND spras = sy-langu.

      DATA : lt_domain TYPE TABLE OF dd07v,
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

      READ TABLE lt_domain WITH KEY domvalue_l = zssa2031-gender
      INTO ls_domain.

      zssa2031-gender_t = ls_domain-ddtext.

  ENDCASE.

ENDMODULE.
