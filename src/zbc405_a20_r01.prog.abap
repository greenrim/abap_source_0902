*&---------------------------------------------------------------------*
*& Report ZBC405_A20_R01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zbc405_a20_r01_top                      .    " Global Data

INCLUDE zbc405_a20_r01_o01                      .  " PBO-Modules
INCLUDE zbc405_a20_r01_i01                      .  " PAI-Modules
INCLUDE zbc405_a20_r01_f01                      .  " FORM-Routines


INITIALIZATION.

AT SELECTION-SCREEN OUTPUT.


AT SELECTION-SCREEN.

START-OF-SELECTION.
  SELECT *
    FROM scarr
    INTO CORRESPONDING FIELDS OF TABLE gt_scarr
    WHERE carrid IN so_carr.

  SELECT *
FROM spfli
    INTO CORRESPONDING FIELDS OF TABLE gt_spfli
WHERE carrid IN so_carr
    AND connid IN so_conn.

  SELECT *
FROM sflight
INTO CORRESPONDING FIELDS OF TABLE gt_sflight
WHERE carrid IN so_carr
AND connid IN so_conn
    AND fldate IN so_flda.


  CALL SCREEN 100.
