*&---------------------------------------------------------------------*
*& Report Y195006R_CLASSICALRPT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Y195006R_CLASSICALRPT.


*CODE FOR DO LOOP

PARAMETERS : lv_input TYPE i.

DATA : gv_output TYPE i,
       gv_count  TYPE i VALUE '1'.

DO 5  TIMES.
  DO  10 TIMES.
    gv_output = lv_input * gv_count.
    WRITE : / lv_input , 'X' , gv_count , '=' , gv_output.
    gv_count = gv_count + 1.
  ENDDO.
  WRITE: / .
  lv_input = lv_input + 1.
ENDDO.

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
*    EXIT.       "EXIT IS USED TO EXIT THE LOOP.
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