*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZVA2099.........................................*
TABLES: ZVA2099, *ZVA2099. "view work areas
CONTROLS: TCTRL_ZVA2099
TYPE TABLEVIEW USING SCREEN '0030'.
DATA: BEGIN OF STATUS_ZVA2099. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVA2099.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVA2099_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVA2099.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVA2099_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVA2099_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVA2099.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVA2099_TOTAL.

*.........table declarations:.................................*
TABLES: ZTSA2099                       .
