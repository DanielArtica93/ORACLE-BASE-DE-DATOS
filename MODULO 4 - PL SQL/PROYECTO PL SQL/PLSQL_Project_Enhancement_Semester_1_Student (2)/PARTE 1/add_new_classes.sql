/*
4. Busque el archivo llamado add_new_classes.sql de MidTerm I. Vuelva a escribirlo como un procedimiento y haga que acepte los 
siguientes parámetros IN:
una. número de clases nuevas necesarias. Establezca un valor predeterminado de 1.
B. Identificación del curso; Para cada nueva clase, use "hoy" como el START_DATE.
C. Período, para especificar qué días se reúne la clase.
D. Frecuencia, para especificar con qué frecuencia se reúne.
mi. Identificación del instructor, para especificar quién está enseñando la (s) clase (s).
*/
----------------------------------------------------------
-- Solución sugerida 1

CREATE OR REPLACE PROCEDURE add_new_classes
(p_number_new_classes IN PLS_INTEGER DEFAULT 1,
 p_course_id IN classes.course_id%TYPE,
 p_period IN classes.period%TYPE,
 p_frequency IN classes.frequency%TYPE,
 p_instr_id IN classes.instr_id%TYPE )
IS
v_current_max_class_id classes.class_id%TYPE;
BEGIN
SELECT MAX(class_id)
 INTO v_current_max_class_id
 FROM classes;
FOR loop_counter IN 1..p_number_new_classes LOOP
 INSERT INTO classes (class_id, start_date,course_id,
 period, frequency,instr_id)
 VALUES (v_current_max_class_id + loop_counter, SYSDATE, 
 p_course_id, p_period, p_frequency, p_instr_id);
 COMMIT;
END LOOP;
END add_new_classes;

-- Solución sugerida 2
----------------------------------------------------------
SELECT MAX(class_id)
FROM classes;
----------------------------------------------------------
--DROP SEQUENCE class_id_seq;
CREATE SEQUENCE class_id_seq
 START WITH 7
 INCREMENT BY 1
 NOCACHE;
----------------------------------------------------------
CREATE OR REPLACE PROCEDURE add_new_classes
(p_number_new_classes IN PLS_INTEGER DEFAULT 1,
 p_course_id IN classes.course_id%TYPE,
 p_period IN classes.period%TYPE,
 p_frequency IN classes.frequency%TYPE,
 p_instr_id IN classes.instr_id%TYPE )
IS
BEGIN
FOR loop_counter IN 1..p_number_new_classes LOOP
 INSERT INTO classes (class_id, start_date,course_id,
 period, frequency,instr_id)
 VALUES (class_id_seq.NEXTVAL,SYSDATE, p_course_id,
 p_period,p_frequency,p_instr_id);
 COMMIT;
END LOOP;
END add_new_classes;
----------------------------------------------------------

-- Agregar nuevas clases

BEGIN
 add_new_classes (2, 1001, 'Monday-Friday', 'Daily', 3003) ;
END;
----------------------------------------------------------
SELECT * FROM classes
----------------------------------------------------------