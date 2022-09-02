*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_R02_L_I01
*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'EXIT'.

    WHEN 'CANC'.

    WHEN 'BACK'.
      LEAVE TO SCREEN 0.

    WHEN 'BTN'.
      DATA: ls_row TYPE lvc_s_row,
            lt_row LIKE TABLE OF ls_row.

      CALL METHOD go_grid_1->get_selected_rows
        IMPORTING
          et_index_rows = lt_row
*         et_row_no     =
        .

      DATA ls_error TYPE i.

      CLEAR : gs_sflight, gs_sub, ls_error.

*        IF LINEs( lt_row ) > 1.
      LOOP AT lt_row INTO ls_row.
        READ TABLE gt_sflight INTO gs_sflight INDEX ls_row-index.
        READ TABLE gt_sub INTO gs_sub WITH KEY carrid = gs_sflight-carrid
                                               connid = gs_sflight-connid
                                               fldate = gs_sflight-fldate.
        IF sy-subrc <> 0.
          MOVE-CORRESPONDING gs_sflight TO gs_sub.
          APPEND gs_sub TO gt_sub.
        ELSE.
          ls_error = 1.
        ENDIF.
      ENDLOOP.

      CALL METHOD go_grid_2->refresh_table_display.

      IF ls_error <> 0.
        IF LINEs( lt_row ) = 1.
          MESSAGE i016(pn) WITH '이미 존재하는 데이터입니다.' .
        ELSEIF LINEs( lt_row ) > 1.
          MESSAGE i016(pn) WITH '중복된 데이터를 제외하고 추가하였습니다.'.
        ENDIF.
      ENDIF.
      CLEAR : gs_sflight, gs_sub, ls_error.
    WHEN OTHERS.
  ENDCASE.
ENDMODULE.
