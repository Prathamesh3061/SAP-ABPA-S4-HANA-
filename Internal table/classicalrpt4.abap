*&---------------------------------------------------------------------*
*& Report Y195004R_CLASSICALRPT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT y195004r_classicalrpt.

*DEFINE STRUCTURE.
TYPES: BEGIN OF ty_emp,
         empno     TYPE y195empno,
         empnm     TYPE y195empnm,
         gender    TYPE y195gender,
         joiningdt TYPE y195joiningdt,
       END OF ty_emp.

*CREATING WORK AREA AND INTERNAL TABLE

DATA : gs_emp TYPE ty_emp,
       gt_emp TYPE STANDARD TABLE OF ty_emp.



gs_emp-empno = '1001'.
gs_emp-empnm = 'Prathamesh'.
gs_emp-gender = 'M'.
gs_emp-joiningdt = '20260701'.

APPEND gs_emp TO gt_emp.

gs_emp-empno = '1002'.
gs_emp-empnm = 'Jayant'.
gs_emp-gender = 'M'.
gs_emp-joiningdt = '20250701'.

APPEND gs_emp TO gt_emp.

gs_emp-empno = '1003'.
gs_emp-empnm = 'Kaustabh'.
gs_emp-gender = 'M'.
gs_emp-joiningdt = '20260501'.

APPEND gs_emp TO gt_emp.

*DELETE gt_emp WHERE empno = '1002'. "by using where
*DELETE gt_emp INDEX '1'.

LOOP AT gt_emp INTO gs_emp.
  WRITE : / gs_emp-empno , gs_emp-empnm , gs_emp-gender , gs_emp-joiningdt.
ENDLOOP.





*TYPES: BEGIN OF ty_emp,
*         empno       TYPE y195empno,
*         empnm       TYPE y195empnm,
*         designation TYPE y195designation,
*         salhd       TYPE y195salhd,
*         salary      TYPE y195salary,
*       END OF ty_emp.
*
*
*DATA: gs_emp TYPE ty_emp,
*      gt_emp TYPE STANDARD TABLE OF ty_emp.
*
*
*
*START-OF-SELECTION.
*
*  SELECT a~empno a~empnm a~designation
*    b~salhd b~salary
*    FROM y195m_empmst AS a INNER JOIN
*    y195m_salmst AS b
*    ON a~empno = b~empno
*    INTO CORRESPONDING FIELDS OF TABLE gt_emp.
*
*
*    LOOP AT gt_emp INTO gs_emp.
*      WRITE:/ gs_emp-empno, gs_emp-empnm , gs_emp-designation , gs_emp-salhd, gs_emp-salary.
*
*    ENDLOOP.
*
*END-OF-SELECTION.
*SKIP.
*ULINE.

*TYPES : BEGIN OF ty_sal,
*          empno  TYPE y195empno,
*          salhd  TYPE y195salhd,
*          salary TYPE y195salary,
*        END OF ty_sal.
*
*DATA : gs_sal      TYPE ty_sal,
*       gt_sal      TYPE STANDARD TABLE OF ty_sal,
*       lv_lines    TYPE i,
*       gt_temp_sal TYPE TABLE OF ty_sal.  " for collect use here define table to store new data.
*
*gs_sal-empno = '1001'.
*gs_sal-salhd = 'BAS'.
*gs_sal-salary = '10000'.
*
*APPEND gs_sal TO gt_sal.
**CLEAR gs-sal.  " use to clear the work area.
*
*gs_sal-empno = '1002'.
*gs_sal-salhd = 'HRA'.
*gs_sal-salary = '20000'.
*
*APPEND gs_sal TO gt_sal.
*
*gs_sal-empno = '1003'.
*gs_sal-salhd = 'BAS'.
*gs_sal-salary = '1000'.
*
*APPEND gs_sal TO gt_sal.
*
*gs_sal-empno = '1001'.
*gs_sal-salhd = 'HRA'.
*gs_sal-salary = '1000'.
*
*APPEND gs_sal TO gt_sal.
*
*gs_sal-empno = '1002'.
*gs_sal-salhd = 'BAS'.
*gs_sal-salary = '2000'.
*
*APPEND gs_sal TO gt_sal.
*
**use of collect
**LOOP AT gt_sal INTO gs_sal.
**  COLLECT gs_sal INTO gt_temp_sal.
**ENDLOOP.
*
*LOOP AT gt_temp_sal INTO gs_sal.
*  WRITE : / gs_sal-empno,gs_sal-salary.
*ENDLOOP.

*DESCRIBE TABLE gt_sal LINES lv_lines. " are used to get counts of lines / records.
*WRITE : / lv_lines.

* both are used  to reset the record of internal table.
*CLEAR gt_sal.
*REFRESH gt_sal.

*DESCRIBE TABLE gt_sal LINES lv_lines.
*WRITE : / lv_lines.



*MODIFY the data in all places where the given id or condition is available.

*LOOP AT gt_sal INTO gs_sal .
*  IF gs_sal-empno = '1001'.   "here made salary 30000 to empno 1001.
*    gs_sal-salary = '30000'.
*    MODIFY gt_sal FROM gs_sal TRANSPORTING salary. "after transporting add coloumn name in which you make change
*  ENDIF.
*  WRITE : / gs_sal-empno ,gs_sal-salhd,gs_sal-salary.
*ENDLOOP.

* MODIFY DATA
*gs_sal-salary = '50000'.
*MODIFY gt_sal from gs_sal INDEX 1.


*Insert is another option to to add data. we add data by using append and insert.
*Insert gs_sal into TABLE gt_sal. "insert data into table
*Insert gs_sal into gt_sal INDEX 1. " by using insert we insert data at specific index also.



*SORT gt_sal BY empno DESCENDING. " sorting data

*sorting data by two columns (Sub sorting)

*SORT gt_sal by empno salary DESCENDING.
*SORT gt_sal BY empno DESCENDING salary DESCENDING.


* read , read only first appeared data.

*READ TABLE gt_sal into gs_sal with key empno = '1002'. " reading table using key
*IF sy-subrc = 0.
*WRITE: / gs_sal-empno ,gs_sal-salhd,gs_sal-salary.
*ENDIF.

*READ TABLE gt_sal into gs_sal INDEX 4.   "reading table by using index.
*IF sy-subrc = 0.
*WRITE: / gs_sal-empno ,gs_sal-salhd,gs_sal-salary.
*ENDIF.


*print all the data prsenet in the internal table
*LOOP AT gt_sal INTO gs_sal .
*  WRITE : / gs_sal-empno ,gs_sal-salhd,gs_sal-salary.
*ENDLOOP.