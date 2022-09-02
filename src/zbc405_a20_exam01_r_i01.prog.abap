*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_EXAM01_I01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK' OR 'CANC'.
      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.
      PERFORM data_save.
      LEAVE PROGRAM.

    WHEN 'SAVE'.
      PERFORM data_save.

    WHEN OTHERS.

  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
  CASE ok_code.
    WHEN 'BACK' OR 'CANC'.
      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.
      PERFORM data_save.
      LEAVE PROGRAM.

    WHEN 'SAVE'.
      PERFORM data_save.

    WHEN 'ENTER'.
      "REFRESH ALV METHOD
      gv_soft_refresh = 'X'.
      gs_stable-row = 'X'.
      gs_stable-col = 'X'.
      CALL METHOD go_alv->refresh_table_display
        EXPORTING
          is_stable      = gs_stable
          i_soft_refresh = gv_soft_refresh
*  EXCEPTIONS
*         finished       = 1
*         others         = 2
        .
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.
    WHEN OTHERS.

  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  GET_DATA_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_data_0200 INPUT.

  IF ztspfli_a20-carrid IS NOT INITIAL.
    CLEAR gt_spfli.
    gs_car-low = ztspfli_a20-carrid.
    gs_car-sign = 'I'.
    gs_car-option = 'EQ'.
    APPEND gs_car TO gt_car.
  ELSE.
    CLEAR: gt_car, gs_car.
  ENDIF.

  IF ztspfli_a20-connid IS NOT INITIAL.
    gs_con-low = ztspfli_a20-connid.
    gs_con-sign = 'I'.
    gs_con-option = 'EQ'.
    APPEND gs_con TO gt_con.
  ELSE.
    CLEAR: gt_con, gs_con.
  ENDIF.

  SELECT *
    FROM ztspfli_a20
    INTO CORRESPONDING FIELDS OF TABLE gt_spfli
    WHERE carrid IN gt_car
    AND connid IN gt_con.

  LOOP AT gt_spfli INTO gs_spfli.

    "SET I&D
    CLEAR : gs_cellcol.
    IF gs_spfli-countryfr = gs_spfli-countryto.
      CLEAR : gs_cellcol.
      gs_spfli-dIf = 'I'.
      gs_cellcol-fname = 'DIF'.
      gs_cellcol-color-col = col_positive.
      gs_cellcol-color-int = 1.
      gs_cellcol-color-inv = 0.
      APPEND gs_cellcol TO gs_spfli-cellcol.
      CLEAR : gs_cellcol.
    ELSE.
      CLEAR : gs_cellcol.
      gs_spfli-dIf = 'D'.
      gs_cellcol-fname = 'DIF'.
      gs_cellcol-color-col = col_total.
      gs_cellcol-color-int = 1.
      gs_cellcol-color-inv = 0.
      APPEND gs_cellcol TO gs_spfli-cellcol.
      CLEAR : gs_cellcol.
    ENDIF.

    "SET FLTYPE ICON
    CASE gs_SPFLI-fltype.
      WHEN 'X'.
        gs_SPFLI-fltype_icon = icon_ws_plane. "icon_flight.
      WHEN OTHERS.
        gs_SPFLI-fltype_icon  = icon_space.
    ENDCASE.

    "EXCEPTION
    IF gs_spfli-period = 0.
      gs_SPFLI-light = 3.
    ELSEIF gs_spfli-period = 1.
      gs_SPFLI-light = 2.
    ELSEIF gs_spfli-period >= 2.
      gs_SPFLI-light = 1.
    ENDIF.

    "TIME_ZONE
    CLEAR gs_port.
    READ TABLE gt_port INTO gs_port WITH KEY id = gs_spfli-airpfrom.
    gs_spfli-ftzone = gs_port-time_zone.
    CLEAR gs_port.
    READ TABLE gt_port INTO gs_port WITH KEY id = gs_spfli-AIRPto.
    gs_spfli-ttzone = gs_port-time_zone.

    MODIFY gt_spfli FROM gs_spfli.
  ENDLOOP.

ENDMODULE.
