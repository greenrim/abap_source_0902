*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_ALV_3_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  CASE ok_code.
    WHEN 'BACK' OR 'EXIT' OR 'CANC'.
      LEAVE TO SCREEN 0.

  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  DATA p_ans TYPE c LENGTH 1.
  CASE ok_code.

    WHEN 'SAVE'.

      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
          titlebar              = 'Data Save!'
          text_question         = 'Do you Want to Save!'
          text_button_1         = 'Yes'(001)
          text_button_2         = 'No'(002)
          display_cancel_button = ''
        IMPORTING
          answer                = p_ans
        EXCEPTIONS
          text_not_found        = 1
          OTHERS                = 2.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ELSE.
        IF p_ans = '1'.

          PERFORM data_save.
        ENDIF.
      ENDIF.
  ENDCASE.
ENDMODULE.
