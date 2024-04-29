/*
12. Busque el archivo llamado compute_average_grade.sql y reescribirlo como una función. Acepte un CLASS_ID. 
Devuelve la nota media.
*/
---------------------------------------------------------
-- Solución sugerida
---------------------------------------------------------

CREATE OR REPLACE FUNCTION compute_average_grade
(p_class_id IN enrollments.class_id%TYPE) 
RETURN NUMBER 
IS
v_avg_grade enrollments.final_numeric_grade%TYPE;
BEGIN
SELECT AVG(final_numeric_grade)
 INTO v_avg_grade
 FROM enrollments
 WHERE class_id = p_class_id;
RETURN v_avg_grade;
END compute_average_grade;

---------------------------------------------------------

DECLARE
v_grade NUMBER;
BEGIN
v_grade := compute_average_grade(6);
DBMS_OUTPUT.PUT_LINE(v_grade);
END;

---------------------------------------------------------