*---------------------------------------------------------------------*
*    view related FORM routines
*---------------------------------------------------------------------*
*...processing: ZVA2099.........................................*
FORM GET_DATA_ZVA2099.
  PERFORM VIM_FILL_WHERETAB.
*.read data from database.............................................*
  REFRESH TOTAL.
  CLEAR   TOTAL.
  SELECT * FROM ZTSA2099 WHERE
(VIM_WHERETAB) .
    CLEAR ZVA2099 .
ZVA2099-MAND =
ZTSA2099-MAND .
ZVA2099-LIFNR =
ZTSA2099-LIFNR .
ZVA2099-LAND1 =
ZTSA2099-LAND1 .
ZVA2099-NAME1 =
ZTSA2099-NAME1 .
ZVA2099-NAME2 =
ZTSA2099-NAME2 .
ZVA2099-VENCA =
ZTSA2099-VENCA .
ZVA2099-CARRID =
ZTSA2099-CARRID .
ZVA2099-MEALNUMBER =
ZTSA2099-MEALNUMBER .
ZVA2099-PRICE =
ZTSA2099-PRICE .
ZVA2099-WAERS =
ZTSA2099-WAERS .
<VIM_TOTAL_STRUC> = ZVA2099.
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
FORM DB_UPD_ZVA2099 .
*.process data base updates/inserts/deletes.........................*
LOOP AT TOTAL.
  CHECK <ACTION> NE ORIGINAL.
MOVE <VIM_TOTAL_STRUC> TO ZVA2099.
  IF <ACTION> = UPDATE_GELOESCHT.
    <ACTION> = GELOESCHT.
  ENDIF.
  CASE <ACTION>.
   WHEN NEUER_GELOESCHT.
IF STATUS_ZVA2099-ST_DELETE EQ GELOESCHT.
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
  SELECT SINGLE FOR UPDATE * FROM ZTSA2099 WHERE
  LIFNR = ZVA2099-LIFNR .
    IF SY-SUBRC = 0.
    DELETE ZTSA2099 .
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
  SELECT SINGLE FOR UPDATE * FROM ZTSA2099 WHERE
  LIFNR = ZVA2099-LIFNR .
    IF SY-SUBRC <> 0.   "insert preprocessing: init WA
      CLEAR ZTSA2099.
    ENDIF.
ZTSA2099-MAND =
ZVA2099-MAND .
ZTSA2099-LIFNR =
ZVA2099-LIFNR .
ZTSA2099-LAND1 =
ZVA2099-LAND1 .
ZTSA2099-NAME1 =
ZVA2099-NAME1 .
ZTSA2099-NAME2 =
ZVA2099-NAME2 .
ZTSA2099-VENCA =
ZVA2099-VENCA .
ZTSA2099-CARRID =
ZVA2099-CARRID .
ZTSA2099-MEALNUMBER =
ZVA2099-MEALNUMBER .
ZTSA2099-PRICE =
ZVA2099-PRICE .
ZTSA2099-WAERS =
ZVA2099-WAERS .
    IF SY-SUBRC = 0.
    UPDATE ZTSA2099 ##WARN_OK.
    ELSE.
    INSERT ZTSA2099 .
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
CLEAR: STATUS_ZVA2099-UPD_FLAG,
STATUS_ZVA2099-UPD_CHECKD.
MESSAGE S018(SV).
ENDFORM.
*---------------------------------------------------------------------*
FORM READ_SINGLE_ENTRY_ZVA2099.
  SELECT SINGLE * FROM ZTSA2099 WHERE
LIFNR = ZVA2099-LIFNR .
ZVA2099-MAND =
ZTSA2099-MAND .
ZVA2099-LIFNR =
ZTSA2099-LIFNR .
ZVA2099-LAND1 =
ZTSA2099-LAND1 .
ZVA2099-NAME1 =
ZTSA2099-NAME1 .
ZVA2099-NAME2 =
ZTSA2099-NAME2 .
ZVA2099-VENCA =
ZTSA2099-VENCA .
ZVA2099-CARRID =
ZTSA2099-CARRID .
ZVA2099-MEALNUMBER =
ZTSA2099-MEALNUMBER .
ZVA2099-PRICE =
ZTSA2099-PRICE .
ZVA2099-WAERS =
ZTSA2099-WAERS .
ENDFORM.
*---------------------------------------------------------------------*
FORM CORR_MAINT_ZVA2099 USING VALUE(CM_ACTION) RC.
  DATA: RETCODE LIKE SY-SUBRC, COUNT TYPE I, TRSP_KEYLEN TYPE SYFLENG.
  FIELD-SYMBOLS: <TAB_KEY_X> TYPE X.
  CLEAR RC.
MOVE ZVA2099-LIFNR TO
ZTSA2099-LIFNR .
MOVE ZVA2099-MAND TO
ZTSA2099-MAND .
  CORR_KEYTAB             =  E071K.
  CORR_KEYTAB-OBJNAME     = 'ZTSA2099'.
  IF NOT <vim_corr_keyx> IS ASSIGNED.
    ASSIGN CORR_KEYTAB-TABKEY TO <vim_corr_keyx> CASTING.
  ENDIF.
  ASSIGN ZTSA2099 TO <TAB_KEY_X> CASTING.
  PERFORM VIM_GET_TRSPKEYLEN
    USING 'ZTSA2099'
    CHANGING TRSP_KEYLEN.
  <VIM_CORR_KEYX>(TRSP_KEYLEN) = <TAB_KEY_X>(TRSP_KEYLEN).
  PERFORM UPDATE_CORR_KEYTAB USING CM_ACTION RETCODE.
  ADD: RETCODE TO RC, 1 TO COUNT.
  IF RC LT COUNT AND CM_ACTION NE PRUEFEN.
    CLEAR RC.
  ENDIF.

ENDFORM.
*---------------------------------------------------------------------*
