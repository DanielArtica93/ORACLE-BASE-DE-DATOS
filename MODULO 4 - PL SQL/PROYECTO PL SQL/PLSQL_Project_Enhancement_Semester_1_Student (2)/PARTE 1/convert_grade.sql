/*
6. Busque el archivo llamado convert_grade.sql de MidTerm I y reescribirlo para que sea una función. Use un parámetro 
IN para ingresar la calificación numérica. DEVOLVER un valor CHAR. Utilice las siguientes reglas: A: 90 o superior, B:> 
= 80 y <90, C:> = 70 y <80, D:> = 60 y <70, F: <60.
*/
----------------------------------------------
--Solución sugerida 1
----------------------------------------------
CREATE OR REPLACE FUNCTION convert_grade
(p_numeric_grade IN NUMBER) 
RETURN varchar2 
IS
v_letter_grade CHAR(1);
BEGIN
IF p_numeric_grade >= 90.0 THEN 
 v_letter_grade := 'A';
 ELSIF p_numeric_grade >= 80.0 THEN 
 v_letter_grade := 'B';
 ELSIF p_numeric_grade >= 70.0 THEN 
 v_letter_grade := 'C';
 ELSIF p_numeric_grade >= 60.0 THEN 
 v_letter_grade := 'D';
 ELSE v_letter_grade := 'F'; 
END IF;
RETURN v_letter_grade;
END convert_grade;
----------------------------------------------
--Solución sugerida 2
----------------------------------------------
CREATE OR REPLACE FUNCTION convert_grade
(p_numeric_grade IN NUMBER) 
RETURN varchar2 
IS
v_letter_grade CHAR(1);
BEGIN
v_letter_grade :=
 CASE WHEN p_numeric_grade >= 90.0 THEN 'A'
 WHEN p_numeric_grade >= 80.0 THEN 'B'
 WHEN p_numeric_grade >= 70.0 THEN 'C'
 WHEN p_numeric_grade >= 60.0 THEN 'D'
 ELSE 'F'
 END;
RETURN v_letter_grade;
END convert_grade;
----------------------------------------------
BEGIN
 DBMS_OUTPUT.PUT_LINE(convert_grade (92));
END;
----------------------------------------------