/*
2. Cree un bloque anónimo que convertirá una calificación numérica en una calificación en letras. Guarde su trabajo en un 
archivo llamado convert_grade.sql. Solicitar una calificación numérica. Vuelva a mostrar un valor CHAR en la pantalla. 
Utilice las siguientes reglas: A: 90 o superior, B:> = 80 y <90, C:> = 70 y <80, D:> = 60 y <70, F: <60.
*/

DECLARE
v_num NUMBER(3) := 0;
v_txt VARCHAR2(30);
BEGIN
CASE 
WHEN v_num >= 90 AND v_num <= 100 THEN v_txt := 'A';
WHEN v_num >= 80 AND v_num <90 THEN v_txt := 'B';
WHEN v_num >= 70 AND v_num <80 THEN v_txt := 'C';
WHEN v_num >= 60 AND v_num < 70 THEN v_txt := 'D';
WHEN v_num >= 0 AND v_num < 60 THEN v_txt := 'F';
ELSE v_txt := 'Ingrese valores entre 0 y 100';
END CASE;
DBMS_OUTPUT.PUT_LINE(v_txt);
END;