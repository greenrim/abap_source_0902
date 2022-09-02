*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZVSA20VEN.......................................*
TABLES: ZVSA20VEN, *ZVSA20VEN. "view work areas
CONTROLS: TCTRL_ZVSA20VEN
TYPE TABLEVIEW USING SCREEN '0020'.
DATA: BEGIN OF STATUS_ZVSA20VEN. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVSA20VEN.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVSA20VEN_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVSA20VEN.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA20VEN_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVSA20VEN_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVSA20VEN.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA20VEN_TOTAL.

*.........table declarations:.................................*
TABLES: ZTSA20VEN                      .
