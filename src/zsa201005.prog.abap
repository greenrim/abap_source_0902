*&---------------------------------------------------------------------*
*& Module Pool      ZSA201005
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zsa201005_top                           .    " Global Data

* INCLUDE ZSA201005_O01                           .  " PBO-Modules
* INCLUDE ZSA201005_I01                           .  " PAI-Modules
* INCLUDE ZSA201005_F01                           .  " FORM-Routines

*INITIALIZATION.
*
*AT SELECTION-SCREEN OUTPUT.
*
*AT SELECTION-SCREEN.
*
*AT SELECTION-SCREEN ON VALUE-REQUEST FOR PA_CAR.
*  PERFORM CREATE_F4_FOR_CARRID.
*
*START-OF-SELECTION.
*
*  CLEAR gt_data.
*
*  SELECT a~carrid  a~connid    a~fldate    a~planetype  a~currency
*         b~bookid  b~customid  b~custtype  b~class      b~agencynum
*    FROM sflight AS a INNER JOIN sbook AS b
*      ON a~carrid = b~carrid
*     AND a~connid = b~connid
*     AND a~fldate = b~fldate
*    INTO CORRESPONDING FIELDS OF TABLE gt_data
*   WHERE a~carrid    =  pa_car
*     AND a~connid    IN so_con
*     AND a~planetype =  pa_ptype
*     AND b~bookid    IN so_bid.
*
*    IF SY-SUBRC <> 0.
*      MESSAGE S001(ZMCSA20).
*      LEAVE LIST-PROCESSING.
*      ENDIF.
*
*  CLEAR gs_data.
*
*  LOOP AT gt_data INTO gs_data.
*    CLEAR gs_info.
*
*    CASE gs_data-custtype.
*      WHEN 'B'.
*        MOVE-CORRESPONDING gs_data TO gs_info.
*        APPEND gs_info TO gt_info.
*    ENDCASE.
*
*    CLEAR gs_Data.
*  ENDLOOP.
*
*  SORT gt_info ASCENDING BY carrid connid fldate.
*  DELETE ADJACENT DUPLICATES FROM gt_info COMPARING carrid connid fldate.
*
*IF GT_INFO IS INITIAL.
*   MESSAGE S001(ZMCSA20).
*      LEAVE LIST-PROCESSING.
*  ENDIF.
*  cl_Demo_output=>display_data( gt_info ).
