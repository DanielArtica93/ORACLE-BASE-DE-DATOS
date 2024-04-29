/*
1. Cree un bloqueo anónimo para enumerar las inscripciones que NO tengan NI FINAL_NUMERIC_GRADE o
FINAL_LETTER_GRADE. Guarde el programa en un archivo llamado show_missing_grades.sql. Acepte start_date y
end_date para establecer un rango de fechas. Muestra solo las inscripciones entre esas 2 fechas. Escriba su programa
para que start_date y end_date sean opcionales. Si no se ingresan ambas fechas, muestre todas las inscripciones
correspondientes del año pasado e incluya una nota sobre el rango de fechas. Para cada inscripción, enumere CLASS_ID,
STU_ID y STATUS. Ordene la salida antes del ENROLLMENT_DATE con las inscripciones más recientes primero.
*/

CREATE OR REPLACE PROCEDURE show_missing_grades(start_date IN DATE := add_months(SYSDATE, -12), end_date IN DATE := SYSDATE) IS
    CURSOR student_list IS SELECT
    ENROLLMENT_DATE, CLASS_ID, STU_ID, STATUS 
    FROM 
        ENROLLMENTS 
    WHERE 
        (FINAL_NUMERIC_GRADE IS NULL OR FINAL_LETTER_GRADE IS NULL) AND ENROLLMENT_DATE BETWEEN start_date AND end_date
    ORDER BY
        ENROLLMENT_DATE;
    student_list_rec student_list%ROWTYPE;

BEGIN
    DBMS_OUTPUT.PUT_LINE('RANGO DE FECHAS: ' || start_date || ' A ' || end_date);
    FOR student_list_rec IN student_list
    LOOP
        DBMS_OUTPUT.PUT_LINE('FECHA: ' || student_list_rec.enrollment_date || ', CLASS ID: ' || student_list_rec.class_id || 
        ', ESTUDIANTE ID: ' || student_list_rec.stu_id || ', ESTADO: ' || student_list_rec.status);
    END LOOP;
END;

-- PRUEBA
BEGIN
    show_missing_grades('08/12/2004', '08/12/2004');
    show_missing_grades();
END;