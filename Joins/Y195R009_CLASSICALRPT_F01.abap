*&---------------------------------------------------------------------*
*& Include          Y195R009_CLASSICALRPT_F01
*&---------------------------------------------------------------------*

*SELECT a~empno a~empnm a~designation
*  b~salhd b~salary
*  FROM y195m_empmst AS a
*  LEFT OUTER JOIN y195m_salmst AS b
*  ON a~empno = b~empno
*  INTO TABLE gt_emp.
*
*IF sy-subrc = 0.
*  WRITE: / 'left outer join'.
*  ULINE.
*  LOOP AT gt_emp INTO gs_emp.
*    WRITE: / gs_emp-empno , gs_emp-empnm , gs_emp-designation , gs_emp-salhd, gs_emp-salary.
*  ENDLOOP.
*ENDIF.
*
*ULINE.
*
*SELECT a~empno a~empnm a~designation
*b~salhd b~salary
*FROM y195m_empmst AS a
*INNER JOIN y195m_salmst AS b
*ON a~empno = b~empno
*INTO TABLE gt_emp.
*
*IF sy-subrc = 0.
*  WRITE: / 'inner join'.
*  ULINE.
*  LOOP AT gt_emp INTO gs_emp.
*    WRITE: / gs_emp-empno , gs_emp-empnm , gs_emp-designation , gs_emp-salhd, gs_emp-salary.
*  ENDLOOP.
*ENDIF.
*
*ULINE.
*
*SELECT a~empno, a~empnm, a~designation,
*b~salhd, b~salary
*FROM y195m_salmst AS b
*RIGHT OUTER JOIN y195m_empmst AS a
*ON a~empno = b~empno
*INTO TABLE @gt_emp.
*
*IF sy-subrc = 0.
*  WRITE: / 'right outer join'.
*  ULINE.
*  LOOP AT gt_emp INTO gs_emp.
*    WRITE: / gs_emp-empno , gs_emp-empnm , gs_emp-designation , gs_emp-salhd, gs_emp-salary.
*  ENDLOOP.
*ENDIF.

*ULINE.

* Used to grouping and here used sum aggreation for total salary of employees.

*WRITE : / 'Grouping'.
*
*SELECT a~empno,
*  SUM( b~salary ) as tot_salary
*  FROM y195m_empmst AS a
*  INNER JOIN y195m_salmst AS b
*  ON a~empno = b~empno
*  INTO TABLE @DATA(gt_sum)
*  GROUP BY a~empno.
*
*LOOP AT gt_sum INTO gs_aggr.
*  WRITE: / gs_aggr-empno, gs_aggr-salary.
*ENDLOOP.


*insert data form the code and commit and rollback
*in work area we can update only single record and by the use of internal record we update multiple record.

*DATA: ls_emp TYPE y195m_empmst.

*ls_emp-empno = '2004'.
*ls_emp-empnm = 'Pranali'.
*ls_emp-gender = 'F'.
*ls_emp-birthdt = '20030101'.
*ls_emp-joiningdt = '20260620'.
*ls_emp-phone_no = '9922403410'.
*ls_emp-email_id = 'pranali99@gmail.com'.
*ls_emp-deptcd = '01'.
*ls_emp-wlcd = 'Uk'.
*ls_emp-designation = 'Finance head'.
*ls_emp-bankac = '160310510003223'.
*ls_emp-banknm = 'SBI'.
*
*INSERT Y195m_empmst FROM ls_emp.
*IF sy-subrc = 0.
*COMMIT WORK.
**ROLLBACK WORK.
*ENDIF.

*Update the database.
*UPDATE Y195m_empmst
*set joiningdt = '20230101'
*WHERE empno = '1001'.
*IF sy-subrc = 0.
*COMMIT WORK.
*ENDIF.
*
*Write: 'data updated.'.

*Delete data from the database.
*DELETE FROM y195m_empmst
*WHERE empno = '2004'.
*IF sy-subrc = 0.
*COMMIT WORK.
*ENDIF.
*
*Write: 'data updated.'.

*max and count
*data: gv_max_deptcd type string,
*      gv_count TYPE i.
*
*SELECT max( deptcd )
*  from Y195m_empmst
*  into gv_max_deptcd.
*
*  WRITE: / gv_max_deptcd.
*
*  SELECT COUNT(*)
*    from Y195m_empmst
*    into gv_count
*    where deptcd = '2'.
*
*    WRITE: / gv_count.

*Learning for all entries

*SELECT empno empnm designation
*  FROM Y195m_empmst
*  INTO TABLE gt_emp2.
*
*IF gt_emp2 IS NOT INITIAL.
*
*  SELECT empno salhd salary
*    FROM y195m_salmst INTO TABLE gt_sal2
*    FOR ALL ENTRIES IN gt_emp2
*    WHERE empno = gt_emp2-empno.
*ENDIF.


**use for loop inside for loop.
*LOOP AT gt_emp2 INTO gs_emp2.
*
*  LOOP AT gt_sal2 INTO gs_sal2 WHERE empno = gs_emp2-empno.
*
*
*
*    READ TABLE gt_sal2 INTO gs_sal2 WITH KEY empno = gs_emp2-empno.
**IF sy-subrc = 0.
*    WRITE : / gs_emp2-empno, gs_emp2-empnm, gs_emp2-designation, gs_sal2-salhd, gs_sal2-salary.
*  ENDLOOP.
**ENDIF.
*ENDLOOP.
*
*WRITE : / 'data'.

**How to use describe  . describe is used to gives count of rows present in table.
*Data : lv_count TYPE i,
*      lv_count2 TYPE i.
*
*DESCRIBE TABLE gt_emp2 LINES lv_count.
*DESCRIBE TABLE gt_sal2 LINES lv_count2.
*
*WRITE : / lv_count.
*WRITE : / lv_count2.

**Union

SELECT empno , empnm, designation
  from y195m_empmst
  UNION
SELECT empno , empnm, designation
  from y182m_empmst
  into TABLE @gt_emp2.

  LOOP AT gt_emp2 into gs_emp2.
WRITE : / gs_emp2-empno , gs_emp2-empnm , gs_emp2-designation.
  ENDLOOP.
