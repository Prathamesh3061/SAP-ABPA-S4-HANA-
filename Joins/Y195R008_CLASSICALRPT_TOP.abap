*&---------------------------------------------------------------------*
*& Include          Y195R008_CLASSICALRPT_TOP
*&---------------------------------------------------------------------*

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

*for all entries creating to structure which contains only specific data only emp ad only sal.
TYPES : BEGIN OF ty_emp2,
          empno       TYPE y195empno,
          empnm       TYPE y195empnm,
          designation TYPE y195designation,
        END OF ty_emp2.

TYPES : BEGIN OF ty_sal2,
          empno  TYPE y195empno,
          salhd  TYPE y195salhd,
          salary TYPE y195salary,
        END OF ty_sal2.

* for grouping
TYPES : BEGIN OF ty_emp1,
          empno  TYPE y195empno,
          salary TYPE y195salary,
        END OF ty_emp1.

*create work area and internal table

DATA : gs_emp  TYPE ty_emp,
       gt_emp  TYPE STANDARD TABLE OF ty_emp,
       gt_sal  TYPE STANDARD TABLE OF ty_sal,
       gs_sal  TYPE ty_sal,
       gv_emp  TYPE y195empno,  " for select options.
       gt_aggr TYPE STANDARD TABLE OF ty_emp1,  "for aggrestion, grouping and sum
       gs_aggr TYPE ty_emp1 , "for aggrestion, grouping and sum
       "for all entries
       gs_emp2 TYPE ty_emp2,
       gt_emp2 TYPE STANDARD TABLE OF ty_emp2,
       gs_sal2 TYPE  ty_sal2,
       gt_sal2 TYPE STANDARD TABLE OF ty_sal2.
