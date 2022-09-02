*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_ALV_4_E01
*&---------------------------------------------------------------------*

INITIALIZATION.

AT SELECTION-SCREEN.

AT SELECTION-SCREEN OUTPUT.

START-OF-SELECTION.


  SELECT *
    FROM ztspfli_t03
    INTO CORRESPONDING FIELDS OF TABLE gt_spfli.




  FIELD-SYMBOLS : <fs> LIKE gs_spfli,
                  <fn>.
  DATA lt_tab TYPE TABLE OF ztspfli_t03.

  LOOP AT gt_spfli ASSIGNING <fs>.
    CLEAR <fs>-sum.
    DO 7 TIMES.
      n = n + 1.

      CONCATENATE '<FS>-WTG' n INTO fname.  "문자결합
      CONDENSE fname.                          "공백 삭제
      ASSIGN (fname) TO <fn>.

      gv_sum = gv_sum + <fn>.
    ENDDO.
    <fs>-sum = gv_sum.
    CLEAR : gv_sum.
  ENDLOOP.



  CALL SCREEN 100.
