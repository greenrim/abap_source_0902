*&---------------------------------------------------------------------*
*& Report ZRSA20_10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_10.

DATA : gv_a TYPE i,
       gv_b LIKE gv_a,
       gv_r LIKE gv_b.

gv_a = 10.
gv_b = 20.

*Subroutine
PERFORM cal USING gv_a gv_b
            CHANGING gv_r.


WRITE gv_r.
*&---------------------------------------------------------------------*
*& Form cal
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM cal  USING VALUE(p_a)
                VALUE(p_b)
          CHANGING VALUE(p_r).

  p_r = p_a + p_b.
ENDFORM.
