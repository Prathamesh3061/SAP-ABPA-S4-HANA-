*&---------------------------------------------------------------------*
*& Report Y195R023_CLASSICALRPT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT y195r023_classicalrpt.

*here i write subroutine using parameterized perform.

PARAMETERS : p_input1 TYPE numc2,
             p_input2 TYPE numc3.

DATA : lv_output TYPE numc4.


PERFORM add USING p_input1 p_input2 CHANGING lv_output.
*here i try on master code

*&---------------------------------------------------------------------*
*& Form add
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_INPUT1
*&      --> P_INPUT2
*&      <-- LV_OUTPUT
*&---------------------------------------------------------------------*
FORM add  USING    pv_input1 TYPE numc2
                   pv_input2 TYPE numc3
          CHANGING pv_output TYPE numc4.

  pv_output = pv_input1 + pv_input2.

  WRITE : pv_output.

ENDFORM.
