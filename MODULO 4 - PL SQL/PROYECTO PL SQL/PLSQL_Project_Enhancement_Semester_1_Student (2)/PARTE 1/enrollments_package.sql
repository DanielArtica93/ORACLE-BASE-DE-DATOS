/*
8. Cree un paquete llamado enrollments_package que contendrá los procedimientos que creó en A, B y
C. Hacer públicos todos los procedimientos. Comente sus procedimientos para explicar su propósito y funcionalidad.
*/

-- Solución sugerida
-- PACKAGE SPEC

CREATE OR REPLACE PACKAGE enrollments_package
IS
-- Este procedimiento inscribirá a un estudiante en una clase.
PROCEDURE enroll_student_in_class 
 (p_stu_id IN enrollments.stu_id%TYPE,
 p_class_id IN enrollments.class_id%TYPE ) ;
 -- Este procedimiento sacará a un estudiante de una clase.
 PROCEDURE drop_student_from_class
 (p_stu_id IN enrollments.stu_id%TYPE,
 p_class_id IN enrollments.class_id%TYPE);
-- Este procedimiento enumerará a todos los estudiantes de una clase.
PROCEDURE student_class_list
 (p_stu_id IN enrollments.stu_id%TYPE);
END enrollments_package;



---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------

-- PACKAGE BODY

CREATE OR REPLACE PACKAGE BODY enrollments_package
IS
-- This procedure will enroll a student in a class.
PROCEDURE enroll_student_in_class 
 (p_stu_id IN enrollments.stu_id%TYPE,
 p_class_id IN enrollments.class_id%TYPE) 
IS
v_times_enrolled PLS_INTEGER;
e_already_enrolled EXCEPTION;
BEGIN
SELECT COUNT(*) INTO v_times_enrolled
 FROM enrollments
 WHERE class_id = p_class_id
 AND stu_id = p_stu_id;
IF v_times_enrolled <> 0
 THEN RAISE e_already_enrolled;
END IF;
INSERT INTO enrollments 
 (enrollment_date, class_id, stu_id, status)
 VALUES
 (SYSDATE, p_class_id, p_stu_id, 'Enrolled');
COMMIT;
EXCEPTION
WHEN e_already_enrolled THEN
 DBMS_OUTPUT.PUT_LINE('Student ' || p_stu_id || 
' is already enrolled in class '|| p_class_id);
END enroll_student_in_class;
-- Este procedimiento sacará a un estudiante de una clase.
PROCEDURE drop_student_from_class
 (p_stu_id IN enrollments.stu_id%TYPE,
 p_class_id IN enrollments.class_id%TYPE) 
IS
e_not_enrolled EXCEPTION;
BEGIN
DELETE FROM enrollments 
WHERE class_id = p_class_id AND stu_id = p_stu_id;
IF SQL%ROWCOUNT = 0 THEN RAISE e_not_enrolled; END IF;
COMMIT;
EXCEPTION
WHEN e_not_enrolled THEN
 DBMS_OUTPUT.PUT_LINE('Student ' || p_stu_id || 
' is not enrolled in class '|| p_class_id);
END drop_student_from_class;
-- Este procedimiento enumerará a todos los estudiantes de una clase.
PROCEDURE student_class_list
 (p_stu_id IN enrollments.stu_id%TYPE)
IS
CURSOR stu_class_cur IS
 SELECT enrollment_date, class_id, status
 FROM enrollments
 WHERE stu_id = p_stu_id
 AND enrollment_date 
 between ADD_MONTHS (SYSDATE,-120) and SYSDATE;
BEGIN
DBMS_OUTPUT.PUT_LINE('Student ' || p_stu_id || 
 ' is enrolled in the following classes:');
FOR stu_class_rec IN stu_class_cur LOOP
 DBMS_OUTPUT.PUT_LINE('Class: ' ||stu_class_rec.class_id || ' Enrolled on: ' || 
stu_class_rec.enrollment_date || 
' and has a status of: '|| stu_class_rec.status );
END LOOP;
END student_class_list;
END enrollments_package;

---------------------------------------------------------------------

SELECT * FROM enrollments;

---------------------------------------------------------------------