*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_2_E01
*&---------------------------------------------------------------------*

INITIALIZATION.
  so_cid-sign = 'I'.
  SO_cid-option = 'BT'.
  so_cid-low = 'AA'.
  so_cid-high = 'QF'.
  APPEND so_cid.

  so_cid-sign = 'E'.
  SO_cid-option = 'EQ'.
  so_cid-low = 'AZ'.
  APPEND so_cid.

  so_flda-sign = 'I'.
  so_flda-option = 'BT'.
  so_flda-low = '20200101'.
  so_flda-high+0(4) = so_flda-low(4) + 2.
  so_flda-high+4(4) = '0101'.
  APPEND so_flda.

AT SELECTION-SCREEN OUTPUT.

AT SELECTION-SCREEN.

START-OF-SELECTION.

  CASE 'X'.
    WHEN pa_rad1.
      SELECT *
        FROM dv_flights
        INTO CORRESPONDING FIELDS OF TABLE gt_flights
        WHERE carrid IN so_cid
        AND connid IN so_nid
        AND fldate IN so_flda.

    WHEN 'pa_rad2'.
      SELECT *
  FROM dv_flights
  INTO CORRESPONDING FIELDS OF TABLE gt_flights
  WHERE carrid IN so_cid
  AND connid IN so_nid
  AND fldate IN so_flda
  AND countryto <> dv_flights~countryfr.

    WHEN 'pa_rad3'.
      SELECT *
        FROM dv_flights
        INTO CORRESPONDING FIELDS OF TABLE gt_flights
        WHERE carrid IN so_cid
        AND connid IN so_nid
        AND fldate IN so_flda
        AND countryto = dv_flights~countryfr.

  ENDCASE.

  cl_demo_output=>display_data( gt_flights ).
