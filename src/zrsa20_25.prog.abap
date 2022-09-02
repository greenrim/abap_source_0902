*&---------------------------------------------------------------------*
*& Report ZRSA20_25
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa20_25_top                           .    " Global Data

* INCLUDE ZRSA20_25_O01                           .  " PBO-Modules
* INCLUDE ZRSA20_25_I01                           .  " PAI-Modules
INCLUDE zrsa20_25_f01                           .  " FORM-Routines

START-OF-SELECTION.
  WRITE 'Test'.

  SELECT *
  FROM sflight
  INTO CORRESPONDING FIELDS OF TABLE gt_info
    WHERE carrid = pa_car
*    AND connid IN so_con[]. "[]생략 가능
    AND connid BETWEEN pa_con1 AND pa_con2.



  cl_demo_output=>display_data( gt_info ).
