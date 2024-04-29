/*
2. Cree un bloque anónimo para encontrar la calificación promedio de una clase. Guarde el programa en un archivo llamado
compute_average_grade .sql. Suponga que la clase ha utilizado numeric_grades. Acepte un CLASS_ID. Muestra 
la nota media.
*/

DECLARE
v_class_id classes.class_id%TYPE;
v_nota1 NUMBER;
v_nota2 NUMBER;
v_nota3 NUMBER;
v_prom FLOAT;
BEGIN
v_class_id := 1;
v_nota1 := 85;
v_nota2 := 80;
v_nota3 := 80;
v_prom := (v_nota1 + v_nota2 + v_nota3)/3;
DBMS_OUTPUT.PUT_LINE('Id de clase: ' || v_class_id || ', promedio: ' || v_prom);
END;