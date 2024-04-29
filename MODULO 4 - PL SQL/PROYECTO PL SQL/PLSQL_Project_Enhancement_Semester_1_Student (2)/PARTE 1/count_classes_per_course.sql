/*
13. Busque el archivo llamado count_classes_per_course.sql y reescribirlo como una función. Acepta
un COURSE_ID. Devuelva el número de clases ofrecidas para ese curso.
*/

CREATE OR REPLACE FUNCTION count_classes_per_course (p_course_id IN classes.course_id%TYPE)
    RETURN NUMBER IS v_num_classes PLS_INTEGER;
    BEGIN
    SELECT COUNT(*)
    INTO v_num_classes
    FROM classes
    WHERE course_id = p_course_id;
    RETURN v_num_classes;
END count_classes_per_course;