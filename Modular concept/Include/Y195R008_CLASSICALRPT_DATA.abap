*&---------------------------------------------------------------------*
*& Include          Y195R008_CLASSICALRPT_DATA
*&---------------------------------------------------------------------*


FORM get_data . "second step

*  data: lv_designation TYPE y195designation.
*
*  SELECT a~empno a~empnm a~designation
*    b~salhd b~salary
*    FROM y195m_empmst AS a INNER JOIN
*    Y195m_salmst AS b
*    ON a~empno = b~empno
*    INTO CORRESPONDING FIELDS OF TABLE gt_emp
*    WHERE a~empno = p_empno.


* for selecting single data
*if you want to use only work area
*DATA : lv_empno TYPE Y195_empno.
*
*lv_empno = p_empno. " dont no why used.

*SELECT SINGLE a~empno a~empnm a~designation   I EXECUTES ONLY FIRST DATA IN THE DATABASE
"why and how to use ?
*    b~salhd b~salary
*    FROM y195m_empmst AS a INNER JOIN
*    Y195m_salmst AS b
*    ON a~empno = b~empno
*    INTO gs_emp
*    WHERE a~empno = p_empno.


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


FORM display_data .
*  LOOP AT gt_sal INTO gs_sal.
*
*    AT FIRST.
*      WRITE :/ 'empno', 6 'empnm', 37 'designation', 75 'salary' .
*    ENDAT.
*
*    WRITE: / gs_emp-empno , gs_emp-empnm, gs_emp-designation, gs_emp-salary CENTERED.
*  ENDLOOP.

To display the output of selection range of employee
    LOOP AT gt_emp INTO gs_emp.

    AT FIRST.
      WRITE :/ 'empno', 6 'empnm', 37 'designation', 75 'salary' .
    ENDAT.

    WRITE: / gs_emp-empno , gs_emp-empnm, gs_emp-designation, gs_emp-salary CENTERED.
  ENDLOOP.
ENDFORM.