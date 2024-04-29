/*
2. Cree un activador de nivel de fila audit_grade_change para mantener un historial de todos los cambios realizados en la 
calificación final de los estudiantes. El cambio de calificación se registra cada vez que se actualiza el campo 
FINAL_LETTER_GRADE en la tabla INSCRIPCIONES.
• Cada vez que se activa el disparador, debe insertar un registro en la tabla GRADE_CHANGE_HISTORY, 
registrando la calificación anterior y la nueva para cada alumno.
• Pruebe su activador actualizando el final_letter_grade para un estudiante, en la 
tabla INSCRIPCIONES.
*/
-----------------------------------------------------------------
--Trigger Code
-----------------------------------------------------------------
CREATE OR REPLACE TRIGGER audit_grade_change
AFTER UPDATE OF final_letter_grade ON enrollments 
FOR EACH ROW
BEGIN
INSERT INTO grade_change_history(time_stamp,stu_id, class_id, 
 enroll_date, old_final_grade, new_final_grade)
 VALUES(SYSDATE, 
:OLD.stu_id, 
:OLD.class_id,
:OLD.enrollment_date,
:OLD.final_letter_grade,
:NEW.final_letter_grade);
END;

-----------------------------------------------------------------
UPDATE enrollments
 SET final_letter_grade = 'A'
 WHERE stu_id = 101;
-----------------------------------------------------------------
SELECT * FROM grade_change_history;
-----------------------------------------------------------------