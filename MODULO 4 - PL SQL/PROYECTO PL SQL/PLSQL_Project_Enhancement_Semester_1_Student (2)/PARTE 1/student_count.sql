/*
7. Busque el archivo llamado student_count.sql y reescribirlo como una función que REGRESARÁ el número de
estudiantes en una clase en particular. Acepte CLASS_ID como parámetro IN.
*/

CREATE OR REPLACE FUNCTION student_count (p_class_id IN classes.class_id%TYPE) RETURN NUMBER IS
    v_student_count PLS_INTEGER;
    BEGIN
        SELECT COUNT(*) INTO v_student_count FROM enrollments WHERE class_id = p_class_id;
        RETURN v_student_count;
    END student_count;

SELECT class_id, student_count(class_id) AS "Cantidad de estudiantes", stu_id FROM enrollments;