*&---------------------------------------------------------------------*
*& Report Y195003R_CLASSICALRPT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT y195003r_classicalrpt.

* CODE FOR IF-ELSE STATEMENT.

*DATA : lv_input TYPE n VALUE 5.

*IF lv_input = 2.
*  WRITE : 'the output is ', lv_input.
*ELSE .
*  WRITE :/ 'the input is invalid'.
*ENDIF.

*IF lv_input = 1.
*  WRITE: 'the input is' , lv_input.
*ELSEIF lv_input = 2.
*  WRITE: 'the input is' , lv_input.
*ELSEIF lv_input = 3.
*  WRITE : 'the input is' , lv_input.
*ELSE.
*  WRITE: 'wrong input'.
*ENDIF.




* CODE FOR CASE

*DATA : gv_output TYPE i.
*
*PARAMETERS : p_num1 TYPE i,
*             p_num2 TYPE i,
*             p_sel  TYPE string.
*
*CASE p_sel.
*  WHEN 'ADD' .
*    gv_output = p_num1 + p_num2.
*    WRITE : / gv_output.
*  WHEN 'SUB' .
*    gv_output = p_num1 - p_num2.
*    WRITE : / gv_output.
*  WHEN 'MULT'.
*    gv_output = p_num1 * p_num2.
*    WRITE : / gv_output.
*  WHEN 'DIV'.
*    gv_output = p_num1 / p_num2.
*    WRITE : / gv_output.
*  WHEN 'MOD'.
*    gv_output = p_num1 MOD p_num2.
*    WRITE : / gv_output.
*  WHEN OTHERS.
*    WRITE: 'select valid option'.
*ENDCASE.


*CODE FOR DO LOOP

*PARAMETERS : lv_input TYPE i.
**
*DATA : gv_output TYPE i,
*       gv_count  TYPE i VALUE '1'.

*DO 5  TIMES.
*  DO  10 TIMES.
*    gv_output = lv_input * gv_count.
*    WRITE : / lv_input , 'X' , gv_count , '=' , gv_output.
*    gv_count = gv_count + 1.
*  ENDDO.
*  lv_input = lv_input + 1.
*ENDDO.

*DO  10 TIMES.
*  IF gv_count = 5.
**    CONTINUE.
*    SKIP.
*  ENDIF.
*  gv_output = lv_input * gv_count.
*  WRITE : / lv_input , 'X' , gv_count , '=' , gv_output.
*  gv_count = gv_count + 1.
*ENDDO.

* 2ND SYNTAX OF DO LOOP WHERE I DONT USE TIMES ITERATION INSTEAD THESE IS USE EXIT.
*DO.
*  IF gv_output = 30.
*    EXIT. "EXIT IS USED TO EXIT THE LOOP.
*  ENDIF.
*  gv_output = lv_input * gv_count.
*  WRITE: / gv_output.
*  gv_count = gv_count + 1.
*ENDDO.


*CODE FOR  WHILE LOOP
*DATA lv_input(2) TYPE n VALUE 10.
*WHILE lv_input <= 15.
*  WRITE : / 'The output is :' , lv_input.
*  lv_input = lv_input + 1.
*ENDWHILE.