*&---------------------------------------------------------------------*
*& Include          MZSA2013_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_ename
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA2076_PERNR
*&      <-- ZSSA2076
*&---------------------------------------------------------------------*
FORM get_ename  USING    VALUE(p_pernr)
                CHANGING ps_cond TYPE zssa2076.

  SELECT SINGLE *
    FROM ztsa2001
    INTO CORRESPONDING FIELDS OF ps_cond
    WHERE pernr = p_pernr.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA2076
*&      <-- ZSSA2075
*&---------------------------------------------------------------------*
FORM get_info  USING    VALUE(p_pernr)
               CHANGING p_info TYPE zssa2075.

  CLEAR : p_info, gv_gen1, gv_gen2,  gv_gen3.

  SELECT SINGLE *
    FROM ztsa2001 AS a INNER JOIN ztsa2002 AS b
    ON a~depid = b~depid
    INTO CORRESPONDING FIELDS OF p_info
    WHERE pernr = p_pernr.

  CASE zssa2075-gender.
    WHEN '0'.
      gv_gen1 = 'X'.
    WHEN '1'.
      gv_gen2 = 'X'.
    WHEN '2'.
      gv_gen3 = 'X'.
  ENDCASE.

ENDFORM.
