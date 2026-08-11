*&---------------------------------------------------------------------*
*& Report Y195R011_CLASSICALRPT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT y195r011_classicalrpt.

TABLES : y195m_empmst, y195m_salmst.

DATA: gt_emp     TYPE y195t_employee,
      gs_emp     TYPE y195s_employee,
      gt_sal     TYPE y195t_salary,
      gs_sal     TYPE y195s_salary,
      gt_emp_tab TYPE TABLE OF y195m_empmst,
      gs_emp_tab TYPE y195m_empmst.

DATA : gt_fieldcat TYPE slis_t_fieldcat_alv,
       gs_fieldcat TYPE slis_fieldcat_alv,
       gt_fieldcat2 TYPE slis_t_fieldcat_alv,
       gs_fieldcat2 TYPE slis_fieldcat_alv,
       gs_layout   TYPE slis_layout_alv.



SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS : s_emp FOR y195m_empmst-empno.
SELECTION-SCREEN END OF BLOCK b1.


SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
  PARAMETERS : rb_grid RADIOBUTTON GROUP b1,
               rb_list RADIOBUTTON GROUP b1.
SELECTION-SCREEN END OF BLOCK b2.


START-OF-SELECTION.

  PERFORM get_data.

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
FORM get_data .

  DATA : lt_dept TYPE TABLE OF Y195c_deptmst,
         ls_dept TYPE Y195c_deptmst,
         lt_work TYPE TABLE OF y195c_workloc,
         ls_work TYPE y195c_workloc.

  SELECT empno
  empnm
  gender
  birthdt
  joiningdt
  phone_no
  email_id
  deptcd
  wlcd
  designation
  bankac
  banknm FROM y195m_empmst INTO CORRESPONDING FIELDS OF TABLE gt_emp_tab
    WHERE empno IN s_emp.

  IF sy-subrc = 0.

    SELECT deptcd
      deptnm
      FROM y195c_deptmst INTO CORRESPONDING FIELDS OF TABLE lt_dept
      FOR ALL ENTRIES IN gt_emp_tab
      WHERE deptcd = gt_emp_tab-deptcd.

    SELECT wlcd
      wldesc
      FROM y195c_workloc INTO CORRESPONDING FIELDS OF TABLE lt_work
      FOR ALL ENTRIES IN gt_emp_tab
      WHERE wlcd = gt_emp_tab-wlcd.

    LOOP AT gt_emp_tab INTO gs_emp_tab.
      MOVE-CORRESPONDING gs_emp_tab TO gs_emp.

      READ TABLE lt_dept INTO ls_dept WITH KEY deptcd = gs_emp_tab-deptcd.
      IF sy-subrc = 0.
        gs_emp-dept = ls_dept-deptnm.
      ENDIF.

      READ TABLE lt_work INTO ls_work WITH KEY wlcd = gs_emp_tab-wlcd.
      IF sy-subrc = 0.
        gs_emp-loc = ls_work-wldesc.
      ENDIF.

      APPEND gs_emp TO gt_emp.
      CLEAR gs_emp.
    ENDLOOP.

*SELECT
*  empno
*  salhd
*  salary
*  wears from y195m_salmst into table gt_sal
*  FOR ALL ENTRIES IN gt_emp
*  WHERE empno = gt_emp-empno.


  ENDIF.


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
CLEAR gs_fieldcat.
refresh gt_fieldcat.
  PERFORM fill_fieldcatlog.


  gs_layout-zebra = abap_true.

  IF rb_grid = abap_true.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        i_callback_program       = sy-repid
        i_callback_pf_status_set = 'PF_STATUS_SET'  "?
        i_callback_user_command  = 'USER_COMMAND'    "?
        is_layout                = gs_layout
        it_fieldcat              = gt_fieldcat
      TABLES
        t_outtab                 = gt_emp
      EXCEPTIONS
        program_error            = 1
        OTHERS                   = 2.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.


  ELSEIF rb_list = abap_true.

    CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
      EXPORTING
        i_callback_program       = sy-repid
        i_callback_pf_status_set = 'PF_STATUS_SET'  "?
        i_callback_user_command  = 'USER_COMMAND'    "?
        is_layout                = gs_layout
        it_fieldcat              = gt_fieldcat
      TABLES
        t_outtab                 = gt_emp
      EXCEPTIONS
        program_error            = 1
        OTHERS                   = 2.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

  ENDIF.

ENDFORM.


FORM pf_status_set USING rt_extab TYPE slis_t_extab. " SE41
  SET PF-STATUS 'STANDARD' EXCLUDING rt_extab.  "
ENDFORM.


FORM user_command USING
      r_ucomm like sy-ucomm
      rs_selfield TYPE slis_selfield.

  CASE r_ucomm.
    WHEN '&IC1'.  "double-click / enter on a row.
      READ TABLE gt_emp INTO gs_emp INDEX rs_selfield-tabindex.
      IF sy-subrc = 0.
        SELECT
          salhd
          salary
          waers FROM y195m_salmst INTO TABLE gt_sal
          WHERE empno = gs_emp-empno.

        PERFORM display_salary.
        rs_selfield-refresh = abap_false.
        rs_selfield-col_stable = abap_true.
        rs_selfield-row_stable = abap_true.
      ENDIF.
    WHEN OTHERS.
  ENDCASE.
ENDFORM.



