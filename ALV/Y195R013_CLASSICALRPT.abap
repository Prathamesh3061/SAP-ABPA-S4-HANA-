*&---------------------------------------------------------------------*
*& Report Y195R013_CLASSICALRPT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT y195r013_classicalrpt.

*create structure for vbak table
TYPES : BEGIN OF lty_vbak,
          vbeln TYPE vbeln_va,
          erdat TYPE erdat,
          erzet TYPE erzet,
          ernam TYPE ernam,
          vbtyp TYPE vbtyp,
        END OF lty_vbak.

*create work area and internal table
DATA : lt_vbak TYPE TABLE OF lty_vbak.
DATA : ls_vbak TYPE lty_vbak.


DATA : lt_fieldcat TYPE slis_t_fieldcat_alv.
DATA : ls_fieldcat TYPE slis_fieldcat_alv.

DATA : lt_final TYPE TABLE OF y195s_salesdemo.  "FOR MERGE TWO INTERNAL TABLE INTO SINGLE TABLE.
DATA : ls_final TYPE y195s_salesdemo.

*create strucutre for vbap table
TYPES : BEGIN OF lty_vbap,
          vbeln TYPE vbeln_va,
          posnr TYPE posnr_va,
          matnr TYPE matnr,
        END OF lty_vbap.

*create internal table and work area
DATA: lt_vbap TYPE TABLE OF lty_vbap,
      ls_vbap TYPE lty_vbap.


DATA : lv_vbeln TYPE vbeln_va.


SELECT-OPTIONS: s_vbeln FOR lv_vbeln. " take input


*fetch data
SELECT
  vbeln
  erdat
  erzet
  ernam
  vbtyp
  FROM vbak
  INTO TABLE lt_vbak
  WHERE vbeln IN s_vbeln.


*second table data fetch corresponding to first table
IF lt_vbak IS NOT INITIAL.  "check there is data in table or not
  SELECT
    vbeln
    posnr
    matnr
    FROM vbap
    INTO TABLE lt_vbap
    FOR ALL ENTRIES IN lt_vbak   "check enteries in vbak table and add corresponding enteries
    WHERE vbeln = lt_vbak-vbeln.
ENDIF.


*PUSH DATA INTO FINAL INTERNAL TABLE
LOOP AT lt_vbak INTO ls_vbak.
  LOOP AT lt_vbap INTO ls_vbap WHERE vbeln = ls_vbak-vbeln.
    ls_final-vbeln = ls_vbak-vbeln.
    ls_final-erdat = ls_vbak-erdat.
    ls_final-erzet = ls_vbak-erzet.
    ls_final-ernam = ls_vbak-ernam.
    ls_final-vbtyp = ls_vbak-vbtyp.
    ls_final-posnr = ls_vbap-posnr.
    ls_final-matnr = ls_vbap-matnr.

    APPEND ls_final TO lt_final.
    CLEAR : ls_final.
  ENDLOOP.
ENDLOOP.


**manually creating fieldcatlog
ls_fieldcat-col_pos = '1'.
ls_fieldcat-fieldname = 'VBELN'.
ls_fieldcat-tabname = 'LT_FINAL'.
ls_fieldcat-seltext_l = 'Sales Document Number'.
APPEND ls_fieldcat TO lt_fieldcat.
CLEAR : ls_fieldcat.

ls_fieldcat-col_pos = '2'.
ls_fieldcat-fieldname = 'ERDAT'.
ls_fieldcat-tabname = 'LT_FINAL'.
ls_fieldcat-seltext_l = 'Creation Date'.
APPEND ls_fieldcat TO lt_fieldcat.
CLEAR : ls_fieldcat.

ls_fieldcat-col_pos = '3'.
ls_fieldcat-fieldname = 'ERZET'.
ls_fieldcat-tabname = 'LT_FINAL'.
ls_fieldcat-seltext_l = 'Time'.
APPEND ls_fieldcat TO lt_fieldcat.
CLEAR : ls_fieldcat.

ls_fieldcat-col_pos = '4'.
ls_fieldcat-fieldname = 'ERNAM'.
ls_fieldcat-tabname = 'LT_FINAL'.
ls_fieldcat-seltext_l = 'Name'.
APPEND ls_fieldcat TO lt_fieldcat.
CLEAR : ls_fieldcat.

ls_fieldcat-col_pos = '5'.
ls_fieldcat-fieldname = 'VBTYP'.
ls_fieldcat-tabname = 'LT_FINAL'.
ls_fieldcat-seltext_l = 'Category'.
APPEND ls_fieldcat TO lt_fieldcat.
CLEAR : ls_fieldcat.

ls_fieldcat-col_pos = '6'.
ls_fieldcat-fieldname = 'POSNR'.
ls_fieldcat-tabname = 'LT_FINAL'.
ls_fieldcat-seltext_l = 'Item Number'.
APPEND ls_fieldcat TO lt_fieldcat.
CLEAR : ls_fieldcat.

