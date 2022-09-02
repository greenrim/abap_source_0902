*&---------------------------------------------------------------------*
*& Include          MZSA2450T_I01
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

    WHEN 'Enter'.

    WHEN 'TAB1' OR 'TAB2'.
      ts_info-activetab = ok_code.

    WHEN 'SEARCH'.

      "get_Inflight Meal info
*        select single carrid mealnumber mealtype
*          FROM smeal
*          into CORRESPONDING FIELDS OF zssa2451
*          WHERE carrid = zssa24vencond-carrid.
*
*         select SINGLE carrname
*           FROM scarr
*           into zssa2451-carrname
*           WHERE carrid = zssa24vencond-carrid.
*
*         select SINGLE *
*           FROM ztsa24ven
*           into CORRESPONDING FIELDS OF zssa2451
*           WHERE mealno = zssa24vencond-mealno.
*
      SELECT SINGLE a~carrid mealnumber mealtype carrname
        FROM smeal AS a INNER JOIN scarr AS b
        ON a~carrid = b~carrid
        INTO CORRESPONDING FIELDS OF zssa2451
        WHERE a~carrid = zssa24vencond-carrid.

      SELECT SINGLE text
        FROM smealt
        INTO zssa2451-text
        WHERE carrid = zssa24vencond-carrid.

      "get Vender info
      SELECT SINGLE *
        FROM ztsa24ven
        INTO CORRESPONDING FIELDS OF zssa2452
        WHERE mealno = zssa24vencond-mealno.

  ENDCASE.
ENDMODULE.
