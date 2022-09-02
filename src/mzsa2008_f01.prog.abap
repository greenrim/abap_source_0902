*&---------------------------------------------------------------------*
*& Include          MZSA2008_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form GET_ENAME
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA2076_PERNR
*&      <-- ZSSA2076
*&---------------------------------------------------------------------*
FORM get_ename  USING    VALUE(p_pernr)
                CHANGING p_cond TYPE zssa2076.

  SELECT SINGLE *
    FROM ztsa2001
    INTO CORRESPONDING FIELDS OF p_cond
    WHERE pernr = p_pernr.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA2076_PERNR
*&      --> ZSSA2075_DEPID
*&      --> ZSSA2075_GENDER
*&      <-- ZSSA2075
*&---------------------------------------------------------------------*
FORM get_info  USING    VALUE(p_pernr)
                        VALUE(p_depid)
                        VALUE(p_gender)
               CHANGING p_info TYPE zssa2075.

  CLEAR p_info.

  SELECT SINGLE *
    FROM ztsa2001 AS a INNER JOIN ztsa2002 AS b
    ON a~depid = b~depid
    INTO CORRESPONDING FIELDS OF p_info
    WHERE pernr = p_pernr.

  SELECT SINGLE *
    FROM ztsa2002_t
    INTO CORRESPONDING FIELDS OF p_info
    WHERE depid = p_pernr
    AND spras = sy-langu.

  CLEAR: gv_gender1, gv_gender2, gv_gender3.
  CASE p_gender.
    WHEN 0.
      gv_gender1 = 'X'.
    WHEN '1'.
      gv_gender2 = 'X'.
    WHEN '2'.
      gv_gender3 = 'X'.
  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_default
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- ZSSA2076
*&---------------------------------------------------------------------*
FORM get_default  CHANGING p_default TYPE zssa2076.

  SELECT SINGLE *
    FROM Ztsa2001
    INTO CORRESPONDING FIELDS OF p_default
    WHERE pernr = '20220101'.
ENDFORM.
