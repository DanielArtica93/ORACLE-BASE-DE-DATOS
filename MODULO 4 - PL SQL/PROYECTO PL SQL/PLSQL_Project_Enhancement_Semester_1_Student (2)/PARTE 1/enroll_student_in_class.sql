/* 1. Busque el archivo guardado desde el llamado enroll_student_in_class.sql de MidTerm I. Convierta esto en un
procedimiento y haga que acepte STU_ID y CLASS_ID como parámetros de entrada. Use "fecha de hoy" para
ENROLLMENT_DATE y la cadena "Enrolled" para STATUS. Plantee una excepción si el estudiante aceptado ya está
inscrito en la clase aceptada. En su controlador de excepciones, muestre un mensaje que indique que el estudiante ya
está inscrito en la clase.
*/

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