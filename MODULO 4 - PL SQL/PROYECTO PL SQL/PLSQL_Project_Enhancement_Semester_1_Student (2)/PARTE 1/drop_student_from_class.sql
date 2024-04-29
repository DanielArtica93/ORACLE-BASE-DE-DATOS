/*
2. Busque el archivo llamado drop_student_from_class.sql de MidTerm I. Conviértalo en un procedimiento que acepte STU_ID y 
CLASS_ID como parámetros de entrada. Si ELIMINAR falla porque el estudiante no está en la clase, genere una excepción 
definida por el usuario para mostrar un mensaje que indique que el estudiante no está en la clase.
*/
----------------------------
CREATE OR REPLACE PROCEDURE drop_student_from_class
 (p_stu_id IN enrollments.stu_id%TYPE,
 p_class_id IN enrollments.class_id%TYPE) 
IS
e_not_enrolled EXCEPTION;
BEGIN
DELETE FROM enrollments 
 WHERE class_id = p_class_id AND stu_id = p_stu_id;
IF SQL%ROWCOUNT = 0 THEN
 RAISE e_not_enrolled;
 END IF;
COMMIT;
EXCEPTION
 WHEN e_not_enrolled THEN
 DBMS_OUTPUT.PUT_LINE('El estudiante ' || p_stu_id ||
 ' no está matriculado en la clase '|| p_class_id);
END drop_student_from_class;
----------------------------
BEGIN
 drop_student_from_class(104, 1);
END;
----------------------------
select * from enrollments