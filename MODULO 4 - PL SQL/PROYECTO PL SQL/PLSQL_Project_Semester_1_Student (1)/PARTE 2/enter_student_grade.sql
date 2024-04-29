/*
5. Cree un bloque anónimo que un profesor pueda ejecutar para insertar la calificación del alumno en una tarea en
particular. Guarde el programa en un archivo llamadoenter_student_grade.sql. Acepte NUMERIC_GRADE,
CLASS_ASSESSMENT_ID, CLASS_ID y STU_ID. Utilice la fecha de "hoy" para el DATE_TURNED_IN.
*/

-- PROCEDIMIENTO
CREATE OR REPLACE PROCEDURE enter_student_grade (v_numeric_grade class_assessments.numeric_grade%TYPE, 
                                                 v_class_assessments_id class_assessments.class_assessment_id%TYPE,
                                                 v_class_id class_assessments.class_id%TYPE,
                                                 v_stu_id class_assessments.stu_id%TYPE,
                                                 v_comments class_assessments.comments%TYPE,
                                                 v_assessments_id class_assessments.assessment_id%TYPE) AS
BEGIN
  INSERT INTO CLASS_ASSESSMENTS(CLASS_ASSESSMENT_ID, DATE_TURNED_IN, NUMERIC_GRADE, COMMENTS, CLASS_ID, STU_ID, ASSESSMENT_ID) 
  VALUES (v_class_assessments_id, SYSDATE, v_numeric_grade, v_comments, v_class_id, v_stu_id, v_assessments_id);
END

-- PRUEBA
BEGIN
    enter_student_grade (100, 101, 1, 102, 'EXCELENTE', 1);
END;