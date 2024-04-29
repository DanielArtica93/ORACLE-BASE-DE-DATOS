
--DROP TABLE new_classes;

CREATE TABLE new_classes AS SELECT * FROM classes;

SELECT * from new_classes
ORDER BY class_id asc;

-- Lunes y miercoles se esta impartiendo por el instructor 3001
--asignar martes 3002, jueves 3003, viernes 3004, sabado 3005

DECLARE
 v_max_class_id     new_classes.class_id%TYPE;
 v_class_id        new_classes.class_id%TYPE;
BEGIN
 SELECT MAX(class_id) INTO v_max_class_id
 FROM new_classes;
v_class_id := v_max_class_id + 1;
INSERT INTO new_classes (class_id, start_date, period, frequency, instr_id, course_id)
VALUES (v_class_id, SYSDATE, 'Martes', 'Semanal', 3002, 1001);
 DBMS_OUTPUT.PUT_LINE('El mayor valor de class id es: ' || v_max_class_id);
 DBMS_OUTPUT.PUT_LINE('Se ha insertado la fila: ' || (v_max_class_id+1));
END;

------------------------------------------------------
SELECT * from new_classes
ORDER BY class_id asc;
------------------------------------------------------

DECLARE
 v_max_class_id     new_classes.class_id%TYPE;
 v_class_id        new_classes.class_id%TYPE;
BEGIN
 SELECT MAX(class_id) INTO v_max_class_id
 FROM new_classes;
v_class_id := v_max_class_id + 1;
INSERT INTO new_classes (class_id, start_date, period, frequency, instr_id, course_id)
VALUES (v_class_id, SYSDATE, 'Jueves', 'Semanal', 3003, 1001);
 DBMS_OUTPUT.PUT_LINE('El mayor valor de class id es: ' || v_max_class_id);
DBMS_OUTPUT.PUT_LINE('Se ha insertado la fila: ' || (v_max_class_id+1));
END;

------------------------------------------------------
SELECT * from new_classes
ORDER BY class_id asc;
------------------------------------------------------

DECLARE
 v_max_class_id     new_classes.class_id%TYPE;
 v_class_id        new_classes.class_id%TYPE;
BEGIN
 SELECT MAX(class_id) INTO v_max_class_id
 FROM new_classes;
v_class_id := v_max_class_id + 1;
INSERT INTO new_classes (class_id, start_date, period, frequency, instr_id, course_id)
VALUES (v_class_id, SYSDATE, 'Viernes', 'Semanal', 3004, 1001);
 DBMS_OUTPUT.PUT_LINE('El mayor valor de class id es: ' || v_max_class_id);
 DBMS_OUTPUT.PUT_LINE('Se ha insertado la fila: ' || (v_max_class_id+1));
END;


------------------------------------------------------
SELECT * from new_classes
ORDER BY class_id asc;
------------------------------------------------------

DECLARE
 v_max_class_id     new_classes.class_id%TYPE;
 v_class_id        new_classes.class_id%TYPE;
BEGIN
 SELECT MAX(class_id) INTO v_max_class_id
 FROM new_classes;
v_class_id := v_max_class_id + 1;
INSERT INTO new_classes (class_id, start_date, period, frequency, instr_id, course_id)
VALUES (v_class_id, SYSDATE, 'Sabado', 'Semanal', 3005, 1001);
 DBMS_OUTPUT.PUT_LINE('El mayor valor de class id es: ' || v_max_class_id);
 DBMS_OUTPUT.PUT_LINE('Se ha insertado la fila: ' || (v_max_class_id+1));
END;


------------------------------------------------------
SELECT * from new_classes
ORDER BY class_id asc;
------------------------------------------------------

DECLARE
 v_max_class_id     new_classes.class_id%TYPE;
 v_class_id        new_classes.class_id%TYPE;
BEGIN
 SELECT MAX(class_id) INTO v_max_class_id
 FROM new_classes;
v_class_id := v_max_class_id + 1;
INSERT INTO new_classes (class_id, start_date, period, frequency, instr_id, course_id)
VALUES (v_class_id, SYSDATE, 'Seis', 'Semanal', 3003, 1002);
 DBMS_OUTPUT.PUT_LINE('El mayor valor de class id es: ' || v_max_class_id);
 DBMS_OUTPUT.PUT_LINE('Se ha insertado la fila: ' || (v_max_class_id+1));
END;

------------------------------------------------------
SELECT * from new_classes
WHERE class_id = 11;
------------------------------------------------------