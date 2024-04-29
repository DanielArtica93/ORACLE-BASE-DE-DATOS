/*
10. Busque el archivo llamado enter_student_grade.sql y reescribirlo como un procedimiento que un maestro puede ejecutar para 
insertar la calificación del estudiante en una tarea en particular. Acepta NUMERIC_GRADE,
CLASS_ASSESSMENT_ID, CLASS_ID, STU_ID y ASSESSMENT_ID como parámetros IN. Utilice la 
fecha de "hoy" para el DATE_TURNED_IN.
*/
-----------------------------------------------------------
--Solución sugerida
-----------------------------------------------------------

CREATE OR REPLACE PROCEDURE enter_student_grade
 (p_cl_assessment_id IN 
 class_assessments.class_assessment_id%TYPE,
 p_numeric_grade IN class_assessments.numeric_grade%TYPE,
 p_class_id IN class_assessments.class_id%TYPE,
 p_stu_id IN class_assessments.stu_id%TYPE,
 p_assessment_id IN class_assessments.assessment_id%TYPE)
IS
BEGIN
INSERT INTO class_assessments 
 (class_assessment_id, date_turned_in, numeric_grade, 
 class_id, stu_id, assessment_id)
 VALUES 
 (p_cl_assessment_id, SYSDATE, p_numeric_grade,p_class_id, 
 p_stu_id, p_assessment_id);
COMMIT;
END enter_student_grade;

-----------------------------------------------------------

BEGIN
 Enter_student_grade(102,87,1,101,1);
END;

-----------------------------------------------------------

SELECT * FROM class_assessments;

-----------------------------------------------------------