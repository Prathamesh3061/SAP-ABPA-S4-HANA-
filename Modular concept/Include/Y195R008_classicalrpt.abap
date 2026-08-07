*&---------------------------------------------------------------------*
*& Report Y195R008_CLASSICALRPT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Y195R008_CLASSICALRPT.

INCLUDE y195R008_classicalrpt_top.
INCLUDE y195R008_classicalrpt_sel.

START-OF-SELECTION.

*  why create this

  PERFORM get_data.  "first step
  PERFORM process_data. "third step

END-OF-SELECTION.

  PERFORM display_data.


INCLUDE y195R008_classicalrpt_data.