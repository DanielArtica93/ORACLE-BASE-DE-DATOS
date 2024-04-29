/*
2. Cree un bloqueo anónimo para sacar a un estudiante de una clase. Guarde el bloque en un archivo llamado
drop_student_from_class.sql. Utilizará la tabla INSCRIPCIONES. Acepte STU_ID y CLASS_ID como parámetros de 
entrada. Incluya el código para confirmar los identificadores de estudiante y de clase de la entrega. Si no se descartan 
las inscripciones, muéstrelo en su lugar.
Copyright © 2020, Oracle y / o sus afiliados. Reservados todos los derechos. Oracle y Java son marcas comercial
*/

DROP TABLE excep_estud;

CREATE TABLE excep_estud AS SELECT * FROM enrollments;

SELECT * FROM excep_estud;

DECLARE
 v_stu_id enrollments.stu_id%TYPE;
 v_class_id enrollments.class_id%TYPE;
 v_enrollment_date enrollments.enrollment_date%TYPE;
 e_no_hay_estudiantes EXCEPTION;
 e_no_filas_borradas EXCEPTION;
 v_count NUMBER;
BEGIN
 v_stu_id := 101;
 v_class_id := 1;
  SELECT COUNT(*) INTO v_count
 FROM excep_estud
 WHERE stu_id = v_stu_id and class_id = v_class_id;
 IF v_count = 0 THEN
 RAISE e_no_hay_estudiantes;
 END IF;
 DBMS_OUTPUT.PUT_LINE('Hay ' || v_count || ' estudiantes');
 DELETE FROM excep_estud
 WHERE stu_id = v_stu_id and class_id = v_class_id;
 IF SQL%NOTFOUND THEN
 RAISE e_no_filas_borradas;
 END IF;
 DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' El estudiante fue eliminado');
 EXCEPTION
 WHEN e_no_hay_estudiantes THEN
 DBMS_OUTPUT.PUT_LINE ('No hay estudiantes');
 WHEN e_no_filas_borradas THEN
 DBMS_OUTPUT.PUT_LINE ('Ninguna fila fue borrada de la tabla excep_estud');
END;