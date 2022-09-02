*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZVSA2004........................................*
TABLES: ZVSA2004, *ZVSA2004. "view work areas
CONTROLS: TCTRL_ZVSA2004
TYPE TABLEVIEW USING SCREEN '0010'.
DATA: BEGIN OF STATUS_ZVSA2004. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVSA2004.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVSA2004_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVSA2004.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA2004_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVSA2004_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVSA2004.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA2004_TOTAL.

*...processing: ZVSA2005........................................*
TABLES: ZVSA2005, *ZVSA2005. "view work areas
CONTROLS: TCTRL_ZVSA2005
TYPE TABLEVIEW USING SCREEN '0020'.
DATA: BEGIN OF STATUS_ZVSA2005. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVSA2005.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVSA2005_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVSA2005.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA2005_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVSA2005_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVSA2005.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA2005_TOTAL.

*...processing: ZVSA20PRO.......................................*
TABLES: ZVSA20PRO, *ZVSA20PRO. "view work areas
CONTROLS: TCTRL_ZVSA20PRO
TYPE TABLEVIEW USING SCREEN '0030'.
DATA: BEGIN OF STATUS_ZVSA20PRO. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVSA20PRO.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVSA20PRO_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVSA20PRO.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA20PRO_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVSA20PRO_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVSA20PRO.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA20PRO_TOTAL.

*.........table declarations:.................................*
TABLES: ZTSA2001                       .
TABLES: ZTSA2002                       .
TABLES: ZTSA2002_T                     .
TABLES: ZTSA20PRO                      .
TABLES: ZTSA20PRO_T                    .
