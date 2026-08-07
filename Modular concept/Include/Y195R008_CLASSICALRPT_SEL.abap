*&---------------------------------------------------------------------*
*& Include          Y195R008_CLASSICALRPT_SEL
*&---------------------------------------------------------------------*


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

*  PARAMETERS: p_empno TYPE y195empno.  " here we select only one parameter

SELECT-OPTIONS : s_empno for gv_emp.


SELECTION-SCREEN END OF BLOCK b1.