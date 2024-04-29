/*
14. Convierta el archivo show_class_offerings.sql a un procedimiento. Acepte una fecha de inicio y una fecha de finalización. Para 
cada clase encontrada, muestre CLASS_ID, START_DATE, instructor FIRST_NAME y LAST_NAME, curso TITLE y SECTION_CODE, 
y calificación promedio. Encuentre la calificación promedio mediante una llamada a la función
compute_average_grade.
*/

-- Solución sugerida

CREATE OR REPLACE PROCEDURE show_class_offerings
 (p_start_date IN DATE,
 p_end_date IN DATE)
IS
v_avg_grade NUMBER;
CURSOR classes_info_cur IS
 SELECT cl.class_id, cl.start_date, 
 i.first_name, i.last_name, 
 cour.title, cour.section_code
 FROM classes cl, courses cour, instructors i
 WHERE start_date BETWEEN p_start_date AND p_end_date
 AND cl.course_id = cour.course_id
 AND cl.instr_id = i.instructor_id
 ORDER BY 1,2,4;
BEGIN
DBMS_OUTPUT.PUT_LINE 
 ('Date range: Between ' || p_start_date || ' and ' ||
 p_end_date || '.');
DBMS_OUTPUT.PUT_LINE 
 ('Classes Information.');
FOR classes_info_rec IN classes_info_cur LOOP
 -- call the compute_average_grade function
 v_avg_grade := compute_average_grade (classes_info_rec.class_id);
 DBMS_OUTPUT.PUT_LINE (
'Class ID ' || classes_info_rec.class_id ||
' – Average Grade '|| v_avg_grade || 
' - Start Date ' || classes_info_rec.start_date || 
' – Instructor ' || classes_info_rec.first_name || ' ' || classes_info_rec.last_name || 
' – Course Title '|| classes_info_rec.title || 
' – Offering Section ' || classes_info_rec.section_code );
END LOOP;
END show_class_offerings;

---------------------------------------------------------------------------------------

BEGIN 
 show_class_offerings('01-08-2001','01-08-2006');
END;

---------------------------------------------------------------------------------------