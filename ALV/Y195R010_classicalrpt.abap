
          .
          .
*&---------------------------------------------------------------------*
*& Report Y195R010_CLASSICALRPT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
          REPORT y195r010_classicalrpt.

          DATA : gt_emp TYPE TABLE OF y195m_empmst,
                 gs_emp TYPE y195m_empmst,
                 gt_sal TYPE TABLE OF y195m_salmst,
                 gs_sal TYPE y195m_salmst.

          DATA : gt_fieldcat TYPE slis_t_fieldcat_alv,
                 gs_fieldcat TYPE slis_fieldcat_alv,
                 gs_layout   TYPE slis_layout_alv.


          SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
            PARAMETERS : p_emp TYPE y195empno.
          SELECTION-SCREEN END OF BLOCK b1.

          SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
            PARAMETERS: p_grid RADIOBUTTON GROUP g1,
                        p_list RADIOBUTTON GROUP g1.
          SELECTION-SCREEN END OF BLOCK b2.

          INITIALIZATION.

          START-OF-SELECTION.
            PERFORM get_data.

          END-OF-SELECTION.

            PERFORM display_data.



*         CALL FUNCTION 'Y195FM_EMPLOYEE_DATA'
*           EXPORTING
*             iv_empno = p_emp
*           TABLES
*             t_emp    = gt_emp
*             t_sal    = gt_sal.

*            LOOP AT gt_emp INTO gs_emp .
*              WRITE : / gs_emp-empno, gs_emp-empnm.
*            ENDLOOP.
*
*            LOOP AT gt_sal INTO gs_sal.
*              WRITE: / gs_sal-salhd, gs_sal-salary.
*            ENDLOOP.
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
          FORM get_data .
            CALL FUNCTION 'Y195FM_EMPLOYEE_DATA'
              EXPORTING
                iv_empno = p_emp
              TABLES
                t_emp    = gt_emp
                t_sal    = gt_sal.
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

            gs_layout-zebra = abap_true.
*            gs_layout-colwidth_optimize = abap_true.

            PERFORM fill_fieldcatlog.

            IF p_grid = abap_true.

              CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
                EXPORTING
                  i_callback_program = sy-repid
                  is_layout          = gs_layout
                  it_fieldcat        = gt_fieldcat
                TABLES
                  t_outtab           = gt_emp
                EXCEPTIONS
                  program_error      = 1
                  OTHERS             = 2.
              IF sy-subrc <> 0.
* Implement suitable error handling here
              ENDIF.


            ELSEIF p_list = abap_true.

              CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
                EXPORTING
                  i_callback_program = sy-repid
                  is_layout          = gs_layout
                  it_fieldcat        = gt_fieldcat
                TABLES
                  t_outtab           = gt_emp
                EXCEPTIONS
                  program_error      = 1
                  OTHERS             = 2.
              IF sy-subrc <> 0.
* Implement suitable error handling here
              ENDIF.

            ENDIF.

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
            gs_fieldcat-fieldname ='DEPTCD'.
            gs_fieldcat-seltext_l ='department code'.
            gs_fieldcat-seltext_s ='dept'.
            gs_fieldcat-seltext_m ='department cd'.
            gs_fieldcat-outputlen = 10.

            APPEND gs_fieldcat TO gt_fieldcat.
            CLEAR gs_fieldcat.

            gs_fieldcat-col_pos = '8'.
            gs_fieldcat-fieldname ='WLCD'.
            gs_fieldcat-seltext_l ='location code'.
            gs_fieldcat-seltext_s ='locCD'.
            gs_fieldcat-seltext_m ='location code'.
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