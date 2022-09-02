*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_R02_CLASS
*&---------------------------------------------------------------------*

CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS :
      on_double_click FOR EVENT double_click
        OF cl_gui_alv_grid
        IMPORTING e_row e_column es_row_no,       "더블클릭
      on_tool_bar FOR EVENT toolbar
        OF cl_gui_alv_grid
        IMPORTING e_object e_interactive,         "TOOLBAR 버튼
      on_ucomm FOR EVENT user_command
        OF cl_gui_alv_grid
        IMPORTING e_ucomm,                         "버튼클릭
      on_context FOR EVENT context_menu_request
        OF cl_gui_alv_grid
        IMPORTING e_object.

ENDCLASS.


CLASS lcl_handler IMPLEMENTATION.



  "on_double_click의 구현 logic
  METHOD on_double_click.
    CLEAR : gs_sflight, gs_sub.
    READ TABLE gt_sflight INTO gs_sflight INDEX es_row_no-row_id.

    READ TABLE gt_sub INTO gs_sub
    WITH KEY carrid = gs_sflight-carrid
             connid = gs_sflight-connid
             fldate = gs_sflight-fldate.
    IF sy-subrc <> 0.
      MOVE-CORRESPONDING gs_sflight TO gs_sub.
      APPEND gs_sub TO gt_sub.
    ELSE.
      MESSAGE i016(pn) WITH '이미 존재하는 데이터입니다.'.
    ENDIF.
    CLEAR : gs_sflight, gs_sub.
*
*    LOOP AT gt_sub INTO gs_sub.
*      IF gs_sflight-carrid = gs_sub-carrid
*        AND gs_sflight-connid = gs_sub-carrid
*        AND gs_sflight-fldate = gs_sub-fldate.
*        MESSAGE i016(pn) WITH '이미 존재하는 데이터입니다.'.
*      ELSE.
*        MOVE-CORRESPONDING gs_sflight TO gs_sub.
**    gs_sub = gs_sflight.
*        APPEND gs_sub TO gt_sub.
*      ENDIF.
*    ENDLOOP.

    CALL METHOD go_grid_2->refresh_table_display.
*      EXPORTING
*        is_stable      = gs_stable
*        i_soft_refresh = gv_soft_refresh
*  EXCEPTIONS
*       finished       = 1
*       others         = 2
  ENDMETHOD.

  METHOD on_tool_bar.
    DATA ls_button TYPE stb_button.
    CLEAR ls_button.
    ls_button-butn_type = '3'.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.

    CLEAR ls_button.
    ls_button-function = 'SEL'.
    ls_button-Quickinfo = 'Select all'.
    ls_button-butn_type = '0'.
    ls_button-text = 'SELECT ALL'.

    INSERT ls_button INTO TABLE e_object->mt_toolbar.

    CLEAR ls_button.
    ls_button-butn_type = '3'.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.

    CLEAR ls_button.
    ls_button-function = 'DEL'.
    ls_button-Quickinfo = 'Delete all'.
    ls_button-butn_type = '0'.
    ls_button-text = 'DELETE ALL'.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.

    CLEAR ls_button.
  ENDMETHOD.

  METHOD on_ucomm.
    DATA: ls_row TYPE lvc_s_row,
          lt_row LIKE TABLE OF ls_row.
    DATA: "ls_row TYPE lvc_s_row,
      lt_id_row  TYPE LVC_t_row,
      ls_row_no  TYPE lvc_s_roid,
      lt_row_no  TYPE lvc_t_roid,
      lt_tot_row TYPE lvc_t_roid.

    CALL METHOD go_grid_1->get_selected_rows
      IMPORTING
        et_index_rows = lt_row
*       et_row_no     =
      .


    DATA ls_error TYPE i.

    CASE e_ucomm.
      WHEN 'SEL'.
        DO lines( gt_sflight ) TIMES.
          ls_row_no-row_id = ls_row_no-row_id + 1.
          APPEND ls_row_no TO lt_row_no.
        ENDDO.



        CALL METHOD go_grid_1->set_selected_rows
          EXPORTING
*           it_index_rows = lt_id_row
            it_row_no = lt_row_no
*           is_keep_other_selections =
          .

      WHEN 'DEL'.


        CALL METHOD go_grid_1->set_selected_rows
          EXPORTING
*           it_index_rows = lt_id_row
            it_row_no = lt_row_no
*           is_keep_other_selections =
          .

      WHEN 'CLICK'.

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

    ENDCASE.

  ENDMETHOD.

  METHOD  on_context.

*    CALL METHOD e_object->add_separator.  "구분선

    CALL METHOD cl_ctmenu=>load_gui_status
      EXPORTING
        program = sy-cprog
        status  = 'CT_MENU'
*       disable =
        menu    = e_object
*      EXCEPTIONS
*       read_error = 1
*       others  = 2
      .
    IF sy-subrc <> 0.
*     Implement suitable error handling here
    ENDIF.

  ENDMETHOD.
ENDCLASS.
