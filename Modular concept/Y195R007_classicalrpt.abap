*&---------------------------------------------------------------------*
*& Report Y195R007_CLASSICALRPT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT y195r007_classicalrpt.

*Define structure

TYPES : BEGIN OF ty_emp,
          empno       TYPE y195empno,
          empnm       TYPE y195empnm,
          designation TYPE y195designation,
          salhd       TYPE y195salhd,
          salary      TYPE y195salary,
        END OF ty_emp.

TYPES : BEGIN OF ty_sal,
          empno       TYPE y195empno,
          empnm       TYPE y195empnm,
          designation TYPE y195designation,
          salary      TYPE y195salary,
        END OF ty_sal.

*create work area and internal table

DATA : gs_emp TYPE ty_emp,
       gt_emp TYPE STANDARD TABLE OF ty_emp,
       gt_sal TYPE STANDARD TABLE OF ty_sal,
       gs_sal TYPE ty_sal,
       gv_emp TYPE y195empno. " for select options.


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

*  PARAMETERS: p_empno TYPE y195empno.  " here we select only one parameter

SELECT-OPTIONS : s_empno for gv_emp.


SELECTION-SCREEN END OF BLOCK b1.

*INITIALIZATION.

TOP-OF-PAGE.
WRITE: / 'Employee Report'.
SKIP.
ULINE.

START-OF-SELECTION.

*  why create this

  PERFORM get_data.  "first step
  PERFORM process_data. "third step

END-OF-SELECTION.

  PERFORM display_data.

*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data . "second step

*  data: lv_designation TYPE y195designation.

*for single record.

*  SELECT a~empno a~empnm a~designation
*    b~salhd b~salary
*    FROM y195m_empmst AS a INNER JOIN
*    Y195m_salmst AS b
*    ON a~empno = b~empno
*    INTO CORRESPONDING FIELDS OF TABLE gt_emp
*    WHERE a~empno = p_empno.


* for selecting single data
*if you want to use only work area
DATA : lv_empno TYPE Y195empno.
*
lv_empno = s_empno. " dont no why used.

*why and how to use ?

SELECT SINGLE a~empno a~empnm a~designation   "I EXECUTES ONLY FIRST DATA IN THE DATABASE
    b~salhd b~salary
    FROM y195m_empmst AS a INNER JOIN
    Y195m_salmst AS b
    ON a~empno = b~empno
    INTO gs_emp
    WHERE a~empno = s_empno.


*selecting HRA in salhd.  IF YOU WANT PICK SPECIFIC DATA IN The database then use AND in WHERE.
*SELECT SINGLE a~empno a~empnm a~designation  "why and how to use ?
*    b~salhd b~salary
*    FROM y195m_empmst AS a INNER JOIN
*    Y195m_salmst AS b
*    ON a~empno = b~empno
*    INTO gs_emp
*    WHERE a~empno = p_empno
*  AND b~salhd = 'HRA'.

*SELECT SINGLE designation  " use when you want to fectch only one field from the database.
*  FROM y195m_empmst into lv_designation
*  where empno = p_empno.

*for get multiple parameters

*  SELECT a~empno a~empnm a~designation
*    b~salhd b~salary
*    FROM y195m_empmst AS a INNER JOIN
*    Y195m_salmst AS b
*    ON a~empno = b~empno
*    INTO TABLE gt_emp
*    WHERE a~empno in s_empno
*    ORDER BY a~empno DESCENDING.

ENDFORM.

FORM process_data. "forth stp
  LOOP AT gt_emp INTO gs_emp.
    MOVE-CORRESPONDING gs_emp TO gs_sal.
    COLLECT gs_sal INTO gt_sal.
  ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_data .

*for single record.

  LOOP AT gt_sal INTO gs_sal.

    AT FIRST.
      WRITE :/ 'empno', 6 'empnm', 37 'designation', 75 'salary' .
    ENDAT.

    WRITE: / gs_emp-empno , gs_emp-empnm, gs_emp-designation, gs_emp-salary CENTERED.
  ENDLOOP.

*To display the output of selection range of employee
*    LOOP AT gt_emp INTO gs_emp.
*
*    AT FIRST.
*      WRITE :/ 'empno', 6 'empnm', 37 'designation', 75 'salary' .
*    ENDAT.
*
*    WRITE: / gs_emp-empno , gs_emp-empnm, gs_emp-designation, gs_emp-salary CENTERED.
*  ENDLOOP.
ENDFORM.