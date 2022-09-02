*&---------------------------------------------------------------------*
*& Include          ZRSAMEN02_A20_C01
*&---------------------------------------------------------------------*


CLASS lcl_event DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS :
      on_toolbar      FOR EVENT toolbar      OF cl_gui_alv_grid IMPORTING e_object,
      on_data_changed FOR EVENT data_changed OF cl_gui_alv_grid IMPORTING er_data_changed,
      on_USER_COMMAND FOR EVENT user_command OF cl_gui_alv_grid IMPORTING e_ucomm.

ENDCLASS.


CLASS lcl_event IMPLEMENTATION.
  METHOD on_toolbar.

    DATA ls_button TYPE stb_button.

    ls_button-function  = 'ALVSAVE'.
    ls_button-icon      = icon_system_save.
    ls_button-butn_type = '0'.
    ls_button-text      = 'SAVE'.

    INSERT ls_button INTO e_object->mt_toolbar INDEX 1.

    PERFORM on_toolbar .

  ENDMETHOD.

  METHOD on_data_changed.

    "insert rows
    PERFORM INSERT_ROWS USING er_data_changed.

    "modify cell
    perform modify_row using er_data_changed.

    "delete rows
    perform delete_rows using er_data_changed.

  ENDMETHOD.

  METHOD on_user_command.
    CASE e_ucomm.
      WHEN 'ALVSAVE'.

        DATA lv_ans.

        CALL FUNCTION 'POPUP_TO_CONFIRM'
          EXPORTING
            titlebar              = '확인'
            text_question         = '변경 내용을 TABLE에 반영하시겠습니까?'
            text_button_1         = '저장'(001)
            text_button_2         = '저장 안 함'(002)
            default_button        = '1'
            display_cancel_button = 'X'
          IMPORTING
            answer                = lv_ans.

        CASE lv_ans.
          WHEN '1'.
            PERFORM data_save.
            MESSAGE s016(pn) WITH '저장이 완료되었습니다.'.

        ENDCASE.

    ENDCASE.

  ENDMETHOD.

ENDCLASS.
