*&---------------------------------------------------------------------*
*& Include          ZSA201010_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_employee_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_employee_data .

  CLEAR gt_data.
  SELECT pernr ename entdt gender depid
    FROM ztsa20emp
    INTO CORRESPONDING FIELDS OF TABLE gt_data
   WHERE pernr IN so_pern.

  IF sy-subrc NE 0.
    MESSAGE i001.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_fcat_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fcat_layout .

  gs_layout-sel_mode = 'X'.
  gs_layout-zebra = 'X'.
*  gs_layout-cwidth_opt = 'X'.
  gs_layout-stylefname = 'STYLE'.

  IF gt_fcat IS INITIAL.

    PERFORM set_fcat USING :
     'X'  'PERNR'    ' '   'ZTSA20EMP'  'PERNR'    'X'  10,
     ' '  'ENAME'    ' '   'ZTSA20EMP'  'ENAME'    'X'  20,
     ' '  'ENTDT'    ' '   'ZTSA20EMP'  'ENTDT'    'X'  10,
     ' '  'GENDER'   ' '   'ZTSA20EMP'  'GENDER'   'X'  5,
     ' '  'DEPID'    ' '   'ZTSA20EMP'  'DEPID'    'X'  8,
     ' '  'CARRID'   ' '   'SCARR'      'CARRID'   'X'  10,
     ' '  'CARRNAME' ' '   'SCARR'      'CARRNAME' ' '  20.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_fcat
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&---------------------------------------------------------------------*
FORM set_fcat  USING  pv_key pv_fname pv_text pv_ref_table pv_ref_field pv_edit pv_length.

  gt_fcat = VALUE #( BASE gt_fcat
                    ( key       = pv_key
                      fieldname = pv_fname
                      coltext   = pv_text
                      ref_table = pv_ref_table
                      ref_field = pv_ref_field
                      edit      = pv_edit
                      outputlen = pv_length
                    )
                   ).



ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_screen
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_screen .
  IF gcl_container IS NOT BOUND.
    CREATE OBJECT gcl_container
      EXPORTING
        repid     = sy-repid
        dynnr     = sy-dynnr
        side      = gcl_container->dock_at_left
        extension = 3000.

    CREATE OBJECT gcl_grid
      EXPORTING
        i_parent = gcl_container.

    gs_variant-report = sy-repid.

    SET HANDLER : lcl_event_handler=>handle_data_changed    FOR gcl_grid,
                  lcl_event_handler=>handle_change_finished FOR gcl_grid.

    CALL METHOD gcl_grid->register_edit_event
      EXPORTING
        i_event_id = cl_gui_alv_grid=>mc_evt_modified
      EXCEPTIONS
        error      = 1
        OTHERS     = 2.

    CALL METHOD gcl_grid->set_table_for_first_display
      EXPORTING
        is_variant      = gs_variant
        i_save          = 'A'
        i_default       = 'X'
        is_layout       = gs_layout
      CHANGING
        it_outtab       = gt_data
        it_fieldcatalog = gt_fcat.

  ELSE.

  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form create_row
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM create_row .

  CLEAR gs_data.
  APPEND gs_data TO gt_Data.

  PERFORM refresh_grid.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form refresh_grid
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM refresh_grid .

  gs_stable-row = 'X'.
  gs_stable-col = 'X'.

  CALL METHOD gcl_grid->refresh_table_display
    EXPORTING
      is_stable      = gs_stable
      i_soft_refresh = space.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form save_emp_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM save_emp_data .

  "DB??? ???????????? ???????????? TABLE????????? ????????? ???????????????

  DATA : lt_save  TYPE TABLE OF ztsa20emp,
         ls_save  LIKE LINE OF lt_save,
         lt_del   TYPE TABLE OF ztsa20emp,
         lv_error.

  REFRESH lt_save.

  CALL METHOD gcl_grid->check_changed_data.
  "alv??? ????????? ?????? itab?????? ????????????

  CLEAR: lv_error, lt_save.

  LOOP AT gt_data INTO gs_Data.
    IF gs_data-pernr IS INITIAL.

      MESSAGE s000 WITH TEXT-e01 DISPLAY LIKE 'E'.
      lv_error ='X'.                             "?????? ???????????? ?????? ?????? flow ??????????????? ????????? ?????? setting
      EXIT.
    ENDIF.                                  "?????? ???????????? ????????? ???????????? (????????? loop??? ????????????)
    "exit??? ????????? ?????? ?????? ?????? ????????? ???????????? ?????? exit??? ????????? loop??? ????????????

    lt_save = VALUE #( BASE lt_save            "?????? ?????? ???????????? ????????? itan??? ????????? ??????
                      (
                        pernr  = gs_data-pernr
                        ename  = gs_data-ename
                        entdt  = gs_data-entdt
                        gender = gs_data-gender
                        depid  = gs_data-depid
                        )
                      ).
*    MOVE-CORRESPONDING gs_data TO ls_save.
*    APPEND ls_save TO lt_save.

  ENDLOOP.

