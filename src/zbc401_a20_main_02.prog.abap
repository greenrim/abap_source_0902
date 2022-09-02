*&---------------------------------------------------------------------*
*& Report ZBC401_A20_MAIN_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc401_a20_main_02.

INTERFACE intf.
  DATA : ch1 TYPE i,
         ch2 TYPE i.

  METHODS : met1.
ENDINTERFACE.


CLASS cl1 DEFINITION.
  PUBLIC SECTION.
    INTERFACES intf.
ENDCLASS.

CLASS cl1 IMPLEMENTATION.
  METHOD intf~met1.
    DATA rel TYPE i.
    rel = intf~ch1 + intf~ch2.

    WRITE : /  'reuslt + :', rel.
  ENDMETHOD.
ENDCLASS.

CLASS cl2 DEFINITION.
  PUBLIC SECTION.
    INTERFACES intf.
    ALIASES multi_intf FOR intf~met1.

    ALIASES int_char1 FOR intf~ch1.
    ALIASES int_char2 FOR intf~ch2.
ENDCLASS.

CLASS cl2 IMPLEMENTATION.
  METHOD multi_intf.
    DATA rel TYPE i.
    rel = int_char1 * int_char2.

    WRITE : / 'result * :', rel.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA : clobj TYPE REF TO cl1.

  CREATE OBJECT clobj.

  clobj->intf~ch1 = 10.
  clobj->intf~ch2 = 20.

  CALL METHOD clobj->intf~met1.


  DATA : clobj1 TYPE REF TO cl2.

  CREATE OBJECT clobj1.


  clobj1->intf~ch1 = 10.
  clobj1->intf~ch2 = 20.

*  CALL METHOD clobj1->intf~met1.
  CALL METHOD clobj1->multi_intf. "use Aliases
