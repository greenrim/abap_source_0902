*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_E01
*&---------------------------------------------------------------------*





INITIALIZATION.
  gv_text = 'Detail'.
  gv_change = '0'.

  so_flda-low = sy-datum.
  so_flda-high = sy-datum + 30.
  so_flda-sign = 'I'.
  so_flda-option = 'BT'.

  APPEND so_flda.

AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    CASE screen-group1.
      WHEN 'SG1'.
        screen-active = gv_change.
        MODIFY SCREEN.
    ENDCASE.

*    IF screen-group1 = 'MOD'.
*      screen-input = 0.
*      screen-output = 1.
*      MODIFY SCREEN.
*    ENDIF.
  ENDLOOP.


AT SELECTION-SCREEN.
  CASE sscrfields-ucomm.
    WHEN 'BTN1'.
      CASE gv_change.
        WHEN '0'.
          gv_change = '1'.
          gv_text = 'Hide'.
        WHEN OTHERS.
          gv_change = '0'.
          gv_text = 'Detail'.
      ENDCASE.
  ENDCASE.
  CASE 'X'.
    WHEN p_rad1.
    WHEN p_rad2.
      MESSAGE i016(pn) WITH 'radio 2'.
    WHEN p_rad3.
  ENDCASE.

  SELECT *
    FROM dv_flights
    INTO gs_flt
    WHERE carrid = p_car AND connid = p_con AND fldate IN so_flda.

    WRITE : /10(5) gs_flt-carrid, 16(5) gs_flt-connid, 22(10) gs_flt-fldate,
              gs_flt-price CURRENCY gs_flt-currency, gs_flt-currency.

  ENDSELECT.

  " type 뒤에 data element, structure, table type

*set parameter id car field p_car.
*set parameter id 'Z01' field p_car.
*set parameter id 'Z01' field p_car.