*  CHECK lv_error IS INITIAL.
  "check ?????? ??? ????????? ????????? ????????? ??? ?????? ????????? ?????????
  "????????? ????????? ?????? ?????? ??????

  IF lv_error IS NOT INITIAL.  "????????? ????????? ?????? ????????? ????????????
    EXIT.
  ENDIF.


  IF gt_data_del IS NOT INITIAL.

    LOOP AT gt_data_del INTO DATA(ls_del).
      lt_del = VALUE #( BASE lt_del
                        ( pernr = ls_del-pernr )
                      ).
    ENDLOOP.

    DELETE ztsa20emp FROM TABLE lt_del.

    IF sy-dbcnt > 0.
      COMMIT WORK AND WAIT.
    ENDIF.

  ENDIF.


  IF lt_save IS NOT INITIAL.

    MODIFY ztsa20emp FROM TABLE lt_save.

    IF sy-dbcnt > 0.
      COMMIT WORK AND WAIT.
      MESSAGE s000 WITH TEXT-s01. "data ?????? ?????? ?????????
    ENDIF.

  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form delete_row
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM delete_row .

  REFRESH gt_rows.

  "???????????? ????????? ?????? ????????? ?????????
  CALL METHOD gcl_grid->get_selected_rows
    IMPORTING
      et_index_rows = gt_rows.

  "?????? ??????????????? ??????
  IF gt_rows IS INITIAL.
    MESSAGE s000 WITH TEXT-e02 DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  SORT gt_rows BY index DESCENDING.

  LOOP AT gt_rows INTO gs_row.
    "itab?????? ???????????? ?????? db table????????? ?????????????????????
    "?????? ????????? ?????? ??????
    READ TABLE gt_data INTO gs_data INDEX gs_row-index.

    IF sy-subrc EQ 0.
      APPEND gs_data TO gt_data_del.

    ENDIF.
    "???????????? ????????? ?????? ?????? ??????
    DELETE gt_data INDEX gs_row-index.
  ENDLOOP.

  "????????? itab??? alv??? ??????
  PERFORM refresh_grid.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_STYLE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_style .

  DATA : lv_tabix TYPE sy-tabix,
         ls_style TYPE lvc_s_styl,
         lt_style TYPE lvc_t_styl.

  "structure ??????
*  ls_style-fieldname = 'PERNR'.
*  ls_style-style     = cl_gui_alv_grid=>mc_style_disabled.
*  APPEND ls_style TO lt_style.

  ls_style = VALUE #( fieldname = 'PERNR'
                      style     = cl_gui_alv_grid=>mc_style_disabled ).
  APPEND ls_style TO lt_style.

  "table?????? ????????? ???????????? pk??? ?????? ?????? ????????? ?????? ?????? ?????????
  LOOP AT gt_data INTO gs_data.
    lv_tabix = sy-tabix.
    REFRESH gs_data-style.

    APPEND ls_style TO gs_data-style.
    MODIFY gt_data FROM gs_data INDEX lv_tabix TRANSPORTING style.


  ENDLOOP.

  "internal table ??????
*
*lt_style = value #(
*                    ( fieldname = 'PERNR'
*                      style     = cl_gui_alv_grid=>mc_style_disabled )
*                  ).

*  LOOP AT gt_data INTO gs_data.
*    lv_tabix = sy-tabix.
*    REFRESH gs_data-style.
*
**    APPEND lines of lt_style TO gs_data-style.
**    gs_emp-style = lt_style.
**    MOVE-CORRESPONDING lt_style to gs_emp-style.
**    insert lt_style into table gs_data-style. ?????? ??? ???????????? ?????????
*
*    MODIFY gt_data FROM gs_data INDEX lv_tabix TRANSPORTING style.
*
*
*  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form handle_data_changed
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ER_DATA_CHANGED
*&---------------------------------------------------------------------*
FORM handle_data_changed  USING pcl_data_changed TYPE REF TO
                                cl_alv_changed_data_protocol.

  LOOP AT pcl_data_changed->mt_mod_cells INTO DATA(ls_modi).

    READ TABLE gt_data INTO gs_data INDEX ls_modi-row_id.

    IF sy-subrc NE 0.
      CONTINUE.
    ENDIF.

    SELECT SINGLE carrname
      INTO gs_data-carrname
      FROM scarr
     WHERE carrid = ls_modi-value.  "NEW VALUE

    IF sy-subrc NE 0.
      CLEAR gs_data-carrname.
    ENDIF.

      MODIFY gt_data FROM gs_data INDEX ls_modi-row_id
      TRANSPORTING carrname.

  ENDLOOP.

  PERFORM refresh_grid.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form handle_change_finished
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_MODIFIED
*&      --> ET_GOOD_CELLS
*&---------------------------------------------------------------------*
FORM handle_change_finished  USING    pv_modified
                                      pt_good_cells TYPE lvc_t_modi.

*  DATA : ls_modi TYPE lvc_s_modi.

*  LOOP AT pt_good_cells INTO DATA(ls_modi).
**  LOOP AT pcl_data_changed->mt_mod_cells INTO DATA(ls_modi).
*
*    READ TABLE gt_data INTO gs_data INDEX ls_modi-row_id.
*
*    IF sy-subrc NE 0.
*      CONTINUE.
*    ENDIF.
*
*    SELECT SINGLE carrname
*      INTO gs_data-carrname
*      FROM scarr
*     WHERE carrid = gs_data-carrid.   "ls_modi-value.  "NEW VALUE
*
*    IF sy-subrc NE 0.
*      CLEAR gs_data-carrname.
*    ENDIF.
*
*      MODIFY gt_data FROM gs_data INDEX ls_modi-row_id
*      TRANSPORTING carrname.
*
*  ENDLOOP.
*
*  PERFORM refresh_grid.



*  ENDLOOP.

ENDFORM.
