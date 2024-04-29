/*
1. Cree un bloque anónimo que un profesor pueda ejecutar para ver a los estudiantes de un curso en todas las
clases de ese curso. Guarde el bloque en un archivo llamadocourse_roster.sql. Acepte INSTR_ID y COURSE_ID
como parámetros de entrada. Para cada INSCRIPCIÓN, muestre: CLASS_ID, STATUS, Student FIRST_NAME y
LAST_NAME.
*/

CREATE OR REPLACE PROCEDURE course_roster(p_instr_id IN classes.instr_id%TYPE, p_course_id IN classes.course_id%TYPE) IS
    CURSOR student_list IS SELECT
    ENROLLMENTS.CLASS_ID, ENROLLMENTS.STATUS, STUDENTS.FIRST_NAME, STUDENTS.LAST_NAME 
    FROM 
        STUDENTS, ENROLLMENTS, CLASSES
    WHERE STUDENTS.STU_ID = ENROLLMENTS.STU_ID AND ENROLLMENTS.CLASS_ID = CLASSES.CLASS_ID
    AND CLASSES.INSTR_ID = p_instr_id AND CLASSES.COURSE_ID = p_course_id;
    student_list_rec student_list%ROWTYPE;
BEGIN
    FOR student_list_rec IN student_list
    LOOP
        DBMS_OUTPUT.PUT_LINE('ESTUDIANTE ID: ' || student_list_rec.class_id || ', ESTADO: ' || student_list_rec.status || 
        ', NOMBRE COMPLETO: ' || student_list_rec.first_name || ' ' ||student_list_rec.last_name);
    END LOOP;
END;