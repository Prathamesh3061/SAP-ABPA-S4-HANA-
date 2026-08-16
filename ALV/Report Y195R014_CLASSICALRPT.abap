*&---------------------------------------------------------------------*
*& Report Y195R014_CLASSICALRPT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT y195r014_classicalrpt.


TYPES : BEGIN OF lty_vbak,
          vbeln TYPE vbeln_va,
          erdat TYPE erdat,
          erzet TYPE erzet,
          ernam TYPE ernam,
          vbtyp TYPE vbtypl,
        END OF lty_vbak.

DATA : lt_vbak TYPE TABLE OF lty_vbak.
DATA : lwa_vbak TYPE lty_vbak.


TYPES : BEGIN OF lty_vbap,
          vbeln TYPE vbeln_va,
          posnr TYPE posnr_va,
          matnr TYPE matnr,
        END OF lty_vbap.

DATA : lt_vbap TYPE TABLE OF lty_vbap.
DATA : lwa_vbap TYPE lty_vbap.

DATA : lt_fieldcat_vbak TYPE slis_t_fieldcat_alv.
DATA : lt_fieldcat_vbap TYPE slis_t_fieldcat_alv.
DATA : lwa_fieldcat_vbak TYPE slis_fieldcat_alv.
DATA : lwa_fieldcat_vbap TYPE slis_fieldcat_alv.

DATA : lwa_layout_vbak TYPE slis_layout_alv.
DATA : lwa_layout_vbap TYPE slis_layout_alv.
DATA : lt_events_vbak TYPE slis_T_event.
DATA : lt_events_vbap TYPE slis_T_event.


DATA : lv_vbeln TYPE vbeln_va.  "vbeln_va is data element in the table of vabak.

SELECT-OPTIONS : s_vbeln FOR lv_vbeln.


SELECT vbeln erdat erzet ernam vbtyp
  FROM vbak
  INTO TABLE lt_vbak
  WHERE vbeln IN s_vbeln.

IF lt_vbak IS NOT INITIAL.
  SELECT vbeln posnr matnr
    FROM vbap
    INTO TABLE lt_vbap
    FOR ALL ENTRIES IN lt_vbak
    WHERE vbeln = lt_vbak-vbeln.
ENDIF.

*  here we dont merge our data into single table because we want to differernt blocks.

lwa_fieldcat_vbak-col_pos = '1'.
lwa_fieldcat_vbak-fieldname = 'VBELN'.
lwa_fieldcat_vbak-tabname = 'LT_VBELN'.
lwa_fieldcat_vbak-seltext_l = TEXT-000. "'Sales Document Number'.
APPEND lwa_fieldcat_vbak TO lt_fieldcat_vbak.
CLEAR : lwa_fieldcat_vbak.

lwa_fieldcat_vbak-col_pos = '2'.
lwa_fieldcat_vbak-fieldname = 'ERDAT'.
lwa_fieldcat_vbak-tabname = 'LT_VBELN'.
lwa_fieldcat_vbak-seltext_l = TEXT-001. "'Creation Date'.
APPEND lwa_fieldcat_vbak TO lt_fieldcat_vbak.
CLEAR : lwa_fieldcat_vbak.

lwa_fieldcat_vbak-col_pos = '3'.
lwa_fieldcat_vbak-fieldname = 'ERZET'.
lwa_fieldcat_vbak-tabname = 'LT_VBELN'.
lwa_fieldcat_vbak-seltext_l = TEXT-002. " 'Time'.
APPEND lwa_fieldcat_vbak TO lt_fieldcat_vbak.
CLEAR : lwa_fieldcat_vbak.

lwa_fieldcat_vbak-col_pos = '4'.

lwa_fieldcat_vbak-fieldname = 'ERNAM'.
lwa_fieldcat_vbak-tabname = 'LT_VBELN'.
lwa_fieldcat_vbak-seltext_l = TEXT-003. " 'User Name'.
APPEND lwa_fieldcat_vbak TO lt_fieldcat_vbak.
CLEAR : lwa_fieldcat_vbak.