*&---------------------------------------------------------------------*
*& Form fill_fieldcatlog
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM fill_fieldcatlog .
  gs_fieldcat-col_pos = '1'.
  gs_fieldcat-fieldname ='EMPNO'.
  gs_fieldcat-seltext_l ='employee number'.
  gs_fieldcat-seltext_s ='Empno'.
  gs_fieldcat-seltext_m ='Employee no'.
  gs_fieldcat-hotspot = abap_true.
  gs_fieldcat-outputlen = 4.

  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos = '2'.
  gs_fieldcat-fieldname ='EMPNM'.
  gs_fieldcat-seltext_l ='employee name'.
  gs_fieldcat-seltext_s ='Emp name'.
  gs_fieldcat-seltext_m ='Employee nm'.
  gs_fieldcat-outputlen = 30.

  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos = '3'.
  gs_fieldcat-fieldname ='GENDER'.
  gs_fieldcat-seltext_l ='gender'.
  gs_fieldcat-seltext_s ='gender'.
  gs_fieldcat-seltext_m ='gender'.
  gs_fieldcat-outputlen = 10.

  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos = '4'.
  gs_fieldcat-fieldname ='BIRTHDT'.
  gs_fieldcat-seltext_l ='birth date'.
  gs_fieldcat-seltext_s ='birthdt'.
  gs_fieldcat-seltext_m ='birth date'.
  gs_fieldcat-outputlen = 10.

  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos = '5'.
  gs_fieldcat-fieldname ='PHONE_NO'.
  gs_fieldcat-seltext_l ='phone number'.
  gs_fieldcat-seltext_s ='Phone No'.
  gs_fieldcat-seltext_m ='Phone number'.
  gs_fieldcat-outputlen = 10.

  APPEND gs_fieldcat TO gt_fieldcat.

  gs_fieldcat-col_pos = '6'.
  gs_fieldcat-fieldname ='EMAIL_ID'.
  gs_fieldcat-seltext_l ='Email id'.
  gs_fieldcat-seltext_s ='Emailid'.
  gs_fieldcat-seltext_m ='Email id'.
  gs_fieldcat-outputlen = 50.

  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos = '7'.
  gs_fieldcat-fieldname ='DEPT'.
  gs_fieldcat-seltext_l ='department'.
  gs_fieldcat-seltext_s ='dept'.
  gs_fieldcat-seltext_m ='department'.
  gs_fieldcat-outputlen = 10.

  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos = '8'.
  gs_fieldcat-fieldname ='LOC'.
  gs_fieldcat-seltext_l ='location'.
  gs_fieldcat-seltext_s ='loc'.
  gs_fieldcat-seltext_m ='location'.
  gs_fieldcat-outputlen = 10.

  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos = '9'.
  gs_fieldcat-fieldname ='DESIGNATION'.
  gs_fieldcat-seltext_l ='Designation'.
  gs_fieldcat-seltext_s ='Design'.
  gs_fieldcat-seltext_m ='Designation'.
  gs_fieldcat-outputlen = 15.

  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos = '10'.
  gs_fieldcat-fieldname ='BANKAC'.
  gs_fieldcat-seltext_l ='bank account'.
  gs_fieldcat-seltext_s ='bank acc'.
  gs_fieldcat-seltext_m ='bank account'.
  gs_fieldcat-outputlen = 20.

  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos = '11'.
  gs_fieldcat-fieldname ='BANKNM'.
  gs_fieldcat-seltext_l ='bank name'.
  gs_fieldcat-seltext_s ='bank nm'.
  gs_fieldcat-seltext_m ='bank name'.
  gs_fieldcat-outputlen = 30.

  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR gs_fieldcat.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_salary
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_salary .

*  refresh gs_fieldcat2.
  CLEAR gt_fieldcat2.

  PERFORM fill_salarycatlog.


  gs_layout-zebra = abap_true.

  IF rb_grid = abap_true.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        i_callback_program       = sy-repid
        is_layout                = gs_layout
        it_fieldcat              = gt_fieldcat2
      TABLES
        t_outtab                 = gt_sal
      EXCEPTIONS
        program_error            = 1
        OTHERS                   = 2.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.


  ELSEIF rb_list = abap_true.

    CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
      EXPORTING
        i_callback_program       = sy-repid
        is_layout                = gs_layout
        it_fieldcat              = gt_fieldcat2
      TABLES
        t_outtab                 = gt_sal
      EXCEPTIONS
        program_error            = 1
        OTHERS                   = 2.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form fill_salarycatlog
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM fill_salarycatlog .

gs_fieldcat2-col_pos = '1'.
gs_fieldcat2-fieldname = 'SALHD'.
gs_fieldcat2-seltext_l = 'Salary Head'.
gs_fieldcat2-seltext_m = 'Salary Head'.
gs_fieldcat2-seltext_s = 'SalHd'.
gs_fieldcat2-outputlen = 4.
APPEND gs_fieldcat2 to gt_fieldcat2.
CLEAR gs_fieldcat2.

gs_fieldcat2-col_pos = '2'.
gs_fieldcat2-fieldname = 'SALARY'.
gs_fieldcat2-seltext_l = 'Salary'.
gs_fieldcat2-seltext_m = 'Salary'.
gs_fieldcat2-seltext_s = 'Salary'.
gs_fieldcat2-outputlen = 20.
APPEND gs_fieldcat2 to gt_fieldcat2.
CLEAR gs_fieldcat2.

gs_fieldcat2-col_pos = '3'.
gs_fieldcat2-fieldname = 'WAERS'.
gs_fieldcat2-seltext_l = 'Currency'.
gs_fieldcat2-seltext_m = 'Currency'.
gs_fieldcat2-seltext_s = 'Curr'.
gs_fieldcat2-outputlen = 5.
gs_fieldcat2-ref_tabname = 'Y195m_salmst'.
gs_fieldcat2-ref_fieldname = 'WAERS'.
APPEND gs_fieldcat2 to gt_fieldcat2.
CLEAR gs_fieldcat2.

ENDFORM.
