*&---------------------------------------------------------------------*
*& Report ZRSA20_23A
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa20_23a_top                          .    " Global Data

* INCLUDE ZRSA20_23A_O01                          .  " PBO-Modules
* INCLUDE ZRSA20_23A_I01                          .  " PAI-Modules
INCLUDE zrsa20_23a_f01                           .  " FORM-Routines

"Event

INITIALIZATION.

AT SELECTION-SCREEN OUTPUT. "PBO

AT SELECTION-SCREEN.

START-OF-SELECTION.

  CLEAR: gs_info, gt_info.
