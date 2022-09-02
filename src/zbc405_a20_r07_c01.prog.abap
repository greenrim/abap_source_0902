*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_R07_C01
*&---------------------------------------------------------------------*

CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: on_data_changed FOR EVENT data_changed
                   OF cl_gui_alv_grid IMPORTING er_data_changed,
                   on_Data_chnaged_finished FOR EVENT data_changed_finished
                   OF cl_gui_alv_grid IMPORTING e_modified et_good_cells.


ENDCLASS.

CLASS lcl_handler IMPLEMENTATION.
  METHOD on_data_changed.
    DATA ls_mod_cells TYPE lvc_s_modi.

    LOOP AT er_data_changed->mt_mod_cells INTO ls_mod_cells.
      CASE ls_mod_cells-fieldname.
        WHEN 'CUSTOMID'.
          DATA: lv_customid TYPE ztsbook_a20-customid,
                lv_phone    TYPE ztscustom_a20-telephone,
                lv_email    TYPE ztscustom_a20-email,
                lv_name     TYPE ztscustom_a20-name.

          READ TABLE gt_sbook INTO gs_sbook INDEX ls_mod_cells-row_id.

          CALL METHOD er_data_changed->get_cell_value
            EXPORTING
              i_row_id    = ls_mod_cells-row_id
*             i_tabix     =
              i_fieldname = 'CUSTOMID'
            IMPORTING
              e_value     = lv_customid.

          IF lv_customid IS NOT INITIAL.
            READ TABLE gt_custom INTO gs_custom WITH KEY id = lv_customid.
            IF sy-subrc = 0.
              lv_phone = gs_custom-telephone.
              lv_email = gs_custom-email.
              lv_name = gs_custom-name.
            ELSE.
              SELECT SINGLE name telephone email
                FROM ztscustom_a20
                INTO ( lv_name, lv_phone, lv_email )
                WHERE id = lv_customid.
            ENDIF.
          ELSE.
            CLEAR : lv_customid, lv_name, lv_email, lv_phone.
          ENDIF.

          CALL METHOD er_data_changed->modify_cell
            EXPORTING
              i_row_id    = ls_mod_cells-row_id
              i_fieldname = 'TELEPHONE'
              i_value     = lv_phone.

          CALL METHOD er_data_changed->modify_cell
            EXPORTING
              i_row_id    = ls_mod_cells-row_id
              i_fieldname = 'EMAIL'
              i_value     = lv_email.

          CALL METHOD er_data_changed->modify_cell
            EXPORTING
              i_row_id    = ls_mod_cells-row_id
              i_fieldname = 'NAME'
              i_value     = lv_NAME.

          gs_sbook-telephone = lv_phone.
          gs_sbook-email = lv_email.
          gs_sbook-name = lv_name.
          MODIFY gt_sbook FROM gs_sbook INDEX ls_mod_cells-row_id.
      ENDCASE.
    ENDLOOP.

    "INSERT VER1
*    DATA ls_ins_row TYPE lvc_s_moce.
*    FIELD-SYMBOLS : <fs> LIKE gt_sbook.
*
*
*    IF Er_data_changed->mt_inserted_rows IS NOT INITIAL.
*      ASSIGN Er_data_changed->mp_mod_rows->* TO <fs>.
*      IF sy-subrc = 0.
*        APPEND LINES OF <fs> TO gt_sbook.
*
*        LOOP AT Er_data_changed->mt_inserted_rows INTO ls_ins_row.
*          READ TABLE gt_sbook INTO gs_sbook INDEX ls_ins_row-row_id.
*          IF sy-subrc = 0.
*            gs_sbook-carrid = so_car-low.
*
*            CALL METHOD er_data_changed->modify_cell
*              EXPORTING
*                i_row_id    = ls_ins_row-row_id
**               i_tabix     =
*                i_fieldname = 'CARRID'
*                i_value     = gs_sbook-carrid.
*
*            CALL METHOD er_data_changed->modify_cell
*              EXPORTING
*                i_row_id    = ls_ins_row-row_id
**               i_tabix     =
*                i_fieldname = 'ORDER_DATE'
*                i_value     = sy-datum.
*
*            CALL METHOD er_data_changed->modify_cell
*              EXPORTING
*                i_row_id    = ls_ins_row-row_id
**               i_tabix     =
*                i_fieldname = 'CUSTTYPE'
*                i_value     = 'P'.
*
*            CALL METHOD er_data_changed->modify_cell
*              EXPORTING
*                i_row_id    = ls_ins_row-row_id
**               i_tabix     =
*                i_fieldname = 'CLASS'
*                i_value     = 'C'.
*
*            CALL METHOD er_data_changed->modify_style
*              EXPORTING
*                i_row_id    = ls_ins_row-row_id
*                i_fieldname = 'CARRID'
*                i_style     = cl_gui_alv_grid=>mc_style_enabled.
*
*            CALL METHOD er_data_changed->modify_style
*              EXPORTING
*                i_row_id    = ls_ins_row-row_id
*                i_fieldname = 'ORDER_DATE'
*                i_style     = cl_gui_alv_grid=>mc_style_enabled.
*
*            CALL METHOD er_data_changed->modify_style
*              EXPORTING
*                i_row_id    = ls_ins_row-row_id
*                i_fieldname = 'CUSTTYPE'
*                i_style     = cl_gui_alv_grid=>mc_style_enabled.
*
*            CALL METHOD er_data_changed->modify_style
*              EXPORTING
*                i_row_id    = ls_ins_row-row_id
*                i_fieldname = 'CLASS'
*                i_style     = cl_gui_alv_grid=>mc_style_enabled.
*
*            MODIFY gt_sbook FROM gs_sbook INDEX ls_ins_row-row_id.
*          ENDIF.
*        ENDLOOP.
*      ENDIF.
*    ENDIF.

