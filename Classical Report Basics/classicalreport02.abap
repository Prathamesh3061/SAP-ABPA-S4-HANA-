*&---------------------------------------------------------------------*
*& Report Y195002R_CLASSICALRPT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT y195002r_classicalrpt.

*created report for string operations

* declaring variable.
DATA : gv_char      TYPE string,
       gv_char1     TYPE string,
       gv_char2     TYPE string,
       lv_first     TYPE string,
       lv_last      TYPE string,
       lv_input     TYPE string VALUE '   SYSTEM   APPLICATION        AND        PROGRAMMING          ',
       lv_length(2) TYPE n,
       lv_rule(10)  TYPE c VALUE 'pPsS'. " rule for translate using rule.


CONSTANTS : cv_firstname TYPE string VALUE 'prathamesh',
            cv_lastname  TYPE string VALUE 'sawant'.

SKIP.

*CONCATENATE are used to join two different strings
WRITE : 'concatenate'.
 SKIP.
CONCATENATE cv_firstname cv_lastname INTO gv_char1 SEPARATED BY space.
WRITE gv_char1.
CONCATENATE cv_firstname cv_lastname INTO gv_char2 SEPARATED BY '-'.
WRITE / gv_char2.

SKIP.
ULINE.

*split
WRITE : 'split'.
SKIP.
SPLIT gv_char2 AT '-' INTO lv_first lv_last.
WRITE : / lv_first , / lv_last.

SKIP.
ULINE.

*condense and strlen
WRITE : 'use of condense and strlen'.
SKIP.
lv_length = strlen( lv_input ).
WRITE : / lv_input.
WRITE : / 'before condense length of string :' , lv_length.
CONDENSE lv_input.
WRITE : / lv_input.
lv_length = strlen( lv_input ).
WRITE : / 'after condense length of string :' , lv_length.
*CONDENSE lv_input NO-GAPS.
*WRITE : / lv_input.
*lv_length = strlen( lv_input ).
*WRITE : / 'after condense with no-gaps length of string :' , lv_length.

SKIP.
ULINE.

*FIND
WRITE: 'Find'.
SKIP.
FIND 'and' IN lv_input IGNORING CASE.
IF sy-subrc = 0.
  WRITE : / 'successfull', sy-subrc.
ELSE.
  WRITE : / 'uncessfull' , sy-subrc.
ENDIF.

SKIP.
ULINE.

*TRANSLATE
WRITE: 'Translate'.
SKIP.
TRANSLATE gv_char1 USING lv_rule.
WRITE : 'translate using rule : ', gv_char1.

TRANSLATE gv_char1 TO UPPER CASE.
WRITE : /  gv_char1.
TRANSLATE gv_char1 TO LOWER CASE.
WRITE: / gv_char1.


SKIP.
ULINE.

*Shift
WRITE: 'shift'.
SKIP.
WRITE : / 'before shift : ', lv_input.
SHIFT lv_input BY 4 PLACES CIRCULAR.
WRITE : / 'after circular shift: ', lv_input.

WRITE : / 'before shift :', lv_input.
SHIFT lv_input BY 4 PLACES.
WRITE: / 'by default shift:' , lv_input.

WRITE :  / 'before shift: ', lv_input.
SHIFT lv_input BY 2 PLACES RIGHT.
WRITE: / 'after right shift:', lv_input.

DATA : lv_result(10)  TYPE c VALUE '7000000000',
       lv_result1(10) TYPE c VALUE '0000000007'.

SHIFT lv_result RIGHT DELETING TRAILING '0'.
CONDENSE lv_result.
WRITE : / lv_result.

SHIFT lv_result LEFT DELETING LEADING '0'.
CONDENSE lv_result.
WRITE : / lv_result.


SKIP.
ULINE.

*String comparison operators
WRITE : 'string comparison operators'.
SKIP.
DATA : lv_string1(30) TYPE c VALUE 'System application producT',
       lv_string2(30) TYPE c VALUE 'System application product',
       lv_string3(20) TYPE c VALUE 'sonu@123',
       lv_string4(20) TYPE c VALUE '0123456789',
       lv_string5(20) TYPE c VALUE 'sawant',
       lv_string6(10) TYPE c VALUE '*@123*'.

*IF lv_string1 CO lv_string2.
*  WRITE : 'True' , sy-fdpos.
*ELSE.
*  WRITE : 'false', sy-fdpos.
*
*ENDIF.


*IF lv_string1 cn lv_string2.
*WRITE : sy-fdpos.
*else.
*  WRITE: / sy-fdpos.
*ENDIF.

IF lv_string5 CA lv_string4.
  WRITE: sy-fdpos.
ELSE.
  WRITE: / sy-fdpos.
ENDIF.

IF lv_string3 NA lv_string4.
  WRITE: sy-fdpos.
ELSE.
  WRITE: / sy-fdpos.
ENDIF.

IF lv_string3 CS lv_string5.
  WRITE: / sy-fdpos.
ELSE.
  WRITE: / sy-fdpos.
ENDIF.

IF lv_string3 NS lv_string5.
  WRITE: / sy-fdpos. "system variable
ELSE.
  WRITE: / sy-fdpos.
ENDIF.

IF lv_string3 CP lv_string6.
  WRITE: / sy-fdpos.
ELSE.
  WRITE: / sy-fdpos.
ENDIF.
