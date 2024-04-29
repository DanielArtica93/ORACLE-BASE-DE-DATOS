/*
3. Cree un bloque anónimo para mostrar el número de clases ofrecidas para un curso determinado. Guarde el programa
en un archivo llamado count_classes_per_course.sql.
*/

DECLARE
    CURSOR student_list IS SELECT
    COUNT(*) COUNT, COURSE_ID FROM CLASSES GROUP BY COURSE_ID;
    student_list_rec student_list%ROWTYPE;
BEGIN
    FOR student_list_rec IN student_list
    LOOP
        DBMS_OUTPUT.PUT_LINE('CURSO ID: ' || student_list_rec.course_id || ', CANTIDAD DE CLASES: ' || student_list_rec.count);
    END LOOP;
END;