*&---------------------------------------------------------------------*
*& Report ZRSA20_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_05.

WRITE 'New Name'(t02).
WRITE 'New Name'(t02).

*WRITE TEXT-t01. "Last Name
*WRITE TEXT-t01. "Last Name
*
*WRITE 'Name:'.
*
*WRITE 'Name:'.


**DATA gv_edcode TYPE c LENGTH 4 VALUE 'SYNC'.
*CONSTANTS gc_ecode TYPE c LENGTH 4 VALUE 'SYNC'.
*
*
*WRITE gc_ecode.

*TYPES t_name TYPE c LENGTH 10.
*
*DATA gv_name TYPE t_name.
*DATA gv_cname TYPE t_name.

*DATA: gv_name  TYPE c LENGTH 10,
*      gv_cname LIKE gv_name.




*DATA: gv_p TYPE p LENGTH 2 DECIMALS 2.
*
*gv_p = '1.23'.
*WRITE: gv_p.

*DATA: gv_n1 TYPE n,
*      gv_n2 TYPE n LENGTH 2,
*      gv_i  TYPE i,
*      gv_i2 TYPE i LENGTH 10.
*
*WRITE: gv_n1, gv_n2, gv_i.

*DATA : gv_c1    TYPE c LENGTH 1,
*       gv_c2(1) TYPE c,
*       gv_c3    TYPE c,
*       gv_c4.

*DATA gv_d2 LIKE sy-datum.
*
*WRITE: gv_d1, gv_d2.
