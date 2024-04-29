/*
3. Busque el archivo llamado student_class_list.sql de MidTerm I. Vuelva a escribirlo para que sea un procedimiento que muestre
todas las clases en las que se ha inscrito un estudiante en los últimos 10 años. Por ejemplo: si ejecuta su procedimiento el 10
de mayo de 2010, debe mostrar todas las inscripciones entre el 10 de mayo de 2000 y el 10 de mayo,
2010. Acepte STU_ID como parámetro de entrada. Para cada inscripción,
muestre ENROLLMENT_DATE, CLASS_ID y STATUS.
*/

DECLARE
    CURSOR last_ten IS SELECT enrollment_date, stu_id, class_id, status FROM enrollments WHERE enrollment_date > add_months(sysdate,-120);
    last_ten_rec last_ten%ROWTYPE;

BEGIN
    FOR last_ten_rec IN last_ten
    LOOP
        DBMS_OUTPUT.PUT_LINE('Fecha de matricula: ' || last_ten_rec.enrollment_date || ', Estudiante ID:' || last_ten_rec.stu_id 
        || ', Clase ID:' || last_ten_rec.class_id || ', Estado:' || last_ten_rec.status);
    END LOOP;
END;