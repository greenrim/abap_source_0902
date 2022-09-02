*&---------------------------------------------------------------------*
*& Report ZBC401_A20_MAIN_03
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc401_a20_main_03.

CLASS CL_number DEFINITION.
  PUBLIC SECTION.
    DATA : num1 TYPE i.
    METHODS : pro IMPORTING num2 TYPE i.
    EVENTS: cutoff.
ENDCLASS.

CLASS cl_number IMPLEMENTATION.
  METHOD pro.
    num1 = num2.
    IF num2 >= 2.
      RAISE EVENT cutoff.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

CLASS cl_event_handler DEFINITION.
  PUBLIC SECTION.
    METHODS : on_cutoff FOR EVENT cutoff OF cl_number.
ENDCLASS.

CLASS cl_event_handler IMPLEMENTATION.
  METHOD on_cutoff.
    WRITE : 'On_cutoff'.
    WRITE : / 'Event has been procossed'.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA : go_num   TYPE REF TO cl_number,
         go_event TYPE REF TO cl_event_handler.

  CREATE OBJECT go_num.
  CREATE OBJECT go_event.

  SET HANDLER go_event->on_cutoff FOR go_num.
  go_num->pro( EXPORTING num2 = 4 ).
