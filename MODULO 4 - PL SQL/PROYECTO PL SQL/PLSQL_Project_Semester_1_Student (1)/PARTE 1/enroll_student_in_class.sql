/* 1. Cree un bloque PL / SQL anónimo para inscribir a un estudiante en una clase en particular. Asegúrese de que
los estudiantes lo guarden en un archivo llamadoenroll_student_in_class.sql. Utilizará la tabla
INSCRIPCIONES. Acepte STU_ID y CLASS_ID como parámetros de entrada. Use "fecha de hoy" para
ENROLLMENT_DATE y la cadena "Enrolled" para STATUS. Sugerencia: para que su programa solicite los
valores de STU_ID y CLASS_ID, haga lo siguiente:
DECLARAR
v_stu_id enrollments.stu_id% TYPE: =: student_id; v_class_id
enrollments.class_id% TYPE): =: class_id;*/

CREATE OR REPLACE PROCEDURE inscripcion (v_stu_id enrollments.stu_id%TYPE, v_class_id enrollments.class_id%TYPE) AS
BEGIN
  INSERT INTO ENROLLMENTS(ENROLLMENT_DATE, CLASS_ID, STU_ID, STATUS) VALUES (SYSDATE, v_class_id, v_stu_id, 'Enrolled');
END

DECLARE
v_stu_id enrollments.stu_id%TYPE := :student_id; 
v_class_id enrollments.class_id%TYPE := :class_id;
BEGIN
    inscripcion(v_stu_id, v_class_id);
END;