*    INSERT VER2
    FIELD-SYMBOLS : <fs> LIKE gt_sbook.
    DATA : ls_ins_row TYPE lvc_s_moce,
           ls_edit    TYPE lvc_s_styl,
           lt_edit    LIKE TABLE OF ls_edit,
           it_sbook   LIKE TABLE OF gs_sbook.

    IF Er_data_changed->mt_inserted_rows IS NOT INITIAL.
*      LOOP AT er_data_changed->mt_mod_cells INTO ls_mod_cells.
      LOOP AT Er_data_changed->mt_inserted_rows INTO ls_ins_row.
        CLEAR gs_sbook.
        gs_sbook-carrid = so_car-low.
        gs_sbook-custtype = 'P'.
        CALL METHOD er_data_changed->modify_cell
          EXPORTING
            i_row_id    = ls_ins_row-row_id
*           i_tabix     =
            i_fieldname = 'CUSTTYPE'
            i_value     = gs_sbook-custtype.
        "왜 CUSTTYPE만 DEFAULT VALUE 설정이 안 될까
        "it_sbook을 gt_sbook으로 바꾸니까 된당.. 왜될까...

        CALL METHOD er_data_changed->modify_cell
          EXPORTING
            i_row_id    = ls_ins_row-row_id
*           i_tabix     =
            i_fieldname = 'SMOKER'
            i_value     = 'X'.

        CALL METHOD er_data_changed->modify_cell
          EXPORTING
            i_row_id    = ls_ins_row-row_id
*           i_tabix     =
            i_fieldname = 'CARRID'
            i_value     = gs_sbook-carrid.

        CALL METHOD er_data_changed->modify_cell
          EXPORTING
            i_row_id    = ls_ins_row-row_id
*           i_tabix     =
            i_fieldname = 'CLASS'
            i_value     = 'C'.


        CALL METHOD er_data_changed->modify_cell
          EXPORTING
            i_row_id    = ls_ins_row-row_id
*           i_tabix     =
            i_fieldname = 'ORDER_DATE'
            i_value     = sy-datum.


        CALL METHOD er_data_changed->modify_style
          EXPORTING
            i_row_id    = ls_ins_row-row_id
            i_fieldname = 'CARRID'
            i_style     = cl_gui_alv_grid=>mc_style_enabled.

        CALL METHOD er_data_changed->modify_style
          EXPORTING
            i_row_id    = ls_ins_row-row_id
            i_fieldname = 'ORDER_DATE'
            i_style     = cl_gui_alv_grid=>mc_style_enabled.
*
*        CALL METHOD er_data_changed->modify_style
*          EXPORTING
*            i_row_id    = ls_ins_row-row_id
*            i_fieldname = 'CUSTTYPE'
*            i_style     = cl_gui_alv_grid=>mc_style_enabled.

        CALL METHOD er_data_changed->modify_style
          EXPORTING
            i_row_id    = ls_ins_row-row_id
            i_fieldname = 'CLASS'
            i_style     = cl_gui_alv_grid=>mc_style_enabled.

        INSERT gs_sbook INTO gt_sbook INDEX ls_ins_row-row_id.
*        APPEND gs_sbook TO gt_sbook.
      ENDLOOP.
    ENDIF.

    "DELETE
    DATA ls_del_row TYPE lvc_s_moce.
    IF er_data_changed->mt_deleted_rows IS NOT INITIAL.

      LOOP AT er_data_changed->mt_deleted_rows INTO ls_del_row.
        READ TABLE gt_sbook INTO gs_sbook INDEX ls_del_row-row_id.
        IF sy-subrc = 0.
          MOVE-CORRESPONDING gs_sbook TO gs_del_sbook.
          APPEND gs_del_sbook TO gt_del_sbook.
        ENDIF.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.

  METHOD on_Data_chnaged_finished.
    DATA : ls_mod_cells TYPE lvc_s_modi.

    CHECK e_modified = 'X'.
    LOOP AT et_good_cells INTO ls_mod_cells.
      READ TABLE gt_sbook INTO gs_sbook INDEX ls_mod_cells-row_id.
      IF sy-subrc EQ 0.

        gs_sbook-modified = 'X'.
        MODIFY gt_sbook FROM gs_sbook INDEX ls_mod_cells-row_id.

        CALL METHOD go_alv->refresh_table_display.


      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
