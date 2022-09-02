FUNCTION ZFSA20_01.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_PERNR) TYPE  ZSSA0073-PERNR
*"  EXPORTING
*"     REFERENCE(EV_ENAME) TYPE  ZSSA0073-ENAME
*"----------------------------------------------------------------------


      SELECT SINGLE ename
        FROM ztsa0001
        INTO EV_ENAME
        WHERE pernr = IV_PERNR.



ENDFUNCTION.
