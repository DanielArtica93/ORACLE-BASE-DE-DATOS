/*
3. Cree un bloque anónimo que muestre el número de estudiantes en una clase en particular. Guarde su trabajo en un
archivo llamadostudent_count.sql. Acepte CLASS_ID como parámetro.
*/

CREATE OR REPLACE PROCEDURE students_count(p_class_id IN enrollments.class_id%TYPE) IS
    CURSOR student_list IS SELECT
    COUNT(*) COUNT FROM ENROLLMENTS WHERE CLASS_ID = p_class_id; 
    student_list_rec student_list%ROWTYPE;
BEGIN
    FOR student_list_rec IN student_list
    LOOP
        DBMS_OUTPUT.PUT_LINE('CANTIDAD DE ESTUDIANTES PERTENECIENTES A LA CLASE ' || p_class_id || ': ' || student_list_rec.count);
    END LOOP;
END;

--Prueba
BEGIN
    students_count(1);
END;