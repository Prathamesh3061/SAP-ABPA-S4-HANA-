*&---------------------------------------------------------------------*
*& Report Y195R024_CLASSICALRPT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Y195R024_CLASSICALRPT.

*here i write subroutine using parameterized perform.

PARAMETERS : p_input1 TYPE numc2,
             p_input2 TYPE numc3.

DATA : lv_output TYPE numc4.

*here i choose include type code, i dont choose master program
PERFORM add USING p_input1 p_input2 CHANGING lv_output.

WRITE : lv_output.

INCLUDE y195r024_classicalrpt_addf01.
