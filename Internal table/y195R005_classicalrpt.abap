*&---------------------------------------------------------------------*
*& Report Y195005R_CLASSICALRPT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT y195005r_classicalrpt.

*define Structure
TYPES : BEGIN OF ty_emp,
          empno     TYPE y195empno,
          empnm     TYPE y195empnm,
          gender    TYPE y195gender,
          joiningdt TYPE y195joiningdt,
        END OF ty_emp.

* define work area and internal table
DATA : gs_emp TYPE ty_emp,
       gt_emp TYPE STANDARD TABLE OF ty_emp.


*add data to work area and internal table.

gs_emp-empno = '1005'.
gs_emp-empnm = 'Prathamesh'.
gs_emp-gender = 'M'.
gs_emp-joiningdt = '20260101'.

INSERT gs_emp INTO TABLE gt_emp.

gs_emp-empno = '1006'.
gs_emp-empnm = 'Ramjan'.
gs_emp-gender = 'M'.
gs_emp-joiningdt = '20250101'.

INSERT gs_emp INTO TABLE gt_emp.

gs_emp-empno = '1004'.
gs_emp-empnm = 'Sourabh'.
gs_emp-gender = 'M'.
gs_emp-joiningdt = '20251201'.

INSERT gs_emp INTO TABLE gt_emp.

gs_emp-empno = '1001'.
gs_emp-empnm = 'Kirti'.
gs_emp-gender = 'F'.
gs_emp-joiningdt = '20240101'.

INSERT gs_emp INTO TABLE gt_emp.

gs_emp-empno = '1003'.
gs_emp-empnm = 'Hema'.
gs_emp-gender = 'f'.
gs_emp-joiningdt = '20230512'.

INSERT gs_emp INTO TABLE gt_emp.

gs_emp-empno = '1002'.
gs_emp-empnm = 'Vinod'.
gs_emp-gender = 'M'.
gs_emp-joiningdt = '20241015'.

INSERT gs_emp INTO TABLE gt_emp.

*sort the table

SORT gt_emp BY empno.





*READ TABLE gt_emp INTO gs_emp with key empno = '1004' BINARY SEARCH.
*IF sy-subrc = 0.
*WRITE : / gs_emp-empno, gs_emp-empnm, gs_emp-gender , gs_emp-joiningdt.
*ENDIF.

* use loop control events
LOOP AT gt_emp INTO gs_emp .


*CONTINUE

*  IF gs_emp-empno = 1003.
*    CONTINUE.   "continue will skip the given condition record and execute next record.
*  ENDIF.

*EXIT

*  IF gs_emp-empnm = 'Sourabh'.
*    EXIT.   "exit are stop the loop and exit the loop when condition will true.
*  ENDIF.

*CHECK

*CHECK gs_emp-gender = 'M'.  " it writes only data which meet the condition.



*  AT FIRST

*  AT FIRST. "loop control events
*    WRITE : 'empno' ,8 'empnm', 34 'gender' ,40 'joiningdt'.
*  ENDAT.

*AT NEW

*  At NEW gender.
*    WRITE : / 'gender' , gs_emp-gender.
*    ENDAT.


    WRITE : / gs_emp-empno, gs_emp-empnm, gs_emp-gender , gs_emp-joiningdt.
  ENDLOOP.