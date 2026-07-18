*&---------------------------------------------------------------------*
*& Report Y195001R_CLASSICALRPT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT y195001r_classicalrpt.

DATA: gv_num1  TYPE i,
      gv_char  TYPE string,
      gv_char1 TYPE string,
      gv_char2 TYPE string,
      gv_char3 TYPE string,
      gv_CHAR4 TYPE c LENGTH 20.
*      gv_char TYPE char10,
*      gv_char1 TYPE char10,
*      gv_char2 TYPE char10,
*      gv_char3 TYPE char10.

CONSTANTS: cv_firstname TYPE string VALUE 'john',
           cv_lastname  TYPE string VALUE 'smith'.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_num1 TYPE i,
              p_num2 TYPE i.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.

  SELECTION-SCREEN BEGIN OF LINE.
*PARAMETERS : rb_add RADIOBUTTON GROUP g1,
*             rb_sub RADIOBUTTON GROUP g1,
*             rb_mult RADIOBUTTON GROUP g1,
*             rb_div RADIOBUTTON GROUP g1,
*             rb_mod RADIOBUTTON GROUP g1.

    PARAMETERS : rb_add RADIOBUTTON GROUP g1 USER-COMMAND uc1 DEFAULT 'X'.
    SELECTION-SCREEN COMMENT (8) TEXT-003.
    PARAMETERS: rb_sub RADIOBUTTON GROUP g1.
    SELECTION-SCREEN COMMENT (8) TEXT-004.
    PARAMETERS: rb_mult RADIOBUTTON GROUP g1.
    SELECTION-SCREEN COMMENT (8) TEXT-005.
    PARAMETERS:rb_div RADIOBUTTON GROUP g1.
    SELECTION-SCREEN COMMENT (8) TEXT-006.
    PARAMETERS:rb_mod RADIOBUTTON GROUP g1.
    SELECTION-SCREEN COMMENT (8) TEXT-007.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b2.
*
*INITIALIZATION.
*  p_num1 = '12'.
*  p_num2 = '10'.


AT SELECTION-SCREEN OUTPUT.

START-OF-SELECTION.
*IF rb_add = 'X'.
*    gv_num1 = p_num1 + p_num2.
*  ELSEIF rb_sub = 'X'.
*    gv_num1 = p_num1 - p_num2.
*  ELSEIF rb_mult = 'X'.
*    gv_num1 = p_num1 * p_num2.
*   ELSEIF rb_div = 'X'.
*     gv_num1 = p_num1 / p_num2.
*   ELSEIF rb_mod = 'X'.
*     gv_num1 = p_num1 MOD p_num2.
*ENDIF.

* WRITE: gv_num1.
*gv_char1 = '1001'.
*gv_char2 = '-201'.
*WRITE:/ gv_char1 COLOR COL_POSITIVE.
*WRITE: gv_char2 NO-SIGN.
*WRITE:/ gv_char2 COLOR COL_NEGATIVE.

*WRITE: 'Employee Details'.
*ULINE.
*WRITE: 'EMPNO', 15 'EMP name'.
*ULINE.
*SKIP.
*SKIP.
*WRITE: '132', 15 'Robert'.
*NEW-PAGE.
*WRITE: 'salary details'.

*CONCATENATE cv_firstname cv_lastname INTO gv_char1 SEPARATED BY space.
*CONCATENATE cv_firstname cv_lastname INTO gv_char1 SEPARATED BY '-'.
*
*WRITE:/ cv_firstname.
*WRITE:/ cv_lastname.
*WRITE:/  gv_char1.


*gv_char = 'abcd-efgh-igh8'.
*SPLIT gv_char AT '-' INTO gv_char1 gv_char2 gv_char3.
*WRITE: / gv_char1.
*WRITE: / gv_char2.
*WRITE: / gv_char3.

*gv_char = '      123'.
*CONDENSE gv_char.
*
*WRITE gv_char.

*gv_char = 'SAP ABAP PROGRAMMING'.
*SEARCH gv_char FOR 'ABAP'.
*IF sy-subrc = 0.
*  WRITE: / 'ABAP IS FOUND AT POSITION: ', sy-fdpos.
*ELSE.
*  WRITE: / 'ABAP IS NOT FOUND'.
*ENDIF.

*gv_char = 'SAP ABAP PROGRAMMING ERP'.
*WRITE: / strlen( gv_char ).
*WRITE: / gv_char.

*SHIFT gv_char LEFT BY 2 PLACES.
*WRITE: / gv_char.
*
*SHIFT gv_char RIGHT BY 2 PLACES.
*WRITE: / gv_char.

*TRANSLATE gv_char TO LOWER CASE.
*WRITE: / gv_char.
*
*TRANSLATE gv_char TO UPPER CASE.
*WRITE: / gv_char.


*gv_char = sy-datum.
*gv_char1 = sy-uzeit.
*
*WRITE: / gv_char.
*WRITE: / gv_char1.
*
*CONCATENATE sy-datum+6(2) sy-datum+4(2) sy-datum+0(2) INTO gv_char2 SEPARATED BY '/'.
*
*WRITE / gv_char2.

  gv_char4 = 'SAP ABAP'.
*  WRITE: / gv_char LEFT-JUSTIFIED.
  WRITE: /01 sy-uline(20).
  WRITE: /01 '|', (16) gv_char4 RIGHT-JUSTIFIED, '|'.
  WRITE: /01 sy-uline(20).

  WRITE: /01 sy-uline(20).
  WRITE: /01 '|', (16) gv_char4 LEFT-JUSTIFIED, '|'.
  WRITE: /01 sy-uline(20).

  WRITE: /01 sy-uline(20).
  WRITE: /01 '|', (16) gv_char4 CENTERED, '|'.
  WRITE: /01 sy-uline(20).


END-OF-SELECTION.