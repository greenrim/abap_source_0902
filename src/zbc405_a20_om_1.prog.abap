*&---------------------------------------------------------------------*
*& Report ZBC405_A20_OM_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_a20_om_1.

TABLES spfli.

SELECT-OPTIONS : so_car FOR spfli-carrid MEMORY ID car,
                 so_con FOR spfli-connid MEMORY ID con.

DATA: gs_spfli TYPE spfli,
      gt_spfli LIKE TABLE OF gs_spfli.

DATA : go_alv TYPE REF TO cl_salv_table.

START-OF-SELECTION.

  SELECT *
    FROM spfli
    INTO CORRESPONDING FIELDS OF TABLE gt_spfli
    WHERE carrid IN so_car
    AND connid IN so_con.


  TRY.
      CALL METHOD cl_salv_table=>factory
        EXPORTING
          list_display = ' ' "'X' "List로 볼 수 있음   "IF_SALV_C_BOOL_SAP=>FALSE
*         r_container  =
*         container_name =
        IMPORTING
          r_salv_table = go_alv
        CHANGING
          t_table      = gt_spfli.
    CATCH cx_salv_msg.
  ENDTRY.


*CALL METHOD xxxxxxxx->display.
  CALL METHOD go_alv->display.


*  CALL METHOD go_alv->get_functions
*    RECEIVING
*      value = go_func.
