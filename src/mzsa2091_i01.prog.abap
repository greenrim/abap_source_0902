*&---------------------------------------------------------------------*
*& Include          MZSA2090_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  CASE ok_code.
    WHEN 'EXIT'.
      LEAVE PROGRAM.

    WHEN 'CANC'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.

    WHEN 'ENTER'.
      "Get Airline Name
      PERFORM get_airline_name USING zssa2093-carrid
                               CHANGING zssa2093-carrname.

      "Get Meal Text
      PERFORM get_meal_text USING zssa2093-carrid
                                  zssa2093-mealnumber
                                  sy-langu
                            CHANGING zssa2093-meal_t.

    WHEN 'SEARCH'.
      PERFORM get_meal_info USING zssa2093-carrid
                                  zssa2093-mealnumber
                           CHANGING zssa2094.

      PERFORM get_vendor_info USING 'M'
                                     zssa2093-carrid
                                     zssa2093-mealnumber
                              CHANGING zssa2095.

    WHEN OTHERS.
  ENDCASE.
ENDMODULE.