lwa_fieldcat_vbak-col_pos = '5'.
lwa_fieldcat_vbak-fieldname = 'VBTYP'.
lwa_fieldcat_vbak-tabname = 'LT_VBELN'.
lwa_fieldcat_vbak-seltext_l = TEXT-004. "'Document Category'.
APPEND lwa_fieldcat_vbak TO lt_fieldcat_vbak.
CLEAR : lwa_fieldcat_vbak.


lwa_fieldcat_vbap-col_pos = '1'.
lwa_fieldcat_vbap-fieldname = 'VBELN'.
lwa_fieldcat_vbap-tabname = 'LT_VBAP'.
lwa_fieldcat_vbap-seltext_l = TEXT-000. "'Sales Document Number'.
APPEND lwa_fieldcat_vbap TO lt_fieldcat_vbap.
CLEAR : lwa_fieldcat_vbap.

lwa_fieldcat_vbap-col_pos = '2'.
lwa_fieldcat_vbap-fieldname = 'POSNR'.
lwa_fieldcat_vbap-tabname = 'LT_VBAP'.
lwa_fieldcat_vbap-seltext_l = TEXT-005. " 'Item Number'.
APPEND lwa_fieldcat_vbap TO lt_fieldcat_vbap.
CLEAR : lwa_fieldcat_vbap.

lwa_fieldcat_vbap-col_pos = '3'.
lwa_fieldcat_vbap-fieldname = 'MATNR'.
lwa_fieldcat_vbap-tabname = 'LT_VBAP'.
lwa_fieldcat_vbap-seltext_l = TEXT-006. " 'Material Number'.
APPEND lwa_fieldcat_vbap TO lt_fieldcat_vbap.
CLEAR : lwa_fieldcat_vbap.


CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_INIT'
  EXPORTING
    i_callback_program             = sy-repid  " here we need to call out program name so we use system variable. we can use Y195R014_CLASSICALRPT also.
*   I_CALLBACK_PF_STATUS_SET       = ' '
*   I_CALLBACK_USER_COMMAND        = ' '
*   IT_EXCLUDING                   =
          .


CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_APPEND'
  EXPORTING
    is_layout                        = lwa_layout_vbak
    it_fieldcat                      = lt_fieldcat_vbak
    i_tabname                        = 'LT_VBAK'
    it_events                        = lt_events_vbak
*   IT_SORT                          =
*   I_TEXT                           = ' '
  TABLES
    t_outtab                         = lt_vbak
 EXCEPTIONS                                         "never forget to uncomment these after importing.
   PROGRAM_ERROR                    = 1
   MAXIMUM_OF_APPENDS_REACHED       = 2
   OTHERS                           = 3
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.


CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_APPEND'
  EXPORTING
    is_layout                        = lwa_layout_vbap
    it_fieldcat                      = lt_fieldcat_vbap
    i_tabname                        = 'LT_VBAP'
    it_events                        = lt_events_vbap
*   IT_SORT                          =
*   I_TEXT                           = ' '
  TABLES
    t_outtab                         = lt_vbap
 EXCEPTIONS                                         "never forget to uncomment these after importing.
   PROGRAM_ERROR                    = 1
   MAXIMUM_OF_APPENDS_REACHED       = 2
   OTHERS                           = 3
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.


CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_DISPLAY'
* EXPORTING
*   I_INTERFACE_CHECK             = ' '
*   IS_PRINT                      =
*   I_SCREEN_START_COLUMN         = 0
*   I_SCREEN_START_LINE           = 0
*   I_SCREEN_END_COLUMN           = 0
*   I_SCREEN_END_LINE             = 0
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER       =
*   ES_EXIT_CAUSED_BY_USER        =
 EXCEPTIONS
   PROGRAM_ERROR                 = 1
   OTHERS                        = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
