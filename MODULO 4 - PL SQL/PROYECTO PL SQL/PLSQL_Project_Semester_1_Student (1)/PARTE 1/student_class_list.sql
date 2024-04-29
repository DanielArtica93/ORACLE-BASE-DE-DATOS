/* 
3. Cree un bloque anónimo que muestre todas las clases en las que se ha inscrito un estudiante en los últimos
10 años. Guarde el bloque en un archivostudent_class_list.sql. Utilizará la tabla INSCRIPCIONES. Por
ejemplo: si ejecuta su programa el 10 de mayo de 2010, debe mostrar todas las inscripciones entre mayo
10 de 2000 y 10 de mayo de 2010. Acepte STU_ID como parámetro de entrada. Para cada inscripción,
muestre ENROLLMENT_DATE, CLASSS_ID y STATUS.
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