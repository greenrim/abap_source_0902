*&---------------------------------------------------------------------*
*& Report  SAPBC430S_FILL_CLUSTER_TAB                                  *
*&                                                                     *
*&---------------------------------------------------------------------*
*&                                                                     *
*&                                                                     *
*&---------------------------------------------------------------------*

REPORT  zbc401_a20_tablecopy                                  .

*DATA wa_scarr  TYPE scarr.
*DATA wa_spfli  TYPE spfli.
*DATA wa_flight TYPE sflight.
DATA wa_saplane TYPE saplane.

DATA my_error TYPE i VALUE 0.


START-OF-SELECTION.

* Replace # by Your user-number and remove all * from here

*  DELETE FROM ztscARR_A20.
*  DELETE FROM zTSPFLI_A20.
*  DELETE FROM zTSflight_A20.
  DELETE FROM ztsaplane_A20.
*
*
*  SELECT * FROM scarr INTO wa_scarr.
*    INSERT INTO ztscARR_A20 VALUES wa_scarr.
*  ENDSELECT.
**
*  IF sy-subrc = 0.
*    SELECT * FROM spfli INTO wa_spfli.
*      INSERT INTO zTSPFLI_A20 VALUES wa_spfli.
*    ENDSELECT.
*
*    IF sy-subrc = 0.
*
*      SELECT * FROM sflight INTO wa_flight.
*        INSERT INTO zTSflight_A20 VALUES wa_flight.
*      ENDSELECT.
*      IF sy-subrc <> 0.
*        my_error = 1.
*      ENDIF.
*    ELSE.
*      my_error = 2.
*    ENDIF.
*  ELSE.
*    my_error = 3.
*  ENDIF.

  SELECT * FROM saplane INTO wa_saplane.
    INSERT INTO ztsaplane_A20 VALUES wa_saplane.
  ENDSELECT.

  IF my_error = 0.
    WRITE / 'Data transport successfully finished'.
  ELSE.
    WRITE: / 'ERROR:', my_error.
  ENDIF.
