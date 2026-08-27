*&---------------------------------------------------------------------*
*& Report Y195R023_CLASSICALRPT_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Y195R023_CLASSICALRPT_01.

PARAMETERS : p_input1 TYPE numc2,
             p_input2 TYPE numc3.

DATA : lv_output TYPE numc4.

PERFORM add IN PROGRAM y195r023_classicalrpt USING p_input1 p_input2 CHANGING lv_output IF FOUND.
*above use if found- for if i change my subroutine name then it gives runtime error so use if found.

*WRITE : lv_output.
