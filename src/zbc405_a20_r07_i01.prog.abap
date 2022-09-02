*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_R07_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.

    WHEN 'CANC'.
      SET SCREEN 0.
      LEAVE SCREEN.

    WHEN 'EXIT'.
      LEAVE PROGRAM.

    WHEN 'ENTER'.

    WHEN 'SAVE'.
      DATA lv_ans TYPE c LENGTH 1.
      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
          titlebar              = 'Data Save'
*         DIAGNOSE_OBJECT       = ' '
          text_question         = TEXT-t01 "Do you want to save the data?
          text_button_1         = 'YES'(001)
*         ICON_BUTTON_1         = ' '
          text_button_2         = 'NO'(002)
*         ICON_BUTTON_2         = ' '
*         DEFAULT_BUTTON        = '1'
          display_cancel_button = 'X'
*         USERDEFINED_F1_HELP   = ' '
*         START_COLUMN          = 25
*         START_ROW             = 6
*         POPUP_TYPE            =
*         IV_QUICKINFO_BUTTON_1 = ' '
*         IV_QUICKINFO_BUTTON_2 = ' '
        IMPORTING
          answer                = lv_ans
* TABLES
*         PARAMETER             =
        EXCEPTIONS
          text_not_found        = 1
          OTHERS                = 2.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.

      CASE lv_ans.
        WHEN '1'.
          "UPDATE
          LOOP AT gt_sbook INTO gs_sbook WHERE modified = 'X' AND bookid <> space.
            UPDATE ztsbook_a20
            SET customid = gs_sbook-customid
                cancelled = gs_sbook-cancelled
            WHERE carrid = gs_sbook-carrid
            AND connid = gs_sbook-connid
            AND fldate = gs_sbook-fldate
            AND bookid = gs_sbook-bookid.
          ENDLOOP.

          "INSERT
          DATA : lv_num      TYPE s_book_id,
                 ls_ret_code TYPE inri-returncode,
                 lv_tabix    LIKE sy-tabix.

          LOOP AT gt_sbook INTO gs_sbook WHERE bookid IS INITIAL.
            lv_tabix = sy-tabix.
            CALL FUNCTION 'NUMBER_GET_NEXT'
              EXPORTING
                nr_range_nr             = '01'
                object                  = 'ZBOOKIDA20'
                subobject               = gs_sbook-carrid
                ignore_buffer           = 'X'
              IMPORTING
                number                  = lv_num
                returncode              = ls_ret_code
              EXCEPTIONS
                interval_not_found      = 1
                number_range_not_intern = 2
                object_not_found        = 3
                quantity_is_0           = 4
                quantity_is_not_1       = 5
                interval_overflow       = 6
                buffer_overflow         = 7
                OTHERS                  = 8.
            IF sy-subrc <> 0.
* Implement suitable error handling here
            ENDIF.

            IF lv_num IS NOT INITIAL.
              gs_sbook-bookid = lv_num.
              MOVE-CORRESPONDING gs_sbook TO gs_ins_sbook.
              APPEND gs_ins_sbook TO gt_ins_sbook.

              MODIFY gt_sbook FROM gs_sbook INDEX lv_tabix TRANSPORTING bookid.
            ENDIF.
          ENDLOOP.

          IF gt_ins_sbook IS NOT INITIAL.
            INSERT ztsbook_a20 FROM TABLE gt_ins_sbook.
          ENDIF.

          IF gt_del_sbook IS NOT INITIAL.
            DELETE ztsbook_a20 FROM TABLE gt_del_sbook.
            CLEAR gt_del_sbook.
          ENDIF.
      ENDCASE.

    WHEN OTHERS.

  ENDCASE.
ENDMODULE.
