/*

Parte 3: Herramientas del administrador de la escuela (admin_tools_package)
La admin_tools_package que creó en la Parte I contiene los siguientes programas:
1. Procedimiento show_missing_grades (p_start_date IN DATE DEFAULT NULL, 
p_end_date IN DATE DEFAULT NULL)
2. Procedimiento show_class_offerings (p_start_date IN DATE, p_end_date IN DATE)
3. Función count_classes_per_course (p_course_id IN classes.course_id% TYPE) RETURN NUMBER
4. Función compute_average_grade (p_class_id IN enrollments.class_id% TYPE) RETURN NUMBER Esta 
función es privada en este paquete.
La asignación y los entregables:
1. Utilice el concepto de declaración anticipada para poder mover el cuerpo de la función privada
compute_average_grade a cualquier parte del cuerpo del paquete. Vuelva a compilar y pruebe el paquete.

*/
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--PACKAGE SPEC
CREATE OR REPLACE PACKAGE admin_tools_package
IS
-- This procedure will show missing grades for a class.
PROCEDURE show_missing_grades(p_start_date IN DATE DEFAULT NULL,
 p_end_date IN DATE DEFAULT NULL);
-- This procedure will list classes offered
PROCEDURE show_class_offerings
 (p_start_date IN DATE,
 p_end_date IN DATE);
-- This function will count the number of classes per course.
FUNCTION count_classes_per_course
 (p_course_id IN classes.course_id%TYPE) 
RETURN NUMBER;
END admin_tools_package;


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--PACKAGE BODY
CREATE OR REPLACE PACKAGE BODY admin_tools_package
IS
--This function is private in this package and it will compute 
--The average grade for a class.
--Forward Declaration 
FUNCTION compute_average_grade (p_class_id IN enrollments.class_id%TYPE) 
RETURN NUMBER;
--This procedure will show missing grades for a class.
----------------------------------------------------
PROCEDURE show_missing_grades
 (p_start_date IN DATE DEFAULT NULL,
 p_end_date IN DATE DEFAULT NULL)
IS
CURSOR no_grades_cur IS
 SELECT class_id, stu_id, status
 FROM enrollments
 WHERE final_numeric_grade IS NULL
 AND final_letter_grade IS NULL
 AND enrollment_date BETWEEN p_start_date AND
 p_end_date
 ORDER BY enrollment_date DESC;
 v_start_date DATE;
 v_end_date DATE;
BEGIN
IF p_start_date IS NULL OR p_end_date IS NULL
 THEN
 v_start_date := ADD_MONTHS(SYSDATE,-12);
 v_end_date := SYSDATE;
 DBMS_OUTPUT.PUT_LINE 
 ('You have not specified both dates. The listing will 
 show all enrollments for the past year.');
 ELSE
 v_start_date := p_start_date;
 v_end_date := P_end_date;
 END IF;
DBMS_OUTPUT.PUT_LINE 
 ('Date range: Between ' || v_start_date || ' and ' ||
 v_end_date || '.');
DBMS_OUTPUT.PUT_LINE 
('The following enrollments have no grade.');
FOR no_grades_rec IN no_grades_cur LOOP
 DBMS_OUTPUT.PUT_LINE ('Class ID ' || 
 no_grades_rec.class_id || ' – Student ID ' || 
 no_grades_rec.stu_id || ' with a status of: ' 
 ||no_grades_rec.status);
END LOOP;
END show_missing_grades;
--This procedure will list classes offered
----------------------------------
PROCEDURE show_class_offerings
 (p_start_date IN DATE,
 p_end_date IN DATE)
 
IS
v_avg_grade NUMBER;
CURSOR classes_info_cur IS
SELECT cl.class_id, cl.start_date, 
i.first_name, i.last_name, 
cour.title, cour.section_code
 FROM classes cl, courses cour, instructors i 
 WHERE start_date BETWEEN p_start_date AND p_end_date
 AND cl.course_id = cour.course_id
 AND cl.instr_id = i.instructor_id
 ORDER BY 1,2,4;
--
BEGIN
DBMS_OUTPUT.PUT_LINE 
('Date range: Between ' || p_start_date || ' AND ' || p_end_date || '.');
DBMS_OUTPUT.PUT_LINE ('Classes Information.');
FOR classes_info_rec IN classes_info_cur LOOP
v_avg_grade := compute_average_grade (classes_info_rec.class_id);
 DBMS_OUTPUT.PUT_LINE (
'Class ID ' || classes_info_rec.class_id ||
' – Average Grade '|| v_avg_grade || 
' - Start Date ' || classes_info_rec.start_date || 
' – Intructor ' || classes_info_rec.first_name || ' ' || 
classes_info_rec.last_name || 
' – Course Title '|| classes_info_rec.title || 
' – Offering Section ' || classes_info_rec.section_code );
END LOOP;
END show_class_offerings;
--This function will count the number of classes per course.
FUNCTION count_classes_per_course
(p_course_id IN classes.course_id%TYPE) 
RETURN NUMBER 
IS
v_num_classes PLS_INTEGER;
BEGIN
SELECT COUNT(*)
 INTO v_num_classes
 FROM classes
 WHERE course_id = p_course_id;
RETURN v_num_classes;
END count_classes_per_course;
FUNCTION compute_average_grade
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
END admin_tools_package;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
BEGIN
 admin_tools_package.show_class_offerings('01-08-2001','01-08-2006');
END;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------