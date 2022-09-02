*---------------------------------------------------------------------*
*    view related FORM routines
*---------------------------------------------------------------------*
*...processing: ZVSA20VEN.......................................*
FORM GET_DATA_ZVSA20VEN.
  PERFORM VIM_FILL_WHERETAB.
*.read data from database.............................................*
  REFRESH TOTAL.
  CLEAR   TOTAL.
  SELECT * FROM ZTSA20VEN WHERE
(VIM_WHERETAB) .
    CLEAR ZVSA20VEN .
ZVSA20VEN-MANDT =
ZTSA20VEN-MANDT .
ZVSA20VEN-LIFNR =
ZTSA20VEN-LIFNR .
ZVSA20VEN-LAND1 =
ZTSA20VEN-LAND1 .
ZVSA20VEN-NAME1 =
ZTSA20VEN-NAME1 .
ZVSA20VEN-NAME2 =
ZTSA20VEN-NAME2 .
ZVSA20VEN-VENCA =
ZTSA20VEN-VENCA .
ZVSA20VEN-CARRID =
ZTSA20VEN-CARRID .
ZVSA20VEN-MEALNO =
ZTSA20VEN-MEALNO .
ZVSA20VEN-PRICE =
ZTSA20VEN-PRICE .
ZVSA20VEN-WAERS =
ZTSA20VEN-WAERS .
<VIM_TOTAL_STRUC> = ZVSA20VEN.
    APPEND TOTAL.
  ENDSELECT.
  SORT TOTAL BY <VIM_XTOTAL_KEY>.
  <STATUS>-ALR_SORTED = 'R'.
*.check dynamic selectoptions (not in DDIC)...........................*
  IF X_HEADER-SELECTION NE SPACE.
    PERFORM CHECK_DYNAMIC_SELECT_OPTIONS.
  ELSEIF X_HEADER-DELMDTFLAG NE SPACE.
    PERFORM BUILD_MAINKEY_TAB.
  ENDIF.
  REFRESH EXTRACT.
ENDFORM.
*---------------------------------------------------------------------*
FORM DB_UPD_ZVSA20VEN .
*.process data base updates/inserts/deletes.........................*
LOOP AT TOTAL.
  CHECK <ACTION> NE ORIGINAL.
MOVE <VIM_TOTAL_STRUC> TO ZVSA20VEN.
  IF <ACTION> = UPDATE_GELOESCHT.
    <ACTION> = GELOESCHT.
  ENDIF.
  CASE <ACTION>.
   WHEN NEUER_GELOESCHT.
IF STATUS_ZVSA20VEN-ST_DELETE EQ GELOESCHT.
     READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
     IF SY-SUBRC EQ 0.
       DELETE EXTRACT INDEX SY-TABIX.
     ENDIF.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN GELOESCHT.
  SELECT SINGLE FOR UPDATE * FROM ZTSA20VEN WHERE
  LIFNR = ZVSA20VEN-LIFNR .
    IF SY-SUBRC = 0.
    DELETE ZTSA20VEN .
    ENDIF.
    IF STATUS-DELETE EQ GELOESCHT.
      READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY> BINARY SEARCH.
      DELETE EXTRACT INDEX SY-TABIX.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN OTHERS.
  SELECT SINGLE FOR UPDATE * FROM ZTSA20VEN WHERE
  LIFNR = ZVSA20VEN-LIFNR .
    IF SY-SUBRC <> 0.   "insert preprocessing: init WA
      CLEAR ZTSA20VEN.
    ENDIF.
ZTSA20VEN-MANDT =
ZVSA20VEN-MANDT .
ZTSA20VEN-LIFNR =
ZVSA20VEN-LIFNR .
ZTSA20VEN-LAND1 =
ZVSA20VEN-LAND1 .
ZTSA20VEN-NAME1 =
ZVSA20VEN-NAME1 .
ZTSA20VEN-NAME2 =
ZVSA20VEN-NAME2 .
ZTSA20VEN-VENCA =
ZVSA20VEN-VENCA .
ZTSA20VEN-CARRID =
ZVSA20VEN-CARRID .
ZTSA20VEN-MEALNO =
ZVSA20VEN-MEALNO .
ZTSA20VEN-PRICE =
ZVSA20VEN-PRICE .
ZTSA20VEN-WAERS =
ZVSA20VEN-WAERS .
    IF SY-SUBRC = 0.
    UPDATE ZTSA20VEN ##WARN_OK.
    ELSE.
    INSERT ZTSA20VEN .
    ENDIF.
    READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
    IF SY-SUBRC EQ 0.
      <XACT> = ORIGINAL.
      MODIFY EXTRACT INDEX SY-TABIX.
    ENDIF.
    <ACTION> = ORIGINAL.
    MODIFY TOTAL.
  ENDCASE.
ENDLOOP.
CLEAR: STATUS_ZVSA20VEN-UPD_FLAG,
STATUS_ZVSA20VEN-UPD_CHECKD.
MESSAGE S018(SV).
ENDFORM.
*---------------------------------------------------------------------*
FORM READ_SINGLE_ENTRY_ZVSA20VEN.
  SELECT SINGLE * FROM ZTSA20VEN WHERE
LIFNR = ZVSA20VEN-LIFNR .
ZVSA20VEN-MANDT =
ZTSA20VEN-MANDT .
ZVSA20VEN-LIFNR =
ZTSA20VEN-LIFNR .
ZVSA20VEN-LAND1 =
ZTSA20VEN-LAND1 .
ZVSA20VEN-NAME1 =
ZTSA20VEN-NAME1 .
ZVSA20VEN-NAME2 =
ZTSA20VEN-NAME2 .
ZVSA20VEN-VENCA =
ZTSA20VEN-VENCA .
ZVSA20VEN-CARRID =
ZTSA20VEN-CARRID .
ZVSA20VEN-MEALNO =
ZTSA20VEN-MEALNO .
ZVSA20VEN-PRICE =
ZTSA20VEN-PRICE .
ZVSA20VEN-WAERS =
ZTSA20VEN-WAERS .
ENDFORM.
*---------------------------------------------------------------------*
FORM CORR_MAINT_ZVSA20VEN USING VALUE(CM_ACTION) RC.
  DATA: RETCODE LIKE SY-SUBRC, COUNT TYPE I, TRSP_KEYLEN TYPE SYFLENG.
  FIELD-SYMBOLS: <TAB_KEY_X> TYPE X.
  CLEAR RC.
MOVE ZVSA20VEN-LIFNR TO
ZTSA20VEN-LIFNR .
MOVE ZVSA20VEN-MANDT TO
ZTSA20VEN-MANDT .
  CORR_KEYTAB             =  E071K.
  CORR_KEYTAB-OBJNAME     = 'ZTSA20VEN'.
  IF NOT <vim_corr_keyx> IS ASSIGNED.
    ASSIGN CORR_KEYTAB-TABKEY TO <vim_corr_keyx> CASTING.
  ENDIF.
  ASSIGN ZTSA20VEN TO <TAB_KEY_X> CASTING.
  PERFORM VIM_GET_TRSPKEYLEN
    USING 'ZTSA20VEN'
    CHANGING TRSP_KEYLEN.
  <VIM_CORR_KEYX>(TRSP_KEYLEN) = <TAB_KEY_X>(TRSP_KEYLEN).
  PERFORM UPDATE_CORR_KEYTAB USING CM_ACTION RETCODE.
  ADD: RETCODE TO RC, 1 TO COUNT.
  IF RC LT COUNT AND CM_ACTION NE PRUEFEN.
    CLEAR RC.
  ENDIF.

ENDFORM.
*---------------------------------------------------------------------*