ls_fieldcat-col_pos = '7'.
ls_fieldcat-fieldname = 'MATNR'.
ls_fieldcat-tabname = 'LT_FINAL'.
ls_fieldcat-seltext_l = 'Material number'.
APPEND ls_fieldcat TO lt_fieldcat.
CLEAR : ls_fieldcat.


**here we modify the catlog fields.
** when us modify never forgot to use transporting.
LOOP AT lt_fieldcat INTO ls_fieldcat.
  IF ls_fieldcat-fieldname = 'VBELN'.
    ls_fieldcat-seltext_l = 'Document Number'.
    MODIFY lt_fieldcat FROM ls_fieldcat TRANSPORTING seltext_l.
  ENDIF.

  IF ls_fieldcat-fieldname = 'ERDAT'.
    ls_fieldcat-col_pos = 3.
    MODIFY lt_fieldcat FROM ls_fieldcat TRANSPORTING col_pos.
  ENDIF.

  IF ls_fieldcat-fieldname = 'ERZET'.
    ls_fieldcat-col_pos = 2.
    MODIFY lt_fieldcat FROM ls_fieldcat TRANSPORTING col_pos.
  ENDIF.

ENDLOOP.


**display data list by use function
CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
  EXPORTING
*   I_INTERFACE_CHECK              = ' '
*   I_BYPASSING_BUFFER             =
*   I_BUFFER_ACTIVE                = ' '
*   I_CALLBACK_PROGRAM             = ' '
*   I_CALLBACK_PF_STATUS_SET       = ' '
*   I_CALLBACK_USER_COMMAND        = ' '
*   I_STRUCTURE_NAME               =
*   IS_LAYOUT     =
    it_fieldcat   = lt_fieldcat
*   IT_EXCLUDING  =
*   IT_SPECIAL_GROUPS              =
*   IT_SORT       =
*   IT_FILTER     =
*   IS_SEL_HIDE   =
*   I_DEFAULT     = 'X'
*   I_SAVE        = ' '
*   IS_VARIANT    =
*   IT_EVENTS     =
*   IT_EVENT_EXIT =
*   IS_PRINT      =
*   IS_REPREP_ID  =
*   I_SCREEN_START_COLUMN          = 0
*   I_SCREEN_START_LINE            = 0
*   I_SCREEN_END_COLUMN            = 0
*   I_SCREEN_END_LINE              = 0
*   IR_SALV_LIST_ADAPTER           =
*   IT_EXCEPT_QINFO                =
*   I_SUPPRESS_EMPTY_DATA          = ABAP_FALSE
*   IO_SALV_ADAPTER                =
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER        =
*   ES_EXIT_CAUSED_BY_USER         =
  TABLES
    t_outtab      = lt_final
  EXCEPTIONS
    program_error = 1
    OTHERS        = 2.
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.


**display for grid
*CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
* EXPORTING
**   I_INTERFACE_CHECK                 = ' '
**   I_BYPASSING_BUFFER                = ' '
**   I_BUFFER_ACTIVE                   = ' '
**   I_CALLBACK_PROGRAM                = ' '
**   I_CALLBACK_PF_STATUS_SET          = ' '
**   I_CALLBACK_USER_COMMAND           = ' '
**   I_CALLBACK_TOP_OF_PAGE            = ' '
**   I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
**   I_CALLBACK_HTML_END_OF_LIST       = ' '
**   I_STRUCTURE_NAME                  =
**   I_BACKGROUND_ID                   = ' '
**   I_GRID_TITLE                      =
**   I_GRID_SETTINGS                   =
**   IS_LAYOUT                         =
*   IT_FIELDCAT                       = lt_fieldcat
**   IT_EXCLUDING                      =
**   IT_SPECIAL_GROUPS                 =
**   IT_SORT                           =
**   IT_FILTER                         =
**   IS_SEL_HIDE                       =
**   I_DEFAULT                         = 'X'
**   I_SAVE                            = ' '
**   IS_VARIANT                        =
**   IT_EVENTS                         =
**   IT_EVENT_EXIT                     =
**   IS_PRINT                          =
**   IS_REPREP_ID                      =
**   I_SCREEN_START_COLUMN             = 0
**   I_SCREEN_START_LINE               = 0
**   I_SCREEN_END_COLUMN               = 0
**   I_SCREEN_END_LINE                 = 0
**   I_HTML_HEIGHT_TOP                 = 0
**   I_HTML_HEIGHT_END                 = 0
**   IT_ALV_GRAPHICS                   =
**   IT_HYPERLINK                      =
**   IT_ADD_FIELDCAT                   =
**   IT_EXCEPT_QINFO                   =
**   IR_SALV_FULLSCREEN_ADAPTER        =
**   O_PREVIOUS_SRAL_HANDLER           =
** IMPORTING
**   E_EXIT_CAUSED_BY_CALLER           =
**   ES_EXIT_CAUSED_BY_USER            =
*  TABLES
*    t_outtab                          = lt_final
* EXCEPTIONS
*   PROGRAM_ERROR                     = 1
*   OTHERS                            = 2
*          .
*IF sy-subrc <> 0.
** Implement suitable error handling here
*ENDIF.
