SELECT E.F_NAME, E.L_NAME, JH.START_DATE
  FROM EMPLOYEES E 
INNER JOIN JOB_HISTORY JH 
ON E.EMP_ID = JH.EMPL_ID
  WHERE E.DEP_ID = '5'
  ORDER BY E.F_NAME;


SELECT E.F_NAME, E.L_NAME, JH.START_DATE, J.JOB_TITLE
  FROM EMPLOYEES E
INNER JOIN JOB_HISTORY JH ON E.EMP_ID = JH.EMPL_ID
INNER JOIN JOBS J ON E.JOB_ID = J.JOB_IDENT
  WHERE E.DEP_ID = '5'
  ORDER BY E.F_NAME;


SELECT E.EMP_ID, E.L_NAME, E.DEP_ID, D.DEP_NAME
  FROM EMPLOYEES E 
LEFT OUTER JOIN DEPARTMENTS D ON E.DEP_ID = D.DEPT_ID_DEP;

SELECT E.EMP_ID, E.L_NAME, E.DEP_ID, D.DEP_NAME
  FROM EMPLOYEES E 
LEFT OUTER JOIN DEPARTMENTS D ON E.DEP_ID = D.DEPT_ID_DEP
  WHERE YEAR(E.B_DATE) < 1980;


SELECT E.EMP_ID, E.L_NAME, E.DEP_ID, D.DEP_NAME
  FROM EMPLOYEES E 
LEFT OUTER JOIN DEPARTMENTS D ON E.DEP_ID = D.DEPT_ID_DEP AND YEAR(E.B_DATE) < 1980;

SELECT E.F_NAME, E.L_NAME, D.DEP_NAME
  FROM EMPLOYEES E FULL OUTER JOIN DEPARTMENTS D 
ON E.DEP_ID = D.DEPT_ID_DEP; 


SELECT E.F_NAME, E.L_NAME, D.DEP_NAME, E.DEP_ID
  FROM EMPLOYEES E FULL OUTER JOIN DEPARTMENTS D 
ON E.DEP_ID = D.DEPT_ID_DEP AND E.SEX = 'M';


SELECT *
  FROM JOB_HISTORY;

SELECT *
  FROM EMPLOYEES;

SELECT *
  FROM DEPARTMENTS;

SELECT *
  FROM JOBS;

