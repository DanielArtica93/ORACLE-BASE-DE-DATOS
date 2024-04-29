/*
15. Cree un paquete llamado admin_tools_package incorporando el procedimiento y las funciones que
escribió en los pasos K a N.Haga público lo siguiente: show_missing_grades, show_class_offerings,
count_classes_per_course. Hacer privado lo siguiente: compute_average_grade.
*/

--PACKAGE SPEC
CREATE OR REPLACE PACKAGE admin_tools_package
IS
PROCEDURE show_missing_grades (p_start_date IN DATE DEFAULT ADD_MONTHS(SYSDATE,-12),p_end_date IN DATE DEFAULT SYSDATE);

PROCEDURE show_class_offerings (p_start_date IN DATE, p_end_date IN DATE);

FUNCTION count_classes_per_course (p_course_id IN classes.course_id%TYPE) RETURN NUMBER;

END admin_tools_package;

--PACKAGE BODY
CREATE OR REPLACE PACKAGE BODY admin_tools_package IS

FUNCTION compute_average_grade (p_class_id IN enrollments.class_id%TYPE) RETURN NUMBER IS v_avg_grade enrollments.final_numeric_grade%TYPE;
    BEGIN
    SELECT AVG(final_numeric_grade)
    INTO v_avg_grade
    FROM enrollments
    WHERE class_id = p_class_id;
    RETURN v_avg_grade;
END compute_average_grade;

PROCEDURE show_missing_grades (p_start_date IN DATE DEFAULT ADD_MONTHS(SYSDATE,-12), p_end_date IN DATE DEFAULT SYSDATE) IS
    CURSOR no_grades_cur IS
    SELECT class_id, stu_id, status
    FROM enrollments
    WHERE final_numeric_grade IS NULL
    AND final_letter_grade IS NULL
    AND enrollment_date BETWEEN p_start_date AND p_end_date
    ORDER BY enrollment_date DESC;
    BEGIN
        IF p_start_date IS NULL OR p_end_date IS NULL
            THEN
            DBMS_OUTPUT.PUT_LINE('No ha especificado ambas fechas. La lista mostrará todas las inscripciones del año pasado..');
        END IF;
    DBMS_OUTPUT.PUT_LINE('Rango de fecha: ' || p_start_date || ' --- ' || p_end_date || '.');
    DBMS_OUTPUT.PUT_LINE('Las siguientes inscripciones no tienen calificación.');
    FOR no_grades_rec IN no_grades_cur LOOP
    DBMS_OUTPUT.PUT_LINE ('Class ID ' || no_grades_rec.class_id || ' – Student ID ' || no_grades_rec.stu_id || ' with a status of: ' ||no_grades_rec.status);
    END LOOP;
END show_missing_grades;

PROCEDURE show_class_offerings (p_start_date IN DATE, p_end_date IN DATE) IS v_avg_grade NUMBER;
    CURSOR classes_info_cur IS
    SELECT cl.class_id, cl.start_date, i.first_name, i.last_name, cour.title, cour.section_code
    FROM classes cl, courses cour, instructors i
    WHERE start_date BETWEEN p_start_date and p_end_date AND cl.course_id = cour.course_id AND cl.instr_id = i.instructor_id
    ORDER BY 1,2,4;
    BEGIN
    DBMS_OUTPUT.PUT_LINE ('Rango de fecha: ' || p_start_date || ' --- ' || p_end_date || '.');
    DBMS_OUTPUT.PUT_LINE('Información de las clases.'); 
    FOR classes_info_rec IN classes_info_cur LOOP
    v_avg_grade := compute_average_grade(classes_info_rec.class_id);
    DBMS_OUTPUT.PUT_LINE ('Clase ID ' || classes_info_rec.class_id ||' – Nota media '|| v_avg_grade ||' - Fecha inicio ' || classes_info_rec.start_date ||
    ' – Instructor ' || classes_info_rec.first_name || ' ' || classes_info_rec.last_name || ' – Curso '|| classes_info_rec.title ||
    ' – Sección ' || classes_info_rec.section_code );
    END LOOP;
END show_class_offerings;

FUNCTION count_classes_per_course(p_course_id IN classes.course_id%TYPE) RETURN NUMBER IS v_num_classes PLS_INTEGER;
    BEGIN
    SELECT COUNT(*)
    INTO v_num_classes
    FROM classes
    WHERE course_id = p_course_id;
    RETURN v_num_classes;
END count_classes_per_course;

END admin_tools_package;