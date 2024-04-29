/*
5. Busque el archivo llamado course_roster.sql de MidTerm I y reescribirlo como un procedimiento. Acepte
INSTR_ID y COURSE_ID como parámetros de entrada. Para cada INSCRIPCIÓN, muestre: CLASS_ID,
STATUS, Student FIRST_NAME y LAST_NAME.
*/

CREATE OR REPLACE PROCEDURE course_roster (p_instr_id IN classes.instr_id%TYPE, p_course_id IN classes.course_id%TYPE) IS
    CURSOR stu_course_cur IS
        SELECT e.class_id, e.status, s.first_name, s.last_name
        FROM enrollments e, classes c, students s
        WHERE e.class_id = c.class_id
        AND e.stu_id = s.stu_id
        AND c.course_id = p_course_id
        AND c.instr_id = p_instr_id;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Curso ' || p_course_id ||' tiene los siguientes estudiantes:');
        FOR stu_course_rec IN stu_course_cur LOOP
            DBMS_OUTPUT.PUT_LINE('Clase: ' || stu_course_rec.class_id || ' Estudiante: '|| stu_course_rec.first_name || ' ' || stu_course_rec.last_name ||' Estado: ' || stu_course_rec.status );
        END LOOP;
    END course_roster;
    
BEGIN
course_roster(3003, 1002);
END;