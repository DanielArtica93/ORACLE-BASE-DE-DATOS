/*
11. Vuelva a escribir el programa almacenado en el archivo. show_missing_grades.sql ser un procedimiento. Acepte start_date y end_date para establecer un rango de fechas. Muestra solo las inscripciones entre esas dos fechas. Escriba su procedimiento
para que start_date y end_date sean opcionales. Si no se ingresan ambas fechas, muestre todas las inscripciones
correspondientes del año pasado e incluya una nota sobre el rango de fechas. Para cada inscripción, enumere CLASS_ID,
STU_ID y STATUS. Ordene la salida antes del ENROLLMENT_DATE con las inscripciones más recientes primero.
*/

CREATE OR REPLACE PROCEDURE show_missing_grades(p_start_date IN DATE DEFAULT NULL, p_end_date IN DATE DEFAULT NULL) IS
    CURSOR no_grades_cur IS
    SELECT class_id, stu_id, status
    FROM enrollments
    WHERE final_numeric_grade IS NULL
    AND final_letter_grade IS NULL
    AND enrollment_date BETWEEN p_start_date AND p_end_date
    ORDER BY enrollment_date DESC;
    v_start_date DATE;
    v_end_date DATE;
    BEGIN
        IF p_start_date IS NULL OR p_end_date IS NULL
    THEN
        v_start_date := ADD_MONTHS(SYSDATE,-12);
        v_end_date := SYSDATE;
        DBMS_OUTPUT.PUT_LINE('No ha especificado ambas fechas. La lista mostrará todas las inscripciones del año pasado.');
    ELSE
    v_start_date := p_start_date;
    v_end_date := P_end_date;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Rango de fecha: entre ' || v_start_date || ' y ' || v_end_date || '.');
    DBMS_OUTPUT.PUT_LINE('Las siguientes inscripciones no tienen calificación.');
    FOR no_grades_rec IN no_grades_cur LOOP
        DBMS_OUTPUT.PUT_LINE ('Estudiante ID ' || no_grades_rec.class_id || ', Estudiante ID ' || no_grades_rec.stu_id || ', Estado: ' ||no_grades_rec.status);
    END LOOP;
    END show_missing_grades